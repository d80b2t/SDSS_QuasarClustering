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
;       Version 1.00  NPR       ~15th October, 2007
;       Version 1.01  NPR       ~20th October, 2007
;               Generates N(z) for `homogeneous' DR5 quasars. 
;-



;  PROPERLY COMMENT THIS AT SOME POINT IN THE V. NEAER FUTURE!!


data   = mrdfits('../data/DR5QSO_uni_data.fits', 1)
random = mrdfits('DR5QSO_uni_random_RADEC.fits', 1)

help, data.ra
help, data.dec
help, data.z

indx_z_cut = where(data.z le 2.501, N_z_cut)

help, indx_z_cut
print, 'N_z_cut', N_z_cut

;data_z_cut = data[indx_z_cut].z
data_z_cut = data[indx_z_cut]

help, data_z_cut
help, data_z_cut.z


loadct, 6
set_plot, 'ps'
device, filename='SDSS_Quasar_Nofz.ps', $
        xsize=8, ysize=8, xoffset=0, $
       yoffset=0.5+(10-8), /inches
;plothist, data_z_cut.z, bin=0.05, xrange=[-0.05, 2.6]
loadct, 6



z_bin = fltarr(100)
z_bin_width = 0.05
for i=0L, n_elements(data_z_cut.z) -1  do begin

   d = fix((data_z_cut[i].z) * (1./z_bin_width))
   ;print, i, data_z_cut[i].z, d

   z_bin(d) = z_bin(d) + 1
   
endfor



x       = fltarr(100)
y       = fltarr(100)
x_check = findgen(100)


openw, 9, 'z_values.dat' 
printf, 9, '#  i,        z_bin,        no. ' 
for i=0L, 99 do begin
   
   printf, 9, i, (float(i*z_bin_width)), fix(z_bin(i))
   if (fix(z_bin(i)) gt 0) then begin
      x[i] = (float(i*z_bin_width))
      y[i] = fix(z_bin(i))
   endif 
   
endfor
close, 9   


help, x 
help, y
; x should be a given redshift (from the data)
; y should be the number of objects at that corresponding redshift,
; from the data


;plot, x, (z_bin),   xrange=[-0.05, 2.6]
plot, x, (z_bin*30.29),   xrange=[-0.05, 2.6]
xyouts, 2.1, 35000, "data"
oplot, x, y, color= 64


result = poly_fit(x,y,10, chisq=red_chi) 
print, result
print, 'chi^2', red_chi


fit = (result[6]*x^6) + (result[5]*x^5) +  (result[4]*x^4) + (result[3]*x^3) + (result[2]*x^2) + (result[1]*x) + (result[0])

fit1 = (result[10]*x^10) + (result[9]*x^9) + (result[8]*x^8) + (result[7]*x^7) + (result[6]*x^6) + $
       (result[5]*x^5)   + (result[4]*x^4) + (result[3]*x^3) + (result[2]*x^2) + (result[1]*x) + (result[0]) 

fit = fit1

;fit2 = ((', result[0], ')*x^12) + ( (', result[1],')*x^11) +  ((',result[2],')*x^10) + ((',result[3],')*x^9) $
;       + ((',result[4],')*x^8) + ((',result[5],')*x^7) '
;print, 'fit3 = ((', result[10], ')*x^6) + ( (', result[11],')*x^5) +
;((',result[12],')*x^4) + ((',result[13],')*x^3) +
;((',result[14],')*x^2) + ((',result[15],')*x) + ', result[16]

fit[0] = 0.0001
indx_fit = where(fit gt 0, N_fit)
fit = fit(indx_fit)
oplot, x, fit, color=128
oplot, x, (fit*30.29), color=192



j=0L
random_z = fltarr(1000000)
norm=1000.
REPEAT BEGIN

   trial = randomu(s)
   prob =  randomu(s)
   z_trial = (trial * 2.500)  

;   z1 = (result[6]*z_trial^6) + (result[5]*z_trial^5) +  (result[4]*z_trial^4) + $
;        (result[3]*z_trial^3) + (result[2]*z_trial^2) +  (result[1]*z_trial) + (result[0])

   z2 =  (result[10]*z_trial^10) + (result[9]*z_trial^9) + (result[8]*z_trial^8) + (result[7]*z_trial^7) + (result[6]*z_trial^6) + $
         (result[5]*z_trial^5)   + (result[4]*z_trial^4) + (result[3]*z_trial^3) + (result[2]*z_trial^2) + (result[1]*z_trial) + (result[0]) 

;   if (prob lt (z1 / norm)) then begin
   if (prob lt (z2 / norm)) then begin
      random_z[j] = z_trial
      j = j+1
;      print, trial, z_trial, z1, norm, 1
   endif
   
ENDREP UNTIL j eq 1000000


plothist, random_z, bin=0.05, /overplot, color=254
device, /close
set_plot, 'X'



sp = replicate({ra: 0D, dec: 0D, z: 0D}, 1000000)

sp.ra  = random.ra
sp.dec = random.dec
sp.z   = random_z


openw, 10, 'randoms_npr.dat'
for i=0L, 999999 do  printf, 10, sp[i].ra, sp[i].dec, sp[i].z
close, 10



mwrfits, data_z_cut, 'DR5QSO_uni_data_z_cut.fits'

mwrfits, sp, 'randoms_npr.fits'









close, /all
end
