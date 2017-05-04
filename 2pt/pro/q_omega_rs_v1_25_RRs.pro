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


openw, 11, 'h_from_bin_DD.dat'
openw, 12, 'h_from_bin_DD_2d.dat'



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








device, /close
close, /all
end

