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

print
; READING IN THE ORIGINAL ra,dec,redshift 2SLAQ LRG 8656 catalogue
readcol, '2SLAQ_LRG_cat/3yr_obj_v4_Sample8_nota01ao2s01_mini.cat', $
         object_id, ra_J2K, dec_J2K, z_fin, $
         format='a, d,d,d'
print, 'READ-IN 3yr_obj_v4_Sample8_nota01ao2s01_mini.cat'

ra_J2K_min  =  min(ra_J2K)
dec_J2K_min =  min(dec_J2K)
ra_J2K_max  =  max(ra_J2K)
dec_J2K_max =  max(dec_J2K)
z_fin_min   =  min(z_fin)
z_fin_max   =  max(z_fin)

print
print, 'ra_J2K_min ',  ra_J2K_min, '   ra_J2K_max',  ra_J2K_max
print, 'dec_J2K_min', dec_J2K_min, '  dec_J2K_max', dec_J2K_max
print, 'z_fin__min ',   z_fin_min, '    z_fin_max',   z_fin_max
print

print
; READING IN THE ORIGINAL RANDOM file with RA,DEC,REDSHIFT
readcol, '2SLAQ_LRG_cat/rand_LRG_Sm8_spe.dat', $
         ra_rnd, dec_rnd, redshift_rnd
print, 'READ-IN rand_LRG_Sm8_spe.dat'
print

; READING IN THE x,y,z 2SLAQ file 
readcol, '2SLAQ_LRG_cat/3yr_obj_v4_Sample8_nota01ao2s01_xyz.dat', $
         x_coord_LRG, y_coord_LRG, z_coord_LRG
print, 'READ-IN 3yr_obj_v4_Sample8_nota01ao2s01_xyz.dat'
print

; READING IN THE x,y,z  RANDOM file 
readcol, '2SLAQ_LRG_cat/3yr_obj_v4_Sample8_nota01ao2s01_xyz_randoms.dat', $
         x_coord_rnd, y_coord_rnd, z_coord_rnd
print, 'READ-IN 3yr_obj_v4_Sample8_nota01ao2s01_xyz_randoms.dat'
print














loadct, 6
set_plot, 'ps'
!P.MULTI = [0] 
device, filename='Nofz.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0.5+(10-8), /inches, /color

plothist, z_fin, bin=0.02, /fill, thick=2.2, xthick=2.2, $
          xrange=[-0.1,7.0], yrange=[0,12000], $
          ythick=2.2, charsize=1.8, charthick=2.2, $
          title=' Object N(z)', xtitle='redshift, z', ytitle='Number', color=0

plothist, redshift_rnd, bin=0.02, /overplot, thick=2.2, xthick=2.2, $
      ythick=2.2, charsize=1.8, charthick=2.2, $
      title=' Object N(z)', xtitle='redshift, z', ytitle='Number', color=63

xyouts,0.65,10000, 'DR5 Spectro Quasars', charsize=2.2, color=63, charthick=4
xyouts,0.65, 9000, 'DR5 Random Quasars ', charsize=2.2, color=0, charthick=4
device, /close
set_plot, 'X'


loadct, 6
set_plot, 'ps'
device, filename='DR5_quasars_allsky.ps', xsize=16, ysize=16, xoffset=0, $
        yoffset=0.5+(10-8), /inches, /color

plot, ra_J2K, dec_J2K, xrange=[0,360], yrange=[-20,80], $
      psym=3, $
      xstyle=3, ystyle=3, thick=2.2, xthick=2.2, $
      ythick=2.2, charsize=1.8, charthick=2.2, $
      title='nbc_kde_N', xtitle='ra', ytitle='dec', color=0
oplot, ra_J2K, dec_J2K, psym=3, color=64
device, /close
set_plot, 'X'











print
redshift = 0.55
rc_LRG = lumdist(z_fin, H0=100)
rc_LRG = rc_LRG/(1+z_fin)       ; to convert from lum dist to comoving dist.
;for i = 0, n_elements(z_fin)-1 do printf, 10, rc_LRG[i], z_fin[i]
rc_LRG_test = lumdist(redshift, H0=100)
rc_LRG_test = rc_LRG_test/(1+redshift)
print, ' test redshift, z=0.55, 925.16, 1434.9, 2222.7'
print, rc_LRG_test, redshift




N_LRG_sample = n_elements(x_coord_LRG)
bin_DD      = fltarr(60)
bin_DD_2d   = fltarr(35,35)
pi_para_one = fltarr(N_LRG_sample)
pi_para_two = fltarr(N_LRG_sample)
dist_DD_tot = fltarr(N_LRG_sample)
h_DD        = fltarr(100)
h_pi_DD     = fltarr(100)
h_pi_DDt    = fltarr(100)
h_sigma_DD  = fltarr(100)
h_sigma_DDt = fltarr(100)
h_DD_2d     = fltarr(60,60)
h_DD_2dt    = fltarr(100,100)
openw, 11, 'h_from_bin_DD.dat'
openw, 12, 'h_from_bin_DD_2d.dat'
;print, bin_DD
; 1ST LOOP 1ST LOOP 1ST LOOP ! 1ST LOOP 1ST LOOP 1ST LOOP 1ST LOOP 1ST   
; 1ST LOOP 1ST LOOP 1ST LOOP ! 1ST LOOP 1ST LOOP 1ST LOOP 1ST LOOP 1ST   
; 1ST LOOP 1ST LOOP 1ST LOOP ! 1ST LOOP 1ST LOOP 1ST LOOP 1ST LOOP 1ST
; 1ST LOOP 1ST LOOP 1ST LOOP ! 1ST LOOP 1ST LOOP 1ST LOOP 1ST LOOP 1ST   
;
print
print, 'Just jumping into first loop now - the DDs'
print

for i=0L,N_LRG_sample-1 do begin
;for i=0L,N_LRG_sample-2 do begin
;for i=0L,100 do begin
;for i=1L,1 do begin
;for i=0L,5 do begin
;for i=0L,0 do begin
   
   if i eq  500 then print, 'in 1st loop..',  i
   if i eq 1000 then print, 'in 1st loop...',  i
   if i eq 2000 then print, 'in 1st loop....',  i
   if i eq 4000 then print, 'in 1st loop.....',  i
   
;   print, i, x_coord_LRG[i], y_coord_LRG[i], z_coord_LRG[i], pi_para_one[i]
   dist_DD      = sqrt( (x_coord_LRG - x_coord_LRG[i])^2 + $
                        (y_coord_LRG - y_coord_LRG[i])^2 + $
                        (z_coord_LRG - z_coord_LRG[i])^2)
   
   k_dist_DD    = fix((alog10(dist_DD)*10.) + 15.)
   h_DD         = h_DD + histogram(k_dist_DD, min=0, max=60)

   
   pi_para_DD    = abs(rc_LRG - rc_LRG[i])
   k_pi_para_DD  = fix((alog10(pi_para_DD)*5.) + 8.)
   k_pi_para_DDt = fix((alog10(pi_para_DD)*10.) + 15.)
   h_pi_DD       = h_pi_DD + histogram(k_pi_para_DD, min=0, max=60)
   h_pi_DDt       = h_pi_DDt + histogram(k_pi_para_DDt, min=0, max=100)
   size_h_pi_DD  = size(h_pi_DD)
   size_h_pi_DDt  = size(h_pi_DDt)


   sigma_DD        = sqrt ((dist_DD^2) - (pi_para_DD^2)) 
   k_sigma_DD      = fix((alog10(sigma_DD)*5.) + 8.)
   k_sigma_DDt      = fix((alog10(sigma_DD)*10.) + 15.)
   h_sigma_DD      = h_sigma_DD + histogram(k_sigma_DD, min=0, max=60) 
   h_sigma_DDt      = h_sigma_DDt + histogram(k_sigma_DDt, min=0, max=100)
   size_h_sigma_DD = size(h_sigma_DD)
   size_h_sigma_DDt = size(h_sigma_DDt)

   ;if n_element( ) ne n_element() then message, ' '

   h_DD_2d      = h_DD_2d + hist_2d(k_sigma_DD, k_pi_para_DD, $
                                    min1=0, min2=0, max1=55, max2=55)

   h_DD_2dt      = h_DD_2dt + hist_2d(k_sigma_DDt, k_pi_para_DDt, $
                                    min1=0, min2=0, max1=100, max2=100)

   

;   theta = sqrt(((ra_J2K(i)- ra_J2K(j))^2) + $
;                ((dec_J2K(i)-dec_J2K(j))^2))
   
;   k_theta   = fix((alog10(theta)*5.) + 25.)
;   k_theta   = fix((alog10(theta)*10.) + 40.)
   
   
;   if k_theta gt 0 and k_theta le 15 then begin
;      theta_cor = one_plus_ws(fix((alog10(theta)*5.0)+22))
;        print, theta, (theta*60.), theta_cor
;   endif
   
   
;   if k_theta gt 0 and k_theta le 15 then begin
;         bin_DD_theta[k_theta] = bin_DD_theta[k_theta] + 2
;      bin_DD_theta[k_theta] = bin_DD_theta[k_theta] + (2. * theta_cor)
;   endif else if k_theta gt 15 and k_theta le 56 then begin
;      bin_DD_theta[k_theta] = bin_DD_theta[k_theta] + 2
;   endif
   


endfor
print
size_h_DD     =   size(h_DD)
size_h_DD_2d  =   size(h_DD_2d)
;help, h
help, dist_DD
help, k_dist_DD
help, h_DD
print, 'size(h_DD)', size(h_DD)
print, 'size_h_DD(1)', size_h_DD(1)
print, 'total(h_DD)', total(h_DD), (total(h_DD)/(8656.^2))
print, 'max(h_DD)', max(h_DD)
print, 'max_dist_DD', max(dist_DD)
print
print
help, pi_para_DD
help, k_pi_para_DD
help, h_pi_DD
print
help, sigma_DD
help, k_sigma_DD
help, h_sigma_DD
print
help, h_DD_2d
print, 'size(h_DD_2d)', size(h_DD_2d)
print, 'size_h_DD_2d(1)', size_h_DD_2d(1)
print, 'h_DD_2d', total(h_DD_2d),  (total(h_DD_2d)) / (8656.^2)
print
print
print


set_plot, 'ps'
device, filename='bin_DD_hist1.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0.5+(10-8), /inches, /color

plot, histogram(dist_DD) ;binsize=100
device, /close

set_plot, 'ps'
device, filename='bin_DD_hist2.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0.5+(10-8), /inches, /color
plothist, h_DD
device, /close
set_plot, 'X'

;plot, histogram(dist_DD, binsize=1.)
;plothist, bin_DD, bin=1
printf, 11, 'h_DD', total(h_DD), (total(h_DD))/(8656.^2)
printf, 11, h_DD
printf, 11
printf, 11
;printf, 11, 'dist_DD_tot'
;printf, 11, dist_DD_tot
;printf, 11
;printf, 11


printf, 12, 'h_DD', total(h_DD), (total(h_DD))/(8656.^2)
printf, 12, h_DD
printf, 12
printf, 12

printf, 12, 'dist_DD', total(dist_DD)
printf, 12, dist_DD
printf, 12
printf, 12
printf, 12, 'pi_para_DD', total(pi_para_DD)
printf, 12, pi_para_DD
printf, 12
printf, 12
printf, 12, 'k_pi_para_DD', total(k_pi_para_DD)
printf, 12, k_pi_para_DD
printf, 12
printf, 12
printf, 12, 'sigma_DD', total(sigma_DD)
printf, 12, sigma_DD
printf, 12
printf, 12
printf, 12, 'k_sigma_DD', total(k_sigma_DD)
printf, 12, k_sigma_DD
printf, 12
printf, 12

printf, 12, 'h_DD', total(h_DD), (total(h_DD))/(8656.^2)
printf, 12, h_DD
printf, 12
printf, 12
printf, 12, 'h_pi_DD', total(h_pi_DD), (total(h_pi_DD))/(8656.^2)
printf, 12, h_pi_DD
printf, 12
printf, 12
printf, 12, 'h_sigma_DD', total(h_sigma_DD), (total(h_sigma_DD))/(8656.^2)
printf, 12, h_sigma_DD
printf, 12
printf, 12
printf, 12, 'h_DD_2d', total(h_DD_2d),  (total(h_DD_2d)) / (8656.^2)
printf, 12, h_DD_2d
printf, 12
printf, 12






N_rnd = N_elements(ra_rnd)
print, 'N_rnd', N_rnd
pi_para_one = fltarr(N_rnd)
pi_para_two = fltarr(N_rnd)
h_DR = fltarr(100)
print, 'Just jumping into SECOND loop now - the DRs'
print
; 2ND LOOP  2ND LOOP   2ND LOOP  2ND LOOP   2ND LOOP  2ND LOOP 
; 2ND LOOP  2ND LOOP   2ND LOOP  2ND LOOP   2ND LOOP  2ND LOOP 
; 2ND LOOP  2ND LOOP   2ND LOOP  2ND LOOP   2ND LOOP  2ND LOOP 
; 2ND LOOP  2ND LOOP   2ND LOOP  2ND LOOP   2ND LOOP  2ND LOOP 
;  
;  DR pair (aka G-R pairs...)
;  
bin_DR       = fltarr(60)
bin_DR_2d    = fltarr(60,60)
bin_DR_2dt    = fltarr(100,100)

for i = 0L, N_LRG_sample-1  do begin
;for i = 0L, 100  do begin
;for i = 0, 1  do begin
   
   if i MOD 433 eq 0 then print, ( (double(i) / 8656.)*100.), '% DRs done'
  
   pi_para_one[i] = sqrt(s_sq(x_coord_LRG[i], y_coord_LRG[i], z_coord_LRG[i], $
                              0,0,0))
   
;   for j=0L, N_rnd-1 do begin
   for j=0L, 17311 do begin
;   for j=0L, 100 do begin
;   for j=0L, 1 do begin
      
      pi_para_two[j] = sqrt(s_sq(x_coord_rnd[j], y_coord_rnd[j], z_coord_rnd[j],$
                                 0,0,0))
      s_squared = s_sq(x_coord_LRG[i], y_coord_LRG[i], z_coord_LRG[i], $
                       x_coord_rnd[j], y_coord_rnd[j], z_coord_rnd[j])
      
      s = sqrt(s_squared)
      pi_para = abs(pi_para_one[i] - pi_para_two[j])
      sigma = sqrt (s_squared - (pi_para^2))
      
      k          = fix((alog10(s)*10) + 15)
      k_pi_para  = fix((alog10(pi_para)*5.) + 8.)
      k_sigma    = fix((alog10(sigma  )*5.) + 8.)
      k_pi_parat = fix((alog10(pi_para)*10.) + 15.)
      k_sigmat   = fix((alog10(sigma  )*10.) + 15.)

      
      if k gt 0 and k le 56 then begin
         bin_DR[k]             = bin_DR[k] + 1
      endif

      if (k_sigma gt 0 and k_pi_para gt 0 and $
          k_sigma le 22 and k_pi_para le 22)  then begin
         bin_DR_2d[k_sigma,k_pi_para] =   bin_DR_2d[k_sigma,k_pi_para] + 1 ;
      endif 

      if (k_sigma gt 0 and k_pi_para gt 0 and $
          k_sigma le 56 and k_pi_para le 56)  then begin
         bin_DR_2dt[k_sigmat,k_pi_parat] = bin_DR_2dt[k_sigmat,k_pi_parat] + 1 ;
      endif 

   endfor
endfor
print

help, bin_DR
print, 'total(h_DR)', total(h_DR)
print, 'max(h_DR)', max(h_DR)
help, bin_DR_2d
print
print
print

printf, 11, 'bin_DR', total(bin_DR), (total(bin_DR)) / ((8656.^2)*20.)
printf, 11, bin_DR
printf, 11
printf, 11

printf, 12, 'bin_DR', total(bin_DR), (total(bin_DR)) / ((8656.^2)*20.)
printf, 12, bin_DR
printf, 12
printf, 12
printf, 12, 'bin_DR_2d', total(bin_DR_2d), (total(bin_DR_2d)) / ((8656.^2)*20.)
printf, 12, bin_DR_2d
printf, 12
printf, 12




openw, 5, '2SLAQ_rnd_redshifts.dat'
;for i = 0L, n_elements(redshift_rnd)-1 do printf, 5, redshift_rnd[i]
rc_rnd = lumdist(redshift_rnd, H0=100) ; this line causes the arith errors...
rc_rnd = rc_rnd/(1+redshift_rnd)   ; to convert from lum dist to comoving dist.
;for i = 0, n_elements(redshift_rnd)-1 do printf, 5, rc_rnd[i], redshift_rnd[i]
for i = 0L, n_elements(redshift_rnd)-1 do printf, 5, rc_rnd[i], redshift_rnd[i]
close, 5


N_rnd = N_elements(ra_rnd)
print, 'N_rnd', N_rnd
;  3RD LOOP 3RD LOOP 3RD LOOP  3RD LOOP 3RD LOOP 3RD LOOP
;  3RD LOOP 3RD LOOP 3RD LOOP  3RD LOOP 3RD LOOP 3RD LOOP
;  3RD LOOP 3RD LOOP 3RD LOOP  3RD LOOP 3RD LOOP 3RD LOOP
;  3RD LOOP 3RD LOOP 3RD LOOP  3RD LOOP 3RD LOOP 3RD LOOP
;  
;  R-R pairs
;  
bin_RR       = fltarr(60)
bin_RR_theta = fltarr(60)
bin_RR_2d    = fltarr(35,35)
h_RR        = fltarr(60)
h_pi_RR     = fltarr(60)
h_sigma_RR  = fltarr(60)
h_pi_RRt    = fltarr(60)
h_sigma_RRt = fltarr(60)
h_RR_2d     = fltarr(60,60)
h_RR_2dt    = fltarr(100,100)
print
print, 'Just jumping into third, RR, loop now'
print
;for i=0L, N_rnd-1 do begin
;for i=0L, N_rnd-2 do begin
;for i = 0, N_Q-1  do begin
for i = 0, 17321  do begin
;for i = 0, 1732  do begin
;for i = 0, 173  do begin
   
   if i MOD 8656 eq 0 then print, ( (double(i) / 173120.)*100.), '% RRs done'

   pi_para_one[i] = sqrt(s_sq(x_coord_rnd[i], y_coord_rnd[i], z_coord_rnd[i], $
                              0,0,0))
   
   dist_RR      = sqrt( (x_coord_rnd - x_coord_rnd[i])^2 + $
                        (y_coord_rnd - y_coord_rnd[i])^2 + $
                        (z_coord_rnd - z_coord_rnd[i])^2)

   k_RR         = fix((alog10(dist_RR)*10) + 15)
   h_RR         = h_RR + histogram(k_RR, min=0, max=60)

   pi_para_RR   = abs(rc_rnd - rc_rnd[i])
   k_pi_para_RR = fix((alog10(pi_para_RR)*5.) + 8.)
   k_pi_para_RRt = fix((alog10(pi_para_RR)*10.) + 15.)
   h_pi_RR       = h_pi_RR  + histogram(k_pi_para_RR)
   h_pi_RRt      = h_pi_RRt + histogram(k_pi_para_RRt)

   sigma_RR      = sqrt((dist_RR^2) - (pi_para_RR^2))
   sigma_RRt     = sqrt((dist_RR^2) - (pi_para_RR^2))
   k_sigma_RR    = fix((alog10(sigma_RR)*5.) + 8.)
   k_sigma_RRt   = fix((alog10(sigma_RRt)*10.) + 15.)

   h_sigma_RR    = h_sigma_RR + histogram(k_sigma_RR)
   h_sigma_RRt   = h_sigma_RRt + histogram(k_sigma_RRt)
   
   h_RR_2d      = h_RR_2d + hist_2d(k_sigma_RR, k_pi_para_RR, $
                                    min1=0, min2=0, max1=55, max2=55)
   h_RR_2dt     = h_RR_2dt + hist_2d(k_sigma_RRt, k_pi_para_RRt, $
                                    min1=0, min2=0, max1=100, max2=100)
endfor
print
;help, h
help, h_RR
print, 'size(h_RR) ', size(h_RR)
print, 'total(h_RR)', total(h_RR)
print, 'max(h_RR)  ', max(h_RR)
print, 'max_dist_RR', max(dist_RR)
help, dist_RR
help, h_RR_2d
print
print
print


printf, 11, 'h_RR', total(h_RR), (total(h_RR)) / (173120.^2)
printf, 11, h_RR
printf, 11
printf, 11
close, 11


printf, 12, 'pi_para_RR', total(pi_para_RR)
printf, 12, pi_para_RR
printf, 12
printf, 12
printf, 12, 'k_pi_para_RR', total(k_pi_para_RR)
printf, 12, k_pi_para_RR
printf, 12
printf, 12
printf, 12, 'sigma_RR', total(sigma_RR)
printf, 12, sigma_RR
printf, 12
printf, 12
printf, 12, 'k_sigma_RR', total(k_sigma_RR)
printf, 12, k_sigma_RR
printf, 12
printf, 12

printf, 12, 'h_RR', total(h_RR), (total(h_RR)) / (173120.^2)
printf, 12, h_RR
printf, 12
printf, 12
printf, 12, 'h_RR_2d', total(h_RR_2d)
printf, 12, h_RR_2d
printf, 12
printf, 12
close, 12




N_ratio_DR = (float(N_elements(ra_rnd)) / float(N_elements(ra_J2K)))
print, 'N_ratio, N_rnd, N_LRG_sample'
print, N_ratio_DR, N_elements(ra_rnd), N_elements(ra_J2K)



openw, 9, 'kde_output_temp.dat'
printf, 9, ' # k, 10^((float(k)-15.+0.5)/10.), bin_DD(k), bin_DR(k)'
xi     = fltarr(65)
xi_STD = fltarr(65)
xi_LS  = fltarr(65)
xis_check = fltarr(65)
s_check = fltarr(65)
bin_DD_plot = fltarr(65)
bin_DR_plot = fltarr(65)
bin_RR_plot = fltarr(65)
;for k =1, 56  do begin
;for k =0, size_h_DD(1)  do begin
for k =0, 40  do begin

   
   if bin_DR(k) ne 0L then begin
      xi(k)    = N_ratio_DR * ( bin_DD(k) / bin_DR(k))   - 1.0
;   delta_xi(k) = (1. + xi(k)) * (sqrt(2.0/bin_DR(k)))
   endif else begin
      xi(k) = 0.
   endelse
   
   if h_RR(k) ne 0L then begin
      xi_STD(k)    = (N_ratio_DR^2) * ( h_DD(k) / h_RR(k))   - 1.0
   endif else begin
      xi_STD(k) = 0.
   endelse
   
   if h_RR(k) ne 0L then begin
      Landy = (N_ratio_DR^2) * ( h_DD(k)/h_RR(k) )  
      Szalay = 2.0 * N_ratio_DR * ( bin_DR(k) / h_RR(k)) 
      xi_LS(k)  = 1 + Landy - Szalay
   endif else begin
      xi_LS(k) = 0.
   endelse

   
   printf, 9, 10^((float(k)-15.+0.5)/10.), h_DD(k), bin_DR(k), h_RR(k), $
           xi(k), xi_STD(k), xi_LS(k), $
           format='(d, i,i,i, d,d,d)'
endfor
printf, 9, total(bin_DD)
close, 9
print







N_ratio_DR = (float(N_elements(ra_rnd)) / float(N_elements(ra_J2K)))
print, 'N_ratio, N_rnd, N_LRG_sample'
print, N_ratio_DR, N_elements(ra_rnd), N_elements(ra_J2K)

openw, 18, 'kde_2d_output_tempf.dat'
printf, 18, ' # k_sigma, k_pi_para, 10^((float(k_sigma)-15.+0.5)/10.), 10^((float(k_pi_para)-15.+0.5)/10.), h_DD_2d, bin_DR_2d, h_RR_2d, xi, xi_STD, xi_LS'

openw, 27, 'Kde_wp_sigma_output_temp.dat'
xi_sigma_pi       =  fltarr(35,35)
xi_sigma_pi_LS    =  fltarr(35,35)
xi_sigma_pi_STD   =  fltarr(35,35)
xi_sigma_pi_HAM   =  fltarr(35,35)

bin_sigma_pi      =  fltarr(35,35)
bin_sigma_pi_HAM  =  fltarr(35,35)
bin_sigma_pi_LS   =  fltarr(35,35)
Xi_sigma          =  fltarr(65)  
Xi_sigma_HAM      =  fltarr(65)          
Xi_sigma_LS       =  fltarr(65)          
bin_DD_sigma      =  fltarr(65)
bin_DR_sigma      =  fltarr(65)
delta_Xi_sigma      =  fltarr(65)

bin_DD_2d_plot    =  fltarr(35,35)
bin_DR_2d_plot    =  fltarr(35,35)
bin_RR_2d_plot    =  fltarr(35,35)
h_DD_2d_sigma_sum =  fltarr(40)
h_DD_2d_pi_sum    =  fltarr(40)
for k_sigma =0, 21  do begin
   for k_pi_para =0, 21  do begin
      
      if (h_DD_2d(k_sigma,k_pi_para) ne 0L and $
          bin_DR_2d(k_sigma,k_pi_para) ne 0L and $
          h_RR_2d(k_sigma,k_pi_para) ne 0L) then begin
         
         xi_sigma_pi(k_sigma,k_pi_para) = (-1.0) + (N_ratio_DR * $
                                          (h_DD_2d(k_sigma,k_pi_para) / $
                                           bin_DR_2d(k_sigma,k_pi_para)))
         
         xi_sigma_pi_STD(k_sigma,k_pi_para) =  (-1.0) + ((N_ratio_DR^2) * $
                                                (h_DD_2d(k_sigma,k_pi_para) / $
                                                 h_RR_2d(k_sigma,k_pi_para)))
      
         xi_sigma_pi_HAM(k_sigma,k_pi_para)= ((h_DD_2d(k_sigma,k_pi_para)* $
                                               h_RR_2d(k_sigma,k_pi_para)) / $
                                              (bin_DR_2d(k_sigma,k_pi_para)^2)) $
                                             - 1.0
         
         Landy2d  = (N_ratio_DR^2) * $
                    (h_DD_2d(k_sigma,k_pi_para)/h_RR_2d(k_sigma,k_pi_para))
         Szalay2d = (2.0 * N_ratio_DR) * $
                    (bin_DR_2d(k_sigma,k_pi_para)/h_RR_2d(k_sigma,k_pi_para))
         xi_sigma_pi_LS(k_sigma,k_pi_para) =  1 + Landy2d - Szalay2d
         
      endif else begin
         xi_sigma_pi(k_sigma,k_pi_para) = 0.0
      endelse
      
      
      if k_pi_para le 16 then begin ; pi_cut = 63.0 h^-1 Mpc if + 8
;      if k_pi_para le 19 then begin ; pi_cut = 63.0 h^-1 Mpc if + 12
      bin_sigma_pi(k_sigma,k_pi_para)    = xi_sigma_pi(k_sigma,k_pi_para) $
                                           *(10^ ( (float(k_pi_para)-7)/5.) $
                                           - 10^ ( (float(k_pi_para)-8)/5.))

      bin_sigma_pi_HAM(k_sigma,k_pi_para) = xi_sigma_pi_HAM(k_sigma,k_pi_para) $
                                           *(10^ ( (float(k_pi_para)-7)/5.) $
                                           - 10^ ( (float(k_pi_para)-8)/5.))
      
      bin_sigma_pi_LS(k_sigma,k_pi_para) = xi_sigma_pi_LS(k_sigma,k_pi_para) $
                                           *(10^ ( (float(k_pi_para-7))/5.) $
                                           - 10^ ( (float(k_pi_para-8))/5.))
      endif else begin
         bin_sigma_pi(k_sigma,k_pi_para)     = 0.0
         bin_sigma_pi_HAM(k_sigma,k_pi_para) = 0.0
         bin_sigma_pi_LS(k_sigma,k_pi_para)  = 0.0
      endelse

      
      Xi_sigma(k_sigma)      = Xi_sigma(k_sigma) + $
                             (2.*bin_sigma_pi(k_sigma,k_pi_para)) 
      Xi_sigma_HAM(k_sigma)  = Xi_sigma_HAM(k_sigma) + $
                             (2.*bin_sigma_pi_HAM(k_sigma,k_pi_para)) 
      Xi_sigma_LS(k_sigma)   = Xi_sigma_LS(k_sigma) + $
                             (2.*bin_sigma_pi_LS(k_sigma,k_pi_para)) 
      
      bin_DD_sigma(k_sigma)=bin_DD_sigma(k_sigma)+(h_DD_2d(k_sigma,k_pi_para))
      bin_DR_sigma(k_sigma)=bin_DR_sigma(k_sigma)+(bin_DR_2d(k_sigma,k_pi_para))



      printf, 18, k_sigma, k_pi_para, $
           10^((float(k_sigma)-8+0.5)/5.), 10^((float(k_pi_para)-8+0.5)/5.), $
;           10^((float(k_sigma)-12+0.5)/5.), 10^((float(k_pi_para)-12+0.5)/5.), $
              h_DD_2d(k_sigma,k_pi_para), bin_DR_2d(k_sigma,k_pi_para), $
              h_RR_2d(k_sigma,k_pi_para), $
              xi_sigma_pi(k_sigma,k_pi_para), $
              xi_sigma_pi_STD(k_sigma,k_pi_para), $ 
              xi_sigma_pi_HAM(k_sigma,k_pi_para), $
              xi_sigma_pi_LS(k_sigma,k_pi_para), $ 
              format='(i,1x,i,1x,  d11.5,2x,d11.5,2x,  d15.1,1x,d15.1,1x,d15.1,1x,  d15.6,1x,d15.6,1x,d15.6,1x,d15.6)'
      
   endfor  ;k_pi_para =0, 21  do begin

   
   if (bin_DD_sigma(k_sigma) ne 0. and bin_DR_sigma(k_sigma) ne 0.) then begin
      delta_Xi_sigma(k_sigma) = (1 + Xi_sigma(k_sigma)) $
                                * (sqrt(2.0 / bin_DD_sigma(k_sigma)))
   endif else begin
      delta_Xi_sigma(k_sigma) = 0.
   endelse

   printf, 27, 10^((float(k_sigma)-8+0.5)/5.), (float(k_sigma)-8+0.5)/5., $
;   printf, 27, 10^((float(k_sigma)-12+0.5)/5.), (float(k_sigma)-12+0.5)/5., $
           Xi_sigma(k_sigma), delta_Xi_sigma(k_sigma), $
           bin_DD_sigma(k_sigma),bin_DR_sigma(k_sigma), $
           Xi_sigma_HAM(k_sigma), Xi_sigma_LS(k_sigma), $
           format='(d11.6,1x,d7.3,2x,  d16.8,1x,d16.8,2x,  d16.2,1x,d16.2,2x, d16.4,1x,d16.4)' 

endfor    ;for k_sigma =0, 21  do begin
close, 18
close, 27









openw, 19, 'kde_2dt_output_tempf.dat'
printf, 19, ' # k_sigma, k_pi_para, 10^((float(k_sigma)-15.+0.5)/10.), 10^((float(k_pi_para)-15.+0.5)/10.), h_DD_2d, bin_DR_2d, h_RR_2d, xi, xi_STD, xi_LS'

openw, 28, 'Kde_wpt_sigma_output_temp.dat'
xi_sigma_pit       =  fltarr(70,70)
xi_sigma_pit_LS    =  fltarr(70,70)
xi_sigma_pit_STD   =  fltarr(70,70)
xi_sigma_pit_HAM   =  fltarr(70,70)

bin_sigma_pit      =  fltarr(70,70)
bin_sigma_pit_HAM  =  fltarr(70,35)
bin_sigma_pit_LS   =  fltarr(70,70)
Xi_sigmat          =  fltarr(65)  
Xi_sigmat_HAM      =  fltarr(65)          
Xi_sigmat_LS       =  fltarr(65)          
bin_DD_sigmat      =  fltarr(65)
bin_DR_sigmat      =  fltarr(65)
delta_Xi_sigma      =  fltarr(65)

bin_DD_2d_plot    =  fltarr(70,70)
bin_DR_2d_plot    =  fltarr(70,70)
bin_RR_2d_plot    =  fltarr(70,70)
h_DD_2d_sigma_sum =  fltarr(40)
h_DD_2d_pi_sum    =  fltarr(40)
for k_sigma =0, 56  do begin
   for k_pi_para =0, 56  do begin
      
      if (h_DD_2dt(k_sigma,k_pi_para) ne 0L and $
          bin_DR_2dt(k_sigma,k_pi_para) ne 0L and $
          h_RR_2dt(k_sigma,k_pi_para) ne 0L) then begin
         
         xi_sigma_pit(k_sigma,k_pi_para) = (-1.0) + (N_ratio_DR * $
                                          (h_DD_2dt(k_sigma,k_pi_para) / $
                                           bin_DR_2dt(k_sigma,k_pi_para)))
         
         xi_sigma_pit_STD(k_sigma,k_pi_para) =  (-1.0) + ((N_ratio_DR^2) * $
                                                (h_DD_2dt(k_sigma,k_pi_para) / $
                                                 h_RR_2dt(k_sigma,k_pi_para)))
      
         xi_sigma_pit_HAM(k_sigma,k_pi_para)= ((h_DD_2dt(k_sigma,k_pi_para)* $
                                               h_RR_2dt(k_sigma,k_pi_para)) / $
                                             (bin_DR_2dt(k_sigma,k_pi_para)^2)) $
                                             - 1.0
         
         Landy2dt  = (N_ratio_DR^2) * $
                    (h_DD_2dt(k_sigma,k_pi_para)/h_RR_2dt(k_sigma,k_pi_para))
         Szalay2dt = (2.0 * N_ratio_DR) * $
                    (bin_DR_2dt(k_sigma,k_pi_para)/h_RR_2dt(k_sigma,k_pi_para))
         xi_sigma_pit_LS(k_sigma,k_pi_para) =  1 + Landy2dt - Szalay2dt
         
      endif else begin
         xi_sigma_pit(k_sigma,k_pi_para) = 0.0
      endelse
      
      
      if k_pi_para le 19 then begin ; pi_cut = 63.0 h^-1 Mpc if + 8
;      if k_pi_para le 19 then begin ; pi_cut = 63.0 h^-1 Mpc if + 12
      bin_sigma_pit(k_sigma,k_pi_para)    = xi_sigma_pi(k_sigma,k_pi_para) $
                                           *(10^ ( (float(k_pi_para)-14)/10.) $
                                           - 10^ ( (float(k_pi_para)-15)/10.))

      bin_sigma_pi_HAM(k_sigma,k_pi_para) = xi_sigma_pi_HAM(k_sigma,k_pi_para) $
                                           *(10^ ( (float(k_pi_para)-7)/5.) $
                                           - 10^ ( (float(k_pi_para)-8)/5.))
      
      bin_sigma_pi_LS(k_sigma,k_pi_para) = xi_sigma_pi_LS(k_sigma,k_pi_para) $
                                           *(10^ ( (float(k_pi_para-7))/5.) $
                                           - 10^ ( (float(k_pi_para-8))/5.))
      endif else begin
         bin_sigma_pi(k_sigma,k_pi_para)     = 0.0
         bin_sigma_pi_HAM(k_sigma,k_pi_para) = 0.0
         bin_sigma_pi_LS(k_sigma,k_pi_para)  = 0.0
      endelse

      
      Xi_sigma(k_sigma)      = Xi_sigma(k_sigma) + $
                             (2.*bin_sigma_pi(k_sigma,k_pi_para)) 
      Xi_sigma_HAM(k_sigma)  = Xi_sigma_HAM(k_sigma) + $
                             (2.*bin_sigma_pi_HAM(k_sigma,k_pi_para)) 
      Xi_sigma_LS(k_sigma)   = Xi_sigma_LS(k_sigma) + $
                             (2.*bin_sigma_pi_LS(k_sigma,k_pi_para)) 
      
      bin_DD_sigma(k_sigma)=bin_DD_sigma(k_sigma)+(h_DD_2d(k_sigma,k_pi_para))
      bin_DR_sigma(k_sigma)=bin_DR_sigma(k_sigma)+(bin_DR_2d(k_sigma,k_pi_para))



      printf, 19, k_sigma, k_pi_para, $
           10^((float(k_sigma)-8+0.5)/5.), 10^((float(k_pi_para)-8+0.5)/5.), $
;           10^((float(k_sigma)-12+0.5)/5.), 10^((float(k_pi_para)-12+0.5)/5.), $
              h_DD_2d(k_sigma,k_pi_para), bin_DR_2d(k_sigma,k_pi_para), $
              h_RR_2d(k_sigma,k_pi_para), $
              xi_sigma_pi(k_sigma,k_pi_para), $
              xi_sigma_pi_STD(k_sigma,k_pi_para), $ 
              xi_sigma_pi_HAM(k_sigma,k_pi_para), $
              xi_sigma_pi_LS(k_sigma,k_pi_para), $ 
              format='(i,1x,i,1x,  d11.5,2x,d11.5,2x,  d15.1,1x,d15.1,1x,d15.1,1x,  d15.6,1x,d15.6,1x,d15.6,1x,d15.6)'
      
   endfor  ;k_pi_para =0, 21  do begin

   
   if (bin_DD_sigma(k_sigma) ne 0. and bin_DR_sigma(k_sigma) ne 0.) then begin
      delta_Xi_sigma(k_sigma) = (1 + Xi_sigma(k_sigma)) $
                                * (sqrt(2.0 / bin_DD_sigma(k_sigma)))
   endif else begin
      delta_Xi_sigma(k_sigma) = 0.
   endelse

   printf, 28, 10^((float(k_sigma)-8+0.5)/5.), (float(k_sigma)-8+0.5)/5., $
;   printf, 28, 10^((float(k_sigma)-12+0.5)/5.), (float(k_sigma)-12+0.5)/5., $
           Xi_sigma(k_sigma), delta_Xi_sigma(k_sigma), $
           bin_DD_sigma(k_sigma),bin_DR_sigma(k_sigma), $
           Xi_sigma_HAM(k_sigma), Xi_sigma_LS(k_sigma), $
           format='(d11.6,1x,d7.3,2x,  d16.8,1x,d16.8,2x,  d16.2,1x,d16.2,2x, d16.4,1x,d16.4)' 

endfor    ;for k_sigma =0, 21  do begin
close, 19
close, 28

























device, /close
close, /all
end

