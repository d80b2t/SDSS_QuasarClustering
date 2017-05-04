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
bin_DR_2dt   = fltarr(100,100)
for i = 0L, N_LRG_sample-1  do begin
;for i = 0L, 100  do begin
;for i = 0, 1  do begin
   
   if i MOD 433 eq 0 then print, ( (double(i) / 8656.)*100.), '% DRs done'
  
   pi_para_one[i] = sqrt(s_sq(x_coord_LRG[i], y_coord_LRG[i], z_coord_LRG[i], $
                              0,0,0))
   
   for j=0L, N_rnd-1 do begin
;   for j=0L, 17311 do begin
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














close, 11
close, 12










device, /close
close, /all
end

