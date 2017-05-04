;+
; NAME:
;       q_z_bin_vX_xx.pro
;
; PURPOSE:
;       To calculated redshift distribution fits to SDSS DR5 Quasar
;       data, in order to produce an equivalent redshift distribtion 
;       the randoms catalogues needed to do correlation functions. 
;
; EXPLANATION:
;
; CALLING SEQUENCE:
;       .run q_z_bin_v1_01.pro
;
; INPUTS:
;       None.
;
; OPTIONAL INPUTS:
;       None.
;
; KEYWORD PARAMETERS:
;       n/a
;
; OUTPUTS:
;       various
;
; OPTIONAL OUTPUTS:
;       also various
;
; COMMON BLOCKS:
;       None.
;
; RESTRICTIONS:
;
; PROCEDURES CALLED:
;
; EXAMPLES:
;
; COMMENTS:
;
; NOTES:
;
; MODIFICATION HISTORY:
;       Version 1.00  NPR       ~15th October 2007
;       Version 1.01  NPR       ~20th October 2007
;               Generates N(z) for `homogeneous' DR5 quasars. ;
;       Version 1.02  NPR       ~20th December 2007
;               Produces random ra, decs and redshifts. Plots random N(z)
;       Version 1.03  NPR        18th January 2008
;               Produces ra,dec,z,rc writing to DR5QSO_uni_data.dat
;               and randoms_npr.dat for F90 program. Introduced
;               cosmology depedence.
;-



;  PROPERLY COMMENT THIS AT SOME POINT IN THE V. NEAER FUTURE!!


No_bin = 60                ;; 0.05 bins for redshift z=0->3...
x       = fltarr(No_bin)
y       = fltarr(No_bin)
z_bin   = fltarr(No_bin)
z_bin_width = 0.05

print
readcol, '../maindr5spectro.par', $
         drplatemj, plate, mjd, tile, plate_ra, plate_dec, programName, $
         programType, release, $
         format='(a, i, i, i, d,d, a,i,a)'
print, 'READ-IN maindr5spectro.par', n_elements(plate)
print
;maindr5spectro.par 1268   cf.  maindr5spectro_full.par 1280




print
choice='P'
;read, choice, PROMPT='UNIFORMS or PRIMARY?? U/P   '
print


if choice eq 'U' then begin
   print, 'UNIFORM'
   print
   print
   data   = mrdfits('../data/DR5QSO_uni_data.fits', 1)
   random = mrdfits('DR5QSO_uni_random_RADEC.fits', 1)
   
   print
;   help, data, /str
   print
   help, data.ra
   help, data.dec
   help, data.z
   
   indx_z_cut29 = where(data.z le 2.9, N_z_cut29)
   indx_z_cut25 = where(data.z le 2.5, N_z_cut25)
   indx_z_cut22 = where(data.z le 2.2, N_z_cut22)
   
   print
   print, 'N_z_cut2, z<=2.9', N_z_cut29
   print, 'N_z_cut,  z<=2.5', N_z_cut25
   print, 'N_z_cut,  z<=2.2', N_z_cut22
   
;   data_z_cut = data[indx_z_cut].z
   data_z_cut = data[indx_z_cut22]
   print
   help, data_z_cut
   help, data_z_cut.z
   
   openw, 11, 'DR5QSO_uni_data_temp.dat'
   for i=0L, N_elements(data.z)-1 do begin
      lumd = lumdist(data[i].z, H0=100, Omega_M=0.24, Lambda0=0.76, /SILENT)
      rc = lumd / (1.+data[i].z)
      printf, 11, data[i].ra, data[i].dec, data[i].z, rc
   endfor
   close, 11

   for i=0L, n_elements(data_z_cut.z) -1  do begin
      d = fix((data_z_cut[i].z) * (1./z_bin_width))
;      print, i, data_z_cut[i].z, d
      z_bin(d) = z_bin(d) + 1
   endfor

endif



radius = 1.49                   ; SDSS Plate radius 
if choice eq 'P' then begin
   print, '  PRIMARY '
   print
   print
   data   = mrdfits('../data/dr5qso.fits', 1)
;   random = mrdfits('ra_dec_randoms_20080307.fits', 1)
   random = mrdfits('ra_dec_randoms_npr.fits', 2)
;   Made by make_ra_dec_randoms.pro for the PRIMARY case...



   
   indx_PRI   = where( ((data.TS_T_QSO     eq 1) or $
                        (data.TS_T_HIZ     eq 1) or $
                        (data.TS_T_FIRST   eq 1)) ,  N_TS_T_PRI)
   print, 'PRIMARYs', N_TS_T_PRI
   print
                
;   print, 'PRIMARYs le 2.90', N_TS_T_PRI 
   indx_PRIz22  = where( ((data.TS_T_QSO     eq 1) or $
                          (data.TS_T_HIZ     eq 1) or $
                          (data.TS_T_FIRST   eq 1) and ( $
                          (data.z            ge 0.30) and $
                          (data.z            le 2.20))),  N_TS_T_PRIz22)
   print, 'PRIMARYs 0.30 < z < 2.20', N_TS_T_PRIz22
   
   data_ra_pri         = data[indx_PRIz22].ra
   data_dec_pri        = data[indx_PRIz22].dec
   data_z_pri          = data[indx_PRIz22].z
   
   plate_dec_rad  = (!dpi/180.) *(plate_dec)
   plate_rmax = radius/(cos(plate_dec_rad))
   plate_rmin = radius
   
   openw, 11, 'DR5QSO_pri_data_temp.dat'
   for i=0L, n_elements(data_ra_pri)-1 do begin
      first =  (( data_ra_pri[i] -  plate_ra )^2)/(plate_rmax^2)
      second = ((data_dec_pri[i] - plate_dec )^2)/(plate_rmin^2)
      dist = first+second
      indx = where(dist le 1.00, N)
;      IMPOSE PLATE CUTS, SUCH THAT WE'RE NOT LOOKING AT e.g. chunk78
       
      if N ge 1 then begin
         lumd=lumdist(data_z_pri[i], H0=100, Omega_M=0.24,Lambda0=0.76, /SILENT)
         rc = lumd / (1. + data_z_pri[i])
         printf, 11, data_ra_pri[i], data_dec_pri[i], data_z_pri[i], rc
         
         d = fix((data_z_pri[i]  ) * (1./z_bin_width))
         z_bin(d) = z_bin(d) + 1
      endif
   endfor
   close, 11
endif
   






openw, 9, 'z_values.dat' 
printf, 9, '#  i,        z_bin,        no. ' 
for i=0L, No_bin-1 do begin
   printf, 9, i, (float(i*z_bin_width)), fix(z_bin(i))
   x[i] = (float(i*z_bin_width))
   y[i] = fix(z_bin(i))
endfor
close, 9   
help, x 
help, y
; x should be a given redshift (from the data)
; y should be the number of objects at that corresponding redshift,
; from the data





print
result = poly_fit(x,y,10, chisq=red_chi) 
;print, result
;for i=0L,10 do print, 'a',i , ' = ', result[i]
print, 'chi^2', red_chi
print


;fit = (result[6]*x^6) + (result[5]*x^5) + (result[4]*x^4) +
;      (result[3]*x^3) + (result[2]*x^2) + (result[1]*x) + (result[0])

fit1 = (result[10]*x^10) + (result[9]*x^9) + (result[8]*x^8) + $
       (result[7]*x^7) + (result[6]*x^6) + (result[5]*x^5) + $
       (result[4]*x^4) + (result[3]*x^3) + (result[2]*x^2) + $
       (result[1]*x)   + (result[0]) 

fit = fit1

;print, 'fit3 = ((', result[10], ')*x^6) + ( (', result[11],')*x^5) + $
;((',result[12],')*x^4) + ((',result[13],')*x^3) + $
;((',result[14],')*x^2) + ((',result[15],')*x) + ', result[16]

;x = x+0.075 
; shifting the fit along the x-axis to the left by e.g. 0.075 redshift units
; N.B. This is mearly for plotting purposes. The actual random N(z)
; distribution will/would have to be changed below.

fit[0] = 0.0001
indx_fit = where(fit gt 0, N_fit)
fit = fit(indx_fit)



j=0L
random_z = fltarr(1000000)
if choice eq 'U' then norm=1146.
;if choice eq 'P' then norm=1644. ;for z_max=2.9
if choice eq 'P' then norm=1500. ;for z_max=2.2
REPEAT BEGIN
   trial = randomu(s) 
   prob =  randomu(s)
;   z_trial = (trial * 2.900)  
   z_trial = (trial * 1.900)  + 0.300
   
;   z1=(result[6]*z_trial^6) + (result[5]*z_trial^5) + (result[4]*z_trial^4) + $
;      (result[3]*z_trial^3) + (result[2]*z_trial^2) + (result[1]*z_trial) + $
;      (result[0])
   
   z2=(result[10]*z_trial^10) + (result[9]*z_trial^9) + (result[8]*z_trial^8) + $
      (result[7]*z_trial^7) + (result[6]*z_trial^6) + (result[5]*z_trial^5) + $
      (result[4]*z_trial^4) + (result[3]*z_trial^3) + (result[2]*z_trial^2) + $
      (result[1]*z_trial)   + (result[0]) 
   
   if (prob lt (z2 / norm)) then begin
      random_z[j] = z_trial
      j = j+1
   endif
ENDREP UNTIL j eq 1000000
;ENDREP UNTIL j eq 100000



sp = replicate({ra: 0D, dec: 0D, z: 0D}, 1000000)
sp.ra  = random.ra
sp.dec = random.dec
sp.z   = random_z
;mwrfits, sp, 'randoms_npr_temp.fits'


choice_two = 'y'
;read, choice_two, PROMPT='  Make randoms_npr_temp.dat?   y/n    '
if choice_two eq 'y' then begin
   print, 'MAKING RANDOMS_NPR_TEMP.DAT......'
   openw, 10, 'randoms_npr_temp.dat'
   for i=0L, 999999 do begin
;   lumd = lumdist(sp[i].z, H0=100, /SILENT)
      lumd = lumdist(sp[i].z, H0=100, Omega_M=0.24, Lambda0=0.76,   /SILENT)
      rc=lumd/(1.+sp[i].z)
      printf, 10, sp[i].ra, sp[i].dec, sp[i].z, rc
   endfor
   close, 10
endif





!p.multi=0
loadct, 6
set_plot, 'ps'
device, filename='SDSS_Quasar_Nofz.ps', $
        xsize=8, ysize=8, xoffset=0, yoffset=0, /inches, /color
;plothist, data_z_cut.z, bin=0.05, xrange=[-0.05, 2.6];

plot, x,(z_bin), xthick=6, ythick=6, xcharsize=2.2, ycharsize=2.2, $
      xstyle=1, ystyle=1, xrange=[-0.05, 3.2], yrange=[0,2500], $
      thick=7, color=0, $
      xtitle='reshift, z', ytitle='Number of objects', $
      /nodata, $
      position=[0.20,0.12,0.98,0.98]
plothist,  data_z_pri, bin=z_bin_width, /overplot, color=0, thick=7
;oplot, x, y, color= 64

;oplot, x, fit,  color=128
oplot, (x+0.15), fit,  color=128, linestyle=2
;oplot, x, (fit*30.29), color=192
xyouts, 2.1, 1700, "x^10 poly fit", charsize=2.2, charthick=3, color=128


if choice eq 'U' then begin
   plothist, sp[0:33700].z, bin=z_bin_width, /overplot, color=192
   plothist, random_z[33700:67400], bin=z_bin_width, /overplot, color=64
   xyouts, 2.1, 2000, 'Randoms', charsize=2.2, charthick=3, color=64
   xyouts, 2.1, 1900, "sp.z", charsize=2.2, charthick=3, color=192
   xyouts, 2.1, 2100, "UNI (x,z_bin)", charsize=2.2, charthick=6, color=0
endif
if choice eq 'P' then begin
;   plothist, sp[0:44347].z, bin=z_bin_width, /overplot, color=192
;   plothist, random_z[44347:88748], bin=z_bin_width, /overplot, color=64
;   plothist, sp[88748:134208].z, bin=z_bin_width, /overplot, color=176
;   plothist, random_z[134208:178944], bin=z_bin_width, /overplot, color=48
;   plothist, sp[178944:223680].z, bin=z_bin_width, /overplot, color=208
;   plothist, random_z[223680:268416], bin=z_bin_width, /overplot, color=80

   plothist, random_z, bin=z_bin_width, /overplot, color=80, peak=norm
   xyouts, 2.1, 2000, 'Randoms', charsize=2.2, charthick=3, color=192
   xyouts, 2.1, 1900, "sp.z", charsize=2.2, charthick=3, color=64
   xyouts, 2.1,  2100, "PRI (x,z_bin)", charsize=2.2, charthick=3, color=0
endif


device, /close
set_plot, 'X'


close, /all
end
