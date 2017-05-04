;+
; NAME:
;       nbc_kde
;
; PURPOSE:
;       To calculated correlation functions
;       for SDSS DR5 quasars. 
;
; EXPLANATION:
;
; CALLING SEQUENCE:
;       .run nbc_kde
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
;        Based on nbc_kde_v1_12.pro code in 
;        /Volumes/Bulk/npr/cos_pc19a_npr/programs/nbc_kde
;        
; NOTES:
;
; MODIFICATION HISTORY:
;       Version 1.13  NPR    15th October 2007
        
;-


print
print
;read, test_y_or_n, PROMPT='Is this a test run?? (y/n)'
;if test_y_or_n eq 'y' then N_gal = 100

; READING IN THE ORIGINAL ra,dec,redshift 2SLAQ LRG 8656 catalogue
readcol, '2SLAQ_LRG_cat/3yr_obj_v4_Sample8_nota01ao2s01_mini.cat', $
         object_id_in, ra_J2K_in, dec_J2K_in, z_fin_in, $
         format='a, d,d,d'

ra_J2K_min = min(ra_J2K_in)
dec_J2K_min = min(dec_J2K_in)
ra_J2K_max = max(ra_J2K_in)
dec_J2K_max = max(dec_J2K_in)
z_fin_min = min(z_fin_in)
z_fin_max = max(z_fin_in)


print, 'ra_J2K_min ',  ra_J2K_min, '   ra_J2K_max',  ra_J2K_max
print, 'dec_J2K_min', dec_J2K_min, '  dec_J2K_max', dec_J2K_max
print, 'z_fin__min ',   z_fin_min, '    z_fin_max',   z_fin_max
print

; READING IN THE ORIGINAL RANDOM file with RA,DEC,REDSHIFT
readcol, '2SLAQ_LRG_cat/rand_LRG_Sm8_spe.dat', $
         ra_rnd_in, dec_rnd_in, redshift_rnd_in
print, 'READ-IN  2SLAQ_LRG_cat/rand_LRG_Sm8_spe.dat '
print

; READING IN THE x,y,z 2SLAQ file 
;readcol, '2SLAQ_LRG_cat/3yr_obj_v4_Sample8_nota01ao2s01_xyz.dat', $
; x_LRG, y_LRG, z_LRG

; READING IN THE x,y,z  RANDOM file 
;readcol, '2SLAQ_LRG_cat/3yr_obj_v4_Sample8_nota01ao2s01_xyz_randoms.cat', $
;         x_coord_rnd, y_coord_rnd, z_coord_rdn
;         x_coord_rnd, y_coord_rnd, z_coord_rnd CALCULATED BEFORE 2nd LOOP

readcol, 'w_theta_files/w_theta_2SLAQ_Sam8_v3.dat', $
         degs_Sam8v3, arcmins_Sam8v3, w_theta_p_Sam8_v3, w_theta_z_nocor_Sam8_v3

one_plus_ws = ((1. +  w_theta_p_Sam8_v3) / (1. + w_theta_z_nocor_Sam8_v3))
print, one_plus_ws
print




; print, 'What is the z_prob for the photo-z quasars?'
;read, z_prob_in, PROMPT='What is the z_prob for the photo-z quasars?'
readcol, '../../data/Quasars/nbc_kde/nbckdedr3uvxqsos.060104.radeczpht.cat', $
;readcol, '../../data/Quasars/nbc_kde/nbckdedr3uvxqsos_2SLAQ_areas_editted.cat', ;$
         ra_quasar_in, dec_quasar_in, z_quasar_phot
;         numline = 10000
;;         psfmag_u psfmag_g psfmag_r psfmag_i psfmag_z, $
;;         psfmagerr_u psfmagerr_g psfmagerr_r psfmagerr_i psfmagerr_z, $
;;         extinction_u, extinction_g,extinction_r, extinction_i, extinction_z, $
;;         QSOdens STARdens zphot zphotlo zphothi zphotprob


;readcol, '../../data/Quasars/DR5/DR5_mini_M_i_fainthalf.dat', $
;         ObjID_quasar, ra_quasar, dec_quasar, z_quasar_spec


;readcol, '../../data/Quasars/2SLAQ/data_qso_0305_g_int_dustallz_final.cat', $
;         ra_quasar_in, dec_quasar_in, u,g,r,i,z_mag, qual, z_quasar_spec


;readcol, '../../data/Quasars/2SLAQ/DR5_2SLAQ_QSOs_v3_no_repeats.cat', $
;         ra_quasar, dec_quasar, u,g,r,i,z_mag, z_quasar_spec
    
z_quasar_in = z_quasar_phot
;z_quasar_in  = z_quasar_spec
     

ra_quasar_min = min(ra_quasar)
dec_quasar_min = min(dec_quasar)
ra_quasar_max = max(ra_quasar)
dec_quasar_max = max(dec_quasar)
z_quasar_min = min(z_quasar)
z_quasar_max = max(z_quasar)

print, 'ra_quasar_min ',  ra_quasar_min, '   ra_quasar_max',  ra_quasar_max
print, 'dec_quasar_min', dec_quasar_min, '  dec_quasar_max', dec_quasar_max
print, 'z_quasar_min ',   z_quasar_min, '    z_quasar_max',   z_quasar_max
print


ra_min = 0.0 ;60.0
ra_max = 360.0
;0.0 ;36.47 ;151.333 ;160.01 ;185.386 ;201.410; 210.096; 222.335; 324.035 ;360
;120.0 ;145.0 ;175.0 ;195.0 ;215.0 ;240.0 ;300.0 ;330.0 ;360.0 ;0.0 ;30.0;60.0



indx_J2K = where((ra_J2K_in ge ra_min) and (ra_J2K_in lt ra_max), N_LRG) 
print
print, 'N_LRG', N_LRG

ra_J2K    =  ra_J2K_in[indx_J2K]	
dec_J2K   =  dec_J2K_in[indx_J2K]	
z_fin     =  z_fin_in[indx_J2K]	

print, 'N_elements(ra_J2k)', N_elements(ra_J2K)
print, 'N_elements(dec_J2K)', N_elements(dec_J2k)
print, 'N_elements(z_fin)', N_elements(z_fin)



indx_rnd = where((ra_rnd_in ge ra_min) and (ra_rnd_in lt ra_max), N_rnd) 
print 
print, 'N_rnd', N_rnd 

ra_rnd       =   ra_rnd_in[indx_rnd]	
dec_rnd      =   dec_rnd_in[indx_rnd]	
redshift_rnd =   redshift_rnd_in[indx_rnd]	

print, 'N_elements(ra_rnd)',       N_elements(ra_rnd)
print, 'N_elements(dec_rnd)',      N_elements(dec_rnd)
print, 'N_elements(redshift_rnd)', N_elements(redshift_rnd)



;    ra_quasar_in, dec_quasar_in, u,g,r,i,z_mag, qual, z_quasar_spec_in
indx_qua = where((ra_quasar_in ge ra_min) and (ra_quasar_in lt ra_max), N_qua) 
print 
print, 'N_qua', N_qua

ra_quasar         =   ra_quasar_in[indx_qua]	
dec_quasar        =   dec_quasar_in[indx_qua]
z_quasar          =   z_quasar_in[indx_qua]

print, 'N_elements(ra_rnd)',       N_elements(ra_quasar)
print, 'N_elements(dec_rnd)',      N_elements(dec_quasar)
print, 'N_elements(redshift_rnd)', N_elements(z_quasar)




;openw, 9, 'junk.txt'
;openw, 11, 'good_NBC_KDE_quasars.dat'
;printf, 11, ' # 12237 `good` NBC KDE quasars.'

indx_quasar = where( $
              ( $
              (dec_quasar lt dec_J2K_max and dec_quasar gt dec_J2K_min) and $
              ( $
              (ra_quasar ge 136.71 and ra_quasar lt 143.40) or $
              (ra_quasar ge 150.00 and ra_quasar lt 167.99) or $
              (ra_quasar ge 185.00 and ra_quasar lt 192.84) or $
              (ra_quasar ge 197.18 and ra_quasar lt 214.00) or $
              (ra_quasar ge 218.01 and ra_quasar lt 229.94) or $
              (ra_quasar ge   8.65 and ra_quasar lt  16.50) or $
              (ra_quasar ge  32.64 and ra_quasar lt  38.16) or $
              (ra_quasar ge 319.51 and ra_quasar lt 328.61) or $
              (ra_quasar ge 342.30 and ra_quasar lt 352.60) $
              ) $ ;and $
;              ( z_quasar ge 0.2780 and z_quasar le 0.8833) $ ;and $
;               ( z_prob ge 0.8 ) $
               ), N_quasar)
print
print, 'N_quasar ', N_quasar
;printf, 9, 'indx_quasar'
;printf, 9, indx_quasar

;ObjID_quasar_good = ObjID_quasar(indx_quasar)  
ra_quasar_good    = ra_quasar(indx_quasar)
dec_quasar_good   = dec_quasar(indx_quasar)
z_quasar_good     = z_quasar(indx_quasar)
;z_prob_good       = z_prob(indx_quasar)

;printf, 9, 'ra_quasar_good'
;printf, 9, ra_quasar_good
;printf, 9, 'dec_quasar_good'
;printf, 9, dec_quasar_good

;close, 9






loadct, 6
set_plot, 'ps'
!P.MULTI = [0] 
device, filename='SDSS_Quasars_2SLAQ_LRG_Nofz.ps', xsize=8, ysize=8, xoffset=0, $
;device, filename='NBC_KDE_DR3_2SLAQ_LRG_temp.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0.5+(10-8), /inches, /color

plothist, z_quasar_good, bin=0.02, /fill, thick=2.2, xthick=2.2, $
          xrange=[0.2,1.0], yrange=[0,1200], $
          ythick=2.2, charsize=1.8, charthick=2.2, $
          title=' Object N(z)', xtitle='redshift, z', ytitle='Number', color=0

plothist, z_fin, bin=0.02, /overplot, thick=2.2, xthick=2.2, $
      ythick=2.2, charsize=1.8, charthick=2.2, $
      title=' Object N(z)', xtitle='redshift, z', ytitle='Number', color=63

xyouts,0.65,1000, '2SLAQ LRGs ', charsize=2.2, color=63, charthick=4
xyouts,0.65, 900, 'NBC-KDE DR3 ', charsize=2.2, color=0, charthick=4
xyouts,0.65, 900, 'NBC-KDE DR3 ', charsize=2.2, color=0, charthick=4
;xyouts,0.65, 900, 'NBC-KDE DR3 Quasars', charsize=2.2, color=0, charthick=4
device, /close

;print, z_quasar_good

;for i = 0, n_elements(ra_quasar_good)-1 do printf, 11, ra_quasar_good[i]
;
;close, 11


loadct, 6
;loadct, 34
set_plot, 'ps'
device, filename='DR5_quasars_allsky.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0.5+(10-8), /inches, /color

plot, ra_quasar_good, dec_quasar_good, xrange=[0.,360.], yrange=[-90.,90.], $
      psym=3, $
      xstyle=3, ystyle=3, thick=2.2, xthick=2.2, $
      ythick=2.2, charsize=1.8, charthick=2.2, $
      title='nbc_kde', xtitle='ra', ytitle='dec', color=0
oplot, ra_rnd, dec_rnd, psym=3, color=0
oplot, ra_J2K, dec_J2K, psym=3, color=64
oplot, ra_quasar_good, dec_quasar_good, psym=4, color=192
device, /close

!P.MULTI = [0, 1, 3] 
set_plot, 'ps'
device, filename='DR5_quasars_N_S1_S2.ps', $ ;xsize=10, ysize=7, $
;device, filename='nbc_kde_N.ps', xsize=8, ysize=8, xoffset=0, $
;        xoffset=0, yoffset=0.5+(10-8), $
;        xoffset=0.5, yoffset=0.5, $
;        /inches, /color, /landscape
        /color, /landscape

plot, ra_quasar_good, dec_quasar_good, xrange=[120,240], yrange=[-2.,2.], $
;plot, ra_quasar, dec_quasar, xrange=[120,240], yrange=[-2.5,2.5], $
;plot, ra_quasar, dec_quasar, $
      psym=3, $
      xstyle=3, ystyle=3, thick=2.2, xthick=2.2, $
      ythick=2.2, charsize=1.8, charthick=2.2, $
      title='nbc_kde_N', xtitle='ra', ytitle='dec', color=0, $
;      position=[0.10,0.70,0.9,0.95]
      position=[0.10,0.70,0.9,0.95]
oplot, ra_rnd, dec_rnd, psym=3, color=0
oplot, ra_J2K, dec_J2K, psym=4, color=64
oplot, ra_quasar_good, dec_quasar_good, psym=4, color=192

;device, /close


;set_plot, 'ps'
;device, filename='DR5_quasars_S1.ps', xsize=16, ysize=8, xoffset=0, $
;        yoffset=0.5+(10-8), /inches, /color
plot, ra_quasar_good, dec_quasar_good, xrange=[300,360], yrange=[-2.,2.], $
      psym=3, $
      xstyle=3, ystyle=3, thick=2.2, xthick=2.2, $
      ythick=2.2, charsize=1.8, charthick=2.2, $
      title='nbc_kde_S1', xtitle='ra', ytitle='dec', color=0, $
      position=[0.10,0.375,0.9,0.625]
oplot, ra_rnd, dec_rnd, psym=3, color=0
oplot, ra_J2K, dec_J2K, psym=4, color=64
oplot, ra_quasar_good, dec_quasar_good, psym=4, color=192
;device, /close


set_plot, 'ps'
;device, filename='DR5_quasars_S2.ps', xsize=16, ysize=8, xoffset=0, $
;        yoffset=0.5+(10-8), /inches, /color
plot, ra_quasar_good, dec_quasar_good, xrange=[0,60], yrange=[-2.,2.], $
      psym=3, $
      xstyle=3, ystyle=3, thick=2.2, xthick=2.2, $
      ythick=2.2, charsize=1.8, charthick=2.2, $
      title='nbc_kde_S2', xtitle='ra', ytitle='dec', color=0, $
      position=[0.10,0.05,0.9,0.30]
oplot, ra_rnd, dec_rnd, psym=3, color=0
oplot, ra_J2K, dec_J2K, psym=4, color=64
oplot, ra_quasar_good, dec_quasar_good, psym=4, color=192

!P.MULTI = [0] 
device, /close
set_plot, 'X'



print

redshift = 0.55
;openw, 10, '2SLAQ_LRG_redshifts.dat'
;printf, 10, ' # 8656 2SLAQ LRG redshifts and co-moving dists.'

rc_LRG = lumdist(z_fin, H0=100)
rc_LRG = rc_LRG/(1+z_fin)
;for i = 0, n_elements(z_fin)-1 do printf, 10, rc_LRG[i], z_fin[i]
;rc_LRG, rc_LRG/(1+redshift)
rc_LRG_test = lumdist(redshift, H0=100)
rc_LRG_test = rc_LRG_test/(1+redshift)
;printf, 10, ' test redshift, z=0.55, 925.16, 1434.9, 2222.7'
;printf, 10, rc_LRG_test, redshift
;close, 10


ra_rad_LRG = ra_J2K/180. * !dpi
dec_rad_LRG = dec_J2K/180. * !dpi

print
print, 'ra_J2K[0],      ra_rad_LRG[0]',    ra_J2K[0],      ra_rad_LRG[0]
print, 'ra_J2K,[N_LRG-1], ra_rad_LRG[N_LRG-1]', ra_J2K[N_LRG-1], ra_rad_LRG[N_LRG-1]
print, 'dec_J2K[0],    dec_rad_LRG[0]',    dec_J2K[0],    dec_rad_LRG[0]
print, 'dec_J2K[N_LRG-1], dec_rad_LRG[N_LRG-1]', dec_J2K[N_LRG-1], dec_rad_LRG[N_LRG-1]
print, 'dec_J2_min ', dec_J2K_min, ' dec_J2K_max ', dec_J2K_max


x_coord_LRG = rc_LRG * cos(dec_rad_LRG) * cos(ra_rad_LRG)  
y_coord_LRG = rc_LRG * cos(dec_rad_LRG) * sin(ra_rad_LRG)  
z_coord_LRG = rc_LRG * sin(dec_rad_LRG)


;N_LRG_sample = n_elements(x_coord_LRG)
N_LRG_sample = N_LRG
bin_DD = dblarr(60)
bin_DD_theta = dblarr(60)
;print, bin_DD
; 1ST LOOP 1ST LOOP 1ST LOOP ! 1ST LOOP 1ST LOOP 1ST LOOP 1ST LOOP 1ST   
; 1ST LOOP 1ST LOOP 1ST LOOP ! 1ST LOOP 1ST LOOP 1ST LOOP 1ST LOOP 1ST   
; 1ST LOOP 1ST LOOP 1ST LOOP ! 1ST LOOP 1ST LOOP 1ST LOOP 1ST LOOP 1ST
; 1ST LOOP 1ST LOOP 1ST LOOP ! 1ST LOOP 1ST LOOP 1ST LOOP 1ST LOOP 1ST
; 
; Now we're gonna try and work out the separation between these
; galaxies, these are the DATA-DATA point, DD.
;
;for i=0,N_LRG_sample-2 do begin

print
print, 'Just jumping into first, DD, loop now', N_LRG_sample
print
for i=0L,N_LRG_sample-2 do begin
;for i=0L,100 do begin
   
   if i eq  500 then print, 'in DD loop..',  i
   if i eq 1000 then print, 'in DD loop...',  i
   if i eq 2000 then print, 'in DD loop....',  i
   if i eq 4000 then print, 'in DD loop.....',  i
   
   for j=i+1, N_LRG_sample-1 do begin
      
      s_squared = s_sq(x_coord_LRG[i], y_coord_LRG[i], z_coord_LRG[i], $
                       x_coord_LRG[j], y_coord_LRG[j], z_coord_LRG[j])
      
      s= sqrt(s_squared)
      
      theta = sqrt(((ra_J2K(i)- ra_J2K(j))^2) + $
                   ((dec_J2K(i)-dec_J2K(j))^2))

      
      k         = fix((alog10(s)*10.) + 15.)
      k_theta   = fix((alog10(theta)*5.) + 25.)
;      k_theta   = fix((alog10(theta)*10.) + 40.)
      
      
     if k_theta gt 0 and k_theta le 15 then begin
         theta_cor = one_plus_ws(fix((alog10(theta)*5.0)+22))
;        print, theta, (theta*60.), theta_cor
      endif

      if k gt 0 and k le 56 then begin
         bin_DD[k]    = bin_DD[k] + 2
      endif

      if k_theta gt 0 and k_theta le 15 then begin
;         bin_DD_theta[k_theta] = bin_DD_theta[k_theta] + 2
         bin_DD_theta[k_theta] = bin_DD_theta[k_theta] + (2. * theta_cor)
      endif else if k_theta gt 15 and k_theta le 56 then begin
         bin_DD_theta[k_theta] = bin_DD_theta[k_theta] + 2
      endif
      
   endfor
endfor
print




rc_rnd = lumdist(redshift_rnd, H0=100)
rc_rnd = rc_rnd/(1.+redshift_rnd)

ra_rad_rnd = ra_rnd/180. * !dpi
dec_rad_rnd = dec_rnd/180. * !dpi

x_coord_rnd = rc_rnd * cos(dec_rad_rnd) * cos(ra_rad_rnd)  
y_coord_rnd = rc_rnd * cos(dec_rad_rnd) * sin(ra_rad_rnd)  
z_coord_rnd = rc_rnd * sin(dec_rad_rnd)


N_rnd = N_elements(ra_rnd)
;  2ND LOOP 2ND LOOP 2ND LOOP  2ND LOOP 2ND LOOP 2ND LOOP 2ND LOOP 2ND LOOP  2
;  2ND LOOP 2ND LOOP 2ND LOOP  2ND LOOP 2ND LOOP 2ND LOOP 2ND LOOP 2ND LOOP  2
;  2ND LOOP 2ND LOOP 2ND LOOP  2ND LOOP 2ND LOOP 2ND LOOP 2ND LOOP 2ND LOOP  2
;  2ND LOOP 2ND LOOP 2ND LOOP  2ND LOOP 2ND LOOP 2ND LOOP 2ND LOOP 2ND LOOP  2
;  
;  DR pair (aka G-R pairs...)
;  
bin_DR       = dblarr(60)
bin_DR_theta = dblarr(60)
print
print, ' Jumping into the second, DR, loop now ', N_LRG_Sample, N_rnd
print
for i = 0L, N_LRG_sample-1  do begin
;for i = 0, 100  do begin

   if i eq   100 then print, 'in 2nd, DR, aka GR, Loop..', i
   if i eq   500 then print, 'in 2nd, DR, aka GR, Loop...', i
   if i eq  1000 then print, 'in 2nd, DR, aka GR, Loop....', i
   if i eq  2000 then print, 'in 2nd, DR, aka GR, Loop.....', i
   if i eq  4000 then print, 'in 2nd, DR, aka GR, Loop......', i 
   if i eq  6000 then print, 'in 2nd, DR, aka GR, Loop.......', i
   
   for j=0L, N_rnd-1 do begin
   ;for j=0L, 17311 do begin
   ;for j=0L, 100 do begin
      
       s_squared = s_sq(x_coord_LRG[i], y_coord_LRG[i], z_coord_LRG[i], $
                        x_coord_rnd[j], y_coord_rnd[j], z_coord_rnd[j])
    
       s = sqrt(s_squared)
       
       
       theta = sqrt((  ( ra_J2K(i) -  ra_rnd(j))^2 ) + $
                    (  (dec_J2K(i) - dec_rnd(j))^2 )    )
 
       k = fix((alog10(s)*10) + 15)
       k_theta   = fix((alog10(theta)*5.) + 25.)
;       k_theta   = fix((alog10(theta)*10.) + 40.)
             
       
       if k gt 0 and k le 56 then begin
          bin_DR[k]             = bin_DR[k] + 1
       endif

       if k_theta gt 0 and k_theta le 56 then begin
          bin_DR_theta[k_theta] = bin_DR_theta[k_theta] + 1
       endif

    endfor
endfor


;close, 9









ra_rad_quasar = ra_quasar_good /180. *!dpi
dec_rad_quasar = dec_quasar_good /180. *!dpi

N_quasars = n_elements(ra_quasar_good)
print
print, 'N_quasar ', N_quasar, '  N_quasars ', N_quasars
N_Q = N_quasars

print
print, 'ra_quasar_good[0], ra_rad_quasar[0]',     $
        ra_quasar_good[0], ra_rad_quasar[0]
print, 'ra_quasar_good[N_Q], ra_rad_quasar[N_Q]', $
        ra_quasar_good[N_Q-1], ra_rad_quasar[N_Q-1]
print, 'dec_quasar_good[0], dec_rad_quasar[0]',  $ 
        dec_quasar_good[0], dec_rad_quasar[0]
print, 'dec_quasar_good[N_Q], dec_rad_quasar[N_Q]', $
        dec_quasar_good[N_Q-1], dec_rad_quasar[N_Q-1] 

rc_qua = lumdist(z_quasar_good, H0=100)
rc_qua = rc_qua/(1+z_quasar_good)

;openw, 11, 'Quasar_redshifts_nbc_kde.dat'
;openw, 11, 'Quasar_redshifts_DR5.dat'
;printf, 11, ' # 1130 `good` redshifts and co-moving dists.'
;for i = 0L, n_elements(z_quasar_good)-1 do begin
;   printf, 11, rc_qua[i], z_quasar_good[i] ;, ObjID_quasar_good[i]
;endfor
;close, 11

x_coord_qua = rc_qua * cos(dec_rad_quasar) * cos(ra_rad_quasar)  
y_coord_qua = rc_qua * cos(dec_rad_quasar) * sin(ra_rad_quasar)  
z_coord_qua = rc_qua * sin(dec_rad_quasar)




;  3RD LOOP 3RD LOOP 3RD LOOP  3RD LOOP 3RD LOOP 3RD LOOP
;  3RD LOOP 3RD LOOP 3RD LOOP  3RD LOOP 3RD LOOP 3RD LOOP
;  3RD LOOP 3RD LOOP 3RD LOOP  3RD LOOP 3RD LOOP 3RD LOOP
;  3RD LOOP 3RD LOOP 3RD LOOP  3RD LOOP 3RD LOOP 3RD LOOP
;  
;  Q-G pairs
;  
bin_QG       = dblarr(60)
bin_QG_theta = dblarr(60)
print
print, 'Just jumping into second, QG, loop now', N_Q, N_LRG_sample
print
for i = 0, N_Q-1  do begin
;for i = 0, 100  do begin

   if i eq  100 then print, 'in 3rd, QG loop..', i
   if i eq  500 then print, 'in 3rd, QG loop...', i
   if i eq 1000 then print, 'in 3rd, QG loop....', i
   
   for j=0, N_LRG_sample-1 do begin
      
       s_squared = s_sq(x_coord_qua[i], y_coord_qua[i], z_coord_qua[i], $
                       x_coord_LRG[j], y_coord_LRG[j], z_coord_LRG[j])
      
       s= sqrt(s_squared)
       theta = sqrt((  ( ra_quasar_good(i) -  ra_J2K(j))^2 ) + $
                    (  (dec_quasar_good(i) - dec_J2K(j))^2 )    )
       
       k       = fix((alog10(s)*10.) + 15.)
       k_theta = fix((alog10(theta)*5.) + 25.)
;       k_theta = fix((alog10(theta)*10.) + 40.)
       

       if k_theta gt 0 and k_theta le 15 then begin
          theta_cor = one_plus_ws(fix((alog10(theta)*5.0)+22))
       endif
       
       
       if k gt 0 and k le 56 then begin
          bin_QG[k]             = bin_QG[k] + 1
       endif
       
       
       if k_theta gt 0 and k_theta le 15 then begin
          bin_QG_theta[k_theta] = bin_QG_theta[k_theta] + 1
;          bin_QG_theta[k_theta] = bin_QG_theta[k_theta] + (1. * theta_cor)
       endif else if k_theta gt 15 and k_theta le 56 then begin
          bin_QG_theta[k_theta] = bin_QG_theta[k_theta] +1
       endif

    endfor
endfor





N_rnd = N_elements(ra_rnd)
print, 'N_rnd', N_rnd
;  4TH LOOP 4TH LOOP 4TH LOOP  4TH LOOP 4TH LOOP 4TH LOO
;  4TH LOOP 4TH LOOP 4TH LOOP  4TH LOOP 4TH LOOP 4TH LOOP
;  4TH LOOP 4TH LOOP 4TH LOOP  4TH LOOP 4TH LOOP 4TH LOOP
;  4TH LOOP 4TH LOOP 4TH LOOP  4TH LOOP 4TH LOOP 4TH LOOP
;  
;  Q-R pairs
;  
bin_QR       = dblarr(60)
bin_QR_theta = dblarr(60)
print
print, 'Just jumping into Fourth, QR, loop now, ', N_Q ,  N_rnd 
print
for i = 0, N_Q-1  do begin
;for i = 0, 100  do begin

   if i eq 1000 then print, 'in 4th, QR, loop....', i
   if i eq 2000 then print, 'in 4th, QR, loop.....', i
   if i eq 4000 then print, 'in 4th, QR, loop......', i
   if i eq 6000 then print, 'in 4th, QR, loop......', i
   if i eq 8000 then print, 'in 4th, QR, loop......', i
   

   for j=0L, N_rnd-1 do begin
   ;for j=0L, 100 do begin
      
       s_squared = s_sq(x_coord_qua[i], y_coord_qua[i], z_coord_qua[i], $
                       x_coord_rnd[j], y_coord_rnd[j], z_coord_rnd[j])
    
       s = sqrt(s_squared)
       
       theta = sqrt((  ( ra_quasar_good(i) -  ra_rnd(j))^2 ) + $
                    (  (dec_quasar_good(i) - dec_rnd(j))^2 )    )
 
       k = fix((alog10(s)*10) + 15)
       k_theta = fix((alog10(theta)*5.) + 25.)
;       k_theta = fix((alog10(theta)*10.) + 40.)

       if k_theta gt 0 and k_theta le 15 then begin

       endif
       
       if k gt 0 and k le 56 then begin
          bin_QR[k]             = bin_QR[k] + 1
       endif
       
       if k_theta gt 0 and k_theta le 56 then begin
          bin_QR_theta[k_theta] = bin_QR_theta[k_theta] + 1
       endif

    endfor
endfor

;close, 9




n_ratio_GQ = (float(N_elements(ra_J2K)) / float(N_elements(ra_quasar_good)))
print, 'n_ratio_GQ, N_LRG_sample, N_Quasars'
print, n_ratio_GQ, N_elements(ra_J2K), N_elements(ra_quasar_good)

n_ratio_DR = (float(N_elements(ra_rnd)) / float(N_elements(ra_J2K)))
print, 'n_ratio, N_rnd, N_LRG_sample'
print, n_ratio_DR, N_elements(ra_rnd), N_elements(ra_J2K)


xi   = dblarr(60)
xi_Q = dblarr(60)
delta_xi = dblarr(60)
bin_DD_plot    = dblarr(45)
bin_DR_plot    = dblarr(45)
bin_QG_plot    = dblarr(45)
bin_QR_plot    = dblarr(45)
s_check        = dblarr(45)
;openw, 12, 'kde_output_temp.dat'
openw, 12, 'k_DR5_output_temp.dat'
printf, 12, ' # k, 10^((float(k)-12.+0.5)/10.), bin_DD(k), bin_DR(k), bin_QG(k), bin_QR(k), xi(k), delta_xi, xi_Q(k)'
;for k =1, 56  do begin
for k =1, 40  do begin

   if bin_DR(k) ne 0L then begin
      xi(k)    = N_ratio_DR * ( bin_DD(k) / bin_DR(k))   - 1.0
   delta_xi(k) = (1. + xi(k)) * (sqrt(2.0/bin_DR(k)))
   endif else begin
      xi(k) = 0.
   endelse

   if bin_QR(k) ne 0L then begin
      xi_Q(k)    = n_ratio_DR * ( bin_QG(k) / bin_QR(k))   - 1.0
;   delta_xi_Q(k) = (1. + xi(k)) * (sqrt(2.0/bin_QG(k)))
;            Coil et al., 2007, ApJ, 654, 115, Eq. (3). 
   endif else begin
      xi_Q(k) = 0.
   endelse

   printf, 12, k, 10^((float(k)-15.+0.5)/10.), $
           bin_DD(k), bin_DR(k), bin_QG(k), bin_QR(k), $
           xi(k), delta_xi(k), xi_Q(k), format='(i,1x,d12.7,1x, i16,1x,i16,1x,i16,1x,i16,1x,  d16.6,1x,d16.6,1x,d16.6)'

   bin_DD_plot[k-1] = bin_DD[k]
   bin_DR_plot[k-1] = bin_DR[k]
   bin_QG_plot[k-1] = bin_QG[k]
   bin_QR_plot[k-1] = bin_QR[k]
   s_check[k-1] = 10^((float(k)-15.+0.5)/10.)

endfor
close, 12

loadct, 25
set_plot, 'ps'
device, filename='DDs_DRs_check.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0.5+(10-8), /inches, /color
plot, s_check, bin_DD_plot, /xlog, /ylog, $
      xrange=[0.010, 5000.0], yrange=[0, 100000000], xstyle=1, ystyle=1., $
      xtitle='theta / arcmins', ytitle=' No. of pairs' 
xyouts, 50.0, 256., 'bin_DD',charsize=2.2,charthick=3

oplot, s_check, bin_DR_plot, color = 64
xyouts, 50.0, 64., 'bin_DR',charsize=2.2,charthick=3, color=64
oplot, s_check, bin_QG_plot, color = 128, thick=5.
xyouts, 50.0, 16., 'bin_QG',charsize=2.2,charthick=3, color=128
oplot, s_check, bin_QR_plot, color = 256, thick=5.
xyouts, 50.0, 4., 'bin_QR',charsize=2.2,charthick=3, color=256
device, /close






w_theta_QG        = dblarr(60)
w_theta_2SLAQ     = dblarr(60)
delta_w_theta_DR  = dblarr(60)
delta_w_theta_QG  = dblarr(60)
bin_DD_theta_plot          = dblarr(60)
bin_DR_theta_plot          = dblarr(60)
bin_QG_theta_plot          = dblarr(60)
bin_QR_theta_plot          = dblarr(60)
arcmin_check         = dblarr(60)
;print, w_theta_2SLAQ

;openw,  13, 'w_theta_nbc_kde_temp.dat'
openw,  13,  'w_theta_DR5_temp.dat'
printf, 13, ' #  k_theta,   degrees,    arcmins,  bin_QG,  bin_QR'

;openw,  14, 'w_theta_2SLAQ_nbc_kde_temp.dat'
openw,  14, 'w_theta_2SLAQ_LRG_check.dat'
printf, 14, ' #  k_theta,   degrees,    arcmins,    bin_DD,   bin_DR'
;for k_theta =1, 45  do begin  ; this works for (alog(theta)*5 + 25)
for k_theta =1, 50  do begin

   if bin_DR_theta(k_theta) ge 0.0 then begin
      w_theta_2SLAQ(k_theta) = (n_ratio_DR * ( bin_DD_theta[k_theta] / $
                                               bin_DR_theta[k_theta])) -1.
      delta_w_theta_DR(k_theta)  = (1. + w_theta_2SLAQ(k_theta)) * $
                                   (sqrt(1.0/bin_DR_theta(k_theta)))
   endif else begin
      w_theta_2SLAQ(k_theta) =0.000
   endelse
   
   
   if bin_QR_theta(k_theta) ge 0.0 then begin
      w_theta_QG(k_theta) = (n_ratio_DR * ( bin_QG_theta[k_theta] / $
                                            bin_QR_theta[k_theta])) -1.
      delta_w_theta_QG(k_theta)  = (1. + w_theta_QG(k_theta)) * $
                                   (sqrt(1.0/bin_QR_theta(k_theta)))
   endif else begin
      w_theta_QG(k_theta) = 0.000
   endelse

;   delta_xi(k) = (1. + xi(k)) * (sqrt(2.0/bin_QG(k)))

   ;k_theta = fix((alog10(theta)*5.) + 25.)   

   printf, 13, k_theta, 10^((float(k_theta)-25.+0.5)/5.), $
           10^((float(k_theta)-25.+0.5)/5.)*60., $
;   printf, 13, k_theta, 10^((float(k_theta)-40.+0.5)/10.), $
;           10^((float(k_theta)-40.+0.5)/10.)*60., $
           bin_QG_theta(k_theta), bin_QR_theta(k_theta), $
           w_theta_QG(k_theta), delta_w_theta_QG(k_theta), $
           format='(i,1x, d14.6,1x,d14.6,2x, d15.2,1x,d15.2,2x, d16.8,1x,d16.8)'  

   printf, 14, k_theta, 10^((float(k_theta)-25.+0.5)/5.), $
           10^((float(k_theta)-25.+0.5)/5.)*60., $
;   printf, 14, k_theta, 10^((float(k_theta)-40.+0.5)/10.), $
;           10^((float(k_theta)-40.+0.5)/10.)*60., $
           bin_DD_theta(k_theta), bin_DR_theta(k_theta), $
           w_theta_2SLAQ(k_theta),  delta_w_theta_DR(k_theta), $
           format='(i,1x, d14.6,1x,d14.6,2x, d15.2,1x,d15.2,2x, d16.8,1x,d16.8)'            

   bin_DD_theta_plot[k_theta-1] = bin_DD_theta[k_theta]
   bin_DR_theta_plot[k_theta-1] = bin_DR_theta[k_theta]
   bin_QG_theta_plot[k_theta-1] = bin_QG_theta[k_theta]
   bin_QR_theta_plot[k_theta-1] = bin_QR_theta[k_theta]

;   arcmin_check[k_theta-1] = 10^((float(k_theta)-25.+0.5)/5.)/60
   arcmin_check[k_theta-1] = 10^((float(k_theta)-40.+0.5)/10.)/60
   ;theta  = 10^((float(k_theta)-12.+0.5)/10.)     
endfor
close, 13
close, 14


loadct, 25
set_plot, 'ps'
device, filename='DDs_DRs_theta_check.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0.5+(10-8), /inches, /color
plot, arcmin_check, bin_DD_theta_plot, /xlog, /ylog, $
      xrange=[0.000001, 500.0], yrange=[0., 10000000000], xstyle=1, ystyle=1., $
      xtitle='theta / arcmins', ytitle=' No. of pairs' 
xyouts, 1.0,256., 'bin_DD',charsize=2.2,charthick=3

oplot, arcmin_check, bin_DR_theta_plot, color = 64
xyouts, 1.0,64., 'bin_DR',charsize=2.2,charthick=3, color=64
oplot, arcmin_check, bin_QG_theta_plot, color = 128, thick=5.
xyouts, 1.0,16., 'bin_QG',charsize=2.2,charthick=3, color=128
oplot, arcmin_check, bin_QR_theta_plot, color = 256, thick=5.
xyouts, 1.0,4., 'bin_QR',charsize=2.2,charthick=3, color=256
device, /close

print

total_bin_DD = total(bin_DD)
total_bin_DR = total(bin_DR)
total_bin_QG = total(bin_QG)
total_bin_QR = total(bin_QR)

total_bin_DD_theta = total(bin_DD_theta)
total_bin_DR_theta = total(bin_DR_theta)
total_bin_QG_theta = total(bin_QG_theta)
total_bin_QR_theta = total(bin_QR_theta)

print
print
print, 'total_bin_DD', total_bin_DD, float(total_bin_DD)/(8656.^2)
print, 'total_bin_DR', total_bin_DR, float(total_bin_DR)/(8656.*173120.)
print, 'total_bin_QG', total_bin_QG, float(total_bin_QG)/(float(N_Q)*8656.) 
print, 'total_bin_QR', total_bin_QR, float(total_bin_QR)/(float(N_Q)*173120.) 
print
print
print, 'total_bin_DD_theta', total_bin_DD_theta, float(total_bin_DD_theta)/(8656.^2)
print, 'total_bin_DR_theta', total_bin_DR_theta, float(total_bin_DR_theta)/(8656.*173120.)
print, 'total_bin_QG_theta', total_bin_QG_theta, float(total_bin_QG_theta)/(float(N_Q)*8656.) 
print, 'total_bin_QR_theta', total_bin_QR_theta, float(total_bin_QR_theta)/(float(N_Q)*173120.) 
print
print


device, /close
close, /all































end

