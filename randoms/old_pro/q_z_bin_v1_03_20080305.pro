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

print
choice='P'
read, choice, PROMPT='UNIFORMS or PRIMARY?? U/P   '

if choice eq 'U' then begin
   print
   data   = mrdfits('../data/DR5QSO_uni_data.fits', 1)
   random = mrdfits('DR5QSO_uni_random_RADEC.fits', 1)
   
   print
;   help, data, /str
   print
   help, data.ra
   help, data.dec
   help, data.z

   indx_z_cut25 = where(data.z le 2.5, N_z_cut25)
   indx_z_cut29 = where(data.z le 2.9, N_z_cut29)
   
   print
   help, indx_z_cut25
   help, indx_z_cut29
   print, 'N_z_cut,  z<=2.5', N_z_cut25
   print, 'N_z_cut2, z<=2.9', N_z_cut29
   
;   data_z_cut = data[indx_z_cut].z
   data_z_cut = data[indx_z_cut29]
   
   print
   help, data_z_cut
   help, data_z_cut.z
   
   openw, 11, 'DR5QSO_uni_data.dat'
   for i=0L, N_elements(data.z)-1 do begin
      lumd = lumdist(data[i].z, H0=100, Omega_M=0.24, Lambda0=0.76, /SILENT)
;      lumd = lumdist(data[i].z, H0=100, /SILENT)
      rc = lumd / (1.+data[i].z)
      printf, 11, data[i].ra, data[i].dec, data[i].z, rc
   endfor
   close, 11

endif




if choice eq 'P' then begin
   print
   data   = mrdfits('../data/dr5qso.fits', 1)
   random = mrdfits('ra_dec_random_npr.fits', 1)
   
   indx_PRI   = where( ((data.TS_T_QSO     eq 1) or $
                        (data.TS_T_HIZ     eq 1) or $
                        (data.TS_T_FIRST   eq 1)),  N_TS_T_PRI)
   
   data_ra_PrimTarget         = data[indx_PRI].ra
   data_dec_PrimTarget        = data[indx_PRI].dec
   data_z_PrimTarget          = data[indx_PRI].z
   data_specObjID_PrimTarget  = data[indx_PRI].specObjID



endif
   










   



No_bin = 60
x       = fltarr(No_bin)
y       = fltarr(No_bin)
z_bin   = fltarr(No_bin)
z_bin_width = 0.05

for i=0L, n_elements(data_z_cut.z) -1  do begin
   if choice eq 'U' then d = fix((data_z_cut[i].z) * (1./z_bin_width))
   
   ;print, i, data_z_cut[i].z, d
   z_bin(d) = z_bin(d) + 1
endfor





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
!p.multi=0
loadct, 6
set_plot, 'ps'
device, filename='SDSS_Quasar_Nofz.ps', $
        xsize=8, ysize=8, xoffset=0, yoffset=0, /inches, /color
;plothist, data_z_cut.z, bin=0.05, xrange=[-0.05, 2.6]

plot, x,(z_bin), xthick=6, ythick=6, xcharsize=2.2, ycharsize=2.2, $
      xstyle=1, ystyle=1, xrange=[-0.05, 3.2], yrange=[0,2500], $
      thick=7, color=0, $
      xtitle='reshift, z', ytitle='Number of objects'
      position=[0.2,0.2,0.98,0.98]
;oplot, x, y, color= 64

xyouts, 2.1,  2100, "data (x,z_bin)", charsize=2.2, charthick=3, color=0
;xyouts, 2.1, 1155, "data, (x,y)", charsize=2.2, charthick=3, color=64




result = poly_fit(x,y,10, chisq=red_chi) 
;print, result
;for i=0L,10 do print, 'a',i , ' = ', result[i]
;print, 'chi^2', red_chi
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
oplot, x, fit,  color=128
;oplot, x, (fit*30.29), color=192
xyouts, 2.1, 1700, "x^10 poly fit", charsize=2.2, charthick=3, color=128



j=0L
random_z = fltarr(1000000)
norm=1000.
REPEAT BEGIN
   trial = randomu(s) 
   prob =  randomu(s)
   z_trial = (trial * 2.900)  
   
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
;ENDREP UNTIL j eq 1000000
ENDREP UNTIL j eq 100000


sp = replicate({ra: 0D, dec: 0D, z: 0D}, 1000000)
sp.ra  = random.ra
sp.dec = random.dec
sp.z   = random_z
mwrfits, sp, 'randoms_npr.fits'

openw, 10, 'randoms_npr.dat'
for i=0L, 999999 do begin
;   lumd = lumdist(sp[i].z, H0=100, /SILENT)
   lumd = lumdist(sp[i].z, H0=100, Omega_M=0.24, Lambda0=0.76,   /SILENT)
   rc=lumd/(1.+sp[i].z)
   printf, 10, sp[i].ra, sp[i].dec, sp[i].z, rc
endfor
close, 10



;plothist, random_z, bin=0.05, /overplot, peak=1000, color=64
plothist, sp.z, bin=0.05, /overplot, peak=1000, color=64
xyouts, 2.1, 2000, 'Randoms', charsize=2.2, charthick=3, color=64
device, /close
set_plot, 'X'


close, /all
end
