;+
; NAME:
;       q_omega_rs_v1_25
;
; PURPOSE:
;       To calculated correlation functions for SDSS DR5 quasars.
;
; EXPLANATION:
;
; CALLING SEQUENCE:
;       .run q_omega_rs_v1_25
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
;       Version 1.25  NPR    18th October, 2007
;-

print

data   = mrdfits('data/DR5QSO_uni_data.fits', 1)
;random = mrdfits('DR5QSO_uni_random_RADEC.fits', 1)
readcol, 'data/randoms_npr.dat', ra_rnd, dec_rnd, redshift_rnd

ra_J2K = data.ra
dec_J2K = data.dec
z_fin   = data.z

; ra_rnd  = random.ra
;dec_rnd  = random.dec
;redshift_rnd


print

rc_LRG = lumdist(z_fin, H0=100)
rc_LRG = rc_LRG/(1+z_fin)       ; to convert from lum dist to comoving dist.

ra_J2K_rad  = ra_J2K/180. * !dpi
dec_J2K_rad = dec_J2K/180. * !dpi

x_coord_LRG = rc_LRG * cos(dec_J2K_rad) * cos(ra_J2K_rad)  
y_coord_LRG = rc_LRG * cos(dec_J2K_rad) * sin(ra_J2K_rad)  
z_coord_LRG = rc_LRG * sin(dec_J2K_rad)




rc_rnd = lumdist(redshift_rnd, H0=100)
rc_rnd = rc_rnd/(1.+redshift_rnd)

ra_rnd_rad  = ra_rnd/180. * !dpi
dec_rnd_rad = dec_rnd/180. * !dpi

x_coord_rnd = rc_rnd * cos(dec_rnd_rad) * cos(ra_rnd_rad)  
y_coord_rnd = rc_rnd * cos(dec_rnd_rad) * sin(ra_rnd_rad)  
z_coord_rnd = rc_rnd * sin(dec_rnd_rad)








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
print, 'total(h_DD)', total(h_DD), (total(h_DD)/(38209.^2))
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
print, 'h_DD_2d', total(h_DD_2d),  (total(h_DD_2d)) / (38209.^2)
print
print
print


set_plot, 'ps'
device, filename='bin_DD_hist1.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0.5+(10-8), /inches, /color

plot, histogram(dist_DD) ;binsize=100
device, /close

;set_plot, 'ps'
;device, filename='bin_DD_hist2.ps', xsize=8, ysize=8, xoffset=0, $
;        yoffset=0.5+(10-8), /inches, /color
;plothist, h_DD
;device, /close
;set_plot, 'X'

;plot, histogram(dist_DD, binsize=1.)
;plothist, bin_DD, bin=1
printf, 11, 'h_DD', total(h_DD), (total(h_DD))/(38209.^2)
printf, 11, h_DD
printf, 11
printf, 11
;printf, 11, 'dist_DD_tot'
;printf, 11, dist_DD_tot
;printf, 11
;printf, 11


printf, 12, 'h_DD', total(h_DD), (total(h_DD))/(38209.^2)
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

printf, 12, 'h_DD', total(h_DD), (total(h_DD))/(38209.^2)
printf, 12, h_DD
printf, 12
printf, 12
printf, 12, 'h_pi_DD', total(h_pi_DD), (total(h_pi_DD))/(38209.^2)
printf, 12, h_pi_DD
printf, 12
printf, 12
printf, 12, 'h_sigma_DD', total(h_sigma_DD), (total(h_sigma_DD))/(38209.^2)
printf, 12, h_sigma_DD
printf, 12
printf, 12
printf, 12, 'h_DD_2d', total(h_DD_2d),  (total(h_DD_2d)) / (38209.^2)
printf, 12, h_DD_2d
printf, 12
printf, 12


























device, /close
close, /all
end

