;+
; NAME:
;       q_omega_rs_vX_xx
;
; PURPOSE:
;       To calculated correlation functions for SDSS DR5 quasars.
;
; EXPLANATION:
;
; CALLING SEQUENCE:
;       .run q_omega_rs_v1_24
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
;         Based on omega_rs_v1_24.pro code in 
;         /Volumes/Bulk/npr/cos_pc19a_npr/programs/omega_rs
;
; NOTES:
;
; MODIFICATION HISTORY:
;       Version 1.24  NPR    15th October, 2007
;           Calculates wp(sigma). 
;-

;
;
;  PROPERLY COMMENT THIS AT SOME POINT IN THE V. NEAER FUTURE!!
;
;


data   = mrdfits('DR5QSO_uni_data.fits', 1)
random = mrdfits('DR5QSO_uni_random_RADEC.fits', 1)

help, data.ra
help, data.dec
help, data.z

indx_z_cut = where(data.z lt 2.5, N_z_cut)

help, indx_z_cut
print, 'N_z_cut', N_z_cut

;data_z_cut = data[indx_z_cut].z
data_z_cut = data[indx_z_cut]

help, data_z_cut
help, data_z_cut.z

;plothist, data_z_cut.z, bin=0.05






z_bin = fltarr(100)
z_bin_width = 0.05
for i=0L, n_elements(data_z_cut.z) -1  do begin

   d = fix((data_z_cut[i].z) * (1./z_bin_width))
   ;print, i, data_z_cut[i].z, d

   z_bin(d) = z_bin(d) + 1
   
endfor



x       = fltarr(100)
y       = fltarr(100)
x_check = fltarr(100)

openw, 9, 'z_values.dat' 
printf, 9, '#  i,        z_bin,        no. ' 
for i=0L, 51 do begin
   
   printf, 9, i, (float(i*z_bin_width)), fix(z_bin(i))
   if (fix(z_bin(i)) gt 0) then begin
      x[i] = (float(i*z_bin_width))
      y[i] = fix(z_bin(i))
      
   endif 
   
endfor

close, 9   

help, x
help, y



result = poly_fit(x,y,6, chisq=red_chi) 
print, result
print, 'chi^2', red_chi


y_check = (30*x_check^6) + (45*x^4) + (


result_check = poly_fit(x,y,6, chisq=red_chi) 
print, result_check


;print, 'fit = ((', result[0], ')*x^2) + ( (', result[1],')*x) +  ',result[2]

;print, 'fit = ((', result[0], ')*x^6) + ( (', result[1],')*x^5) +  ((',result[2],')*x^4) + ((',result[3],')*x^3) + ((',result[4],')*x^2) + ((',result[5],')*x) + ', result[6]

;print, 'fit1 = ((', result[0], ')*x^6) + ( (', result[1],')*x^5) +  ((',result[2],')*x^4) + ((',result[3],')*x^3) + ((',result[4],')*x^2) + ((',result[5],')*x) + ', result[6]
;print, 'fit2 = ((', result[0], ')*x^12) + ( (', result[1],')*x^11) +  ((',result[2],')*x^10) + ((',result[3],')*x^9) + ((',result[4],')*x^8) + ((',result[5],')*x^7) '
;print, 'fit3 = ((', result[10], ')*x^6) + ( (', result[11],')*x^5) +  ((',result[12],')*x^4) + ((',result[13],')*x^3) + ((',result[14],')*x^2) + ((',result[15],')*x) + ', result[16]









;Here we can:
;
;        1) use the polynomical fit to the data N(z) as a probabilty
;        distrib. 
;  
;        2) generate a random number (0 < X <  1), scale it to the
;        redshift range, 0 -> 2.5 and then use this scaled value in
;        the polynomial expression fit = X^6 +... etc. 
;      
;        3) accept or reject it, depending on whether it lies under
;        the curve (add one if accepted) 
;
;        4) do this literally one million times, and adding to
;        randoms.ra[i] and randoms.dec[i] each time.....
;


















close, /all

end
