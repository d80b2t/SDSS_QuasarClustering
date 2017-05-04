;pro plotEvolution
  
  print
  print
  print, '------------------------------------------------------'
  print, '------------------------------------------------------'
  print, '!!!!! You have to run the "red" routine before this !!'
  print, ' IDL> red         '
  print, '   red, omega0 = 0.228, omegalambda = 0.772, h100=0.702    ' ;; (Komatsu et al. 2011) 
;  print, '  red, omega0=0.272, omegalambda=0.728, h100=0.702   '
;  print, '  red, omega0=0.30, omegalambda=0.70, h100=0.70   '
  print, ' IDL> .run plotEvolution_npr  '
  print, ' IDL> plotEvolution  '
  print, '------------------------------------------------------'
  print, '------------------------------------------------------'
  print

  ;; Using WMAP7+BAO+H0 ML, the best, current cosmology is 
  ;; red, omega0=0.272, omegalambda=0.728, h100=0.702
  ;; See e.g. http://letterstonature.wordpress.com/2010/01/29/wmap-7-cosmological-parameter-set

  numErr = 5                    ;100
  
  location = 'fits_disp_gamma1.0_eta0.5'
  
  ;;
  ;; Means "data" is SDSS DR7Q
  ;;
  ;;data = mrdfits('DR5QSO_uni_data.fits', 1)
  data = mrdfits('../../../data/SDSS/DR7Q/dr7qso.fits', 1)
  w_dr7q_uniform = where(data.USELFLAG eq 1, N_dr7q_uniform)  
  data = data[w_dr7q_uniform]
  
  gam = 1.0
  eta = 0.5
  
  col0 = 0 & col1 = 60 & col2 = 150 & col3 = 60
  ls0 = 0 & ls1 = 5 & ls2 = 1
  ssiz = 2.0
  hat = 100
;  tck = 4 & tck2 = 2
  tck = 8 & tck2 = 4
  csiz = 1.8 & csiz2 = 0.9
  
  !x.thick = 2
  !y.thick = 2
  !p.charthick = 2
  
  close, 1
  
  
  numz = 100
  rs = findgen(numz)/10
  
  mvir = 10.0^((findgen(60)/10)+10.0)
  numm = n_elements(mvir)

  mass = fltarr(numz, numm)
  mag = fltarr(numz, numm)
  Phi = fltarr(numz, numm)

  px = fltarr(numz)
  py = fltarr(numz)


  for i=0L, numz-1 do begin
     
     G = 4.3e-9
     H0 = 100.0
     Hz = H0 * sqrt(0.3*(1.0+rs[i])^3.0 + 0.7)
     ;Hz = H0 * sqrt(0.25*(1.0+rs[i])^3.0 + 0.75)
     
     vvir = (10.0*G*Hz*mvir)^(1.0/3.0)
     
     ;; Baes et al. 2003 Eq.3
     ;sigma = (alog10(gam*vvir/200.0) - 0.21) / 0.96
     ;; Tremaine et al. 2002
     ;mBH = 8.13 + 4.02*sigma
     
     mBH = 7.25 + 4.18 * alog10(gam*vvir/200.0)          ;in h=0.7 units
     Lbol = eta * 3.3e4*(10.0^mBH)                       ;in h=0.7 units
     magQ = -2.66*(alog10(Lbol)+alog10(3.839e26)) + 79.42 ;in h=0.7 units
     
     ;; Hopkins et al. 2006 Eq.2
     ;LB = Lbol / ( 6.25*(Lbol/1e10)^(-0.37) + 9.00*(Lbol/1e10)^(-0.012) )
     ;magB = -2.5*alog10(LB) + 5.41
     ;magQ = magB - 0.07
          
     ;; Croom et al. 2004 QLF
     ;; First row, Table 5
;    PhiStar = 1.7e-6
;    alpL = -3.3 & betL = -1.1
;    Mstar0 = -21.6
;    k1 = 1.4 & k2 = -0.3
     
     ;; Croom et al. 2009 QLF
     ;; LEDE Model, Table 4
     PhiStar = 1.62e-6
     alpL = -3.48 & betL = -1.4
     Mstar0 = -22.24
     k1 = 1.23 & k2 = -0.206
     
     if rs[i] gt 3.0 then begin
        alpL = alpL + 0.5*(rs[i]-3.0)
        k1 = 1.22 & k2 = -0.23
     endif
     
     Mstar = Mstar0 - 2.5*(k1*rs[i] + k2*rs[i]*rs[i])
     
     Phi[i, *] = PhiStar / ( (10.0^(0.4*(alpL+1)*(magQ-Mstar))) + (10.0^(0.4*(betL+1)*(magQ-Mstar))) )
     
     mag[i, *] = magQ
     mass[i, *] = mvir
     
  endfor
  print
  print
  
  
;; Need to work out M_i for 2SLAQ QSOs       To calculate Quasar Luminosity fucntions
;; Setting up a flat, H0 = 71.9 kms^-1 Mpc^-1 cosmology
;; DLUMINOSITY will not work unless this is set-up...
  ;red, omega0=0.27, omegalambda=0.73, h100=0.719
  print
  print

;  boss = mrdfits('../../../BOSS/data/spAll/spAll-v5_4_9.fits', 1)
 ; boss = mrdfits('../../../BOSS/data/spAll/spAll-v5_4_14_QSOtargs.fits', 1)
  boss =mrdfits('../../../boss/YOD/spAll-v5_4_14_QSOtargs_YearOne.fits',1)

  target_flag = 16492675464192LL ;; 
  boss_qsos     = where( ((boss.boss_target1 and target_flag) ne 0) $
                     and boss.zWarning eq 0 and $
                     boss.z ge 0.02 and boss.z lt 5.10, N_boss_qsos)

  boss_qsos_hiz = where( ((boss.boss_target1 and target_flag) ne 0) $
                     and boss.zWarning eq 0 and $
                     boss.z ge 2.20 and boss.z lt 5.10, N_boss_qsos_hiz)

  print, 'N_boss_qsos with 3298535930880LL, zwarning=0 and z>=0.02, ', N_boss_qsos
  print, 'N_boss_qsos with 3298535930880LL, zwarning=0 and z>=2.20, ', N_boss_qsos_hiz
  print
  print
  
  boss_ra   = boss[boss_qsos].ra
  boss_dec  = boss[boss_qsos].dec
  boss_red  = boss[boss_qsos].z
  boss_imag = boss[boss_qsos].PSFMAG[3]

  readcol, '2SLAQ_QSO_mini.cat', ra, dec, $
           u_2slaq,  g_2slaq, r_2slaq, i_2slaq, z_2slaq, $
           red_2slaq
  ;; Reading in the Richards06 k-correction
  ;; Normalized at z=2. 
   readcol, 'Richards_2006_Table4.dat', kcor_redshift, kcor, /silent
   print, 'Richards06_kcor.dat READ-IN', n_elements(kcor)
   print
  
   ;; set an i-band limit as a guide...

   i_band_mag = findgen(600)
   i_band_mag_bright = findgen(600)

   for ii=0ll, N_elements(i_band_mag)-1 do begin
      i_band_mag_bright[ii] = 18.00
      i_band_mag[ii]        = 22.00
   endfor
   i_band_mag_red = findgen(600)/100

  ;; Running the DLUMINOSITY command from the red.pro routine
;; Returns LUMINOSITY DISTANCES (using the above cosmology)
;; Divide by 1e6 to get into Mpc
  
  print, 'Doing DLUMS....'
;  dlums_dr5   = DLUMINOSITY(data.z)    / 1e6
;  dlums_2slaq = DLUMINOSITY(red_2slaq) / 1e6
;  dlums_boss  = DLUMINOSITY(boss_red)  / 1e6
  dlums_ibandmag        = DLUMINOSITY(i_band_mag_red)  / 1e6
  
  print, 'DLUMS calculated '
  print
  
;; Setting up a "redshift" array that will
;; be used to produce Luminosity Distance values
  zphot_limit   = (findgen(61))/10.
  
;; These luminosity distance values are then used
;; with the bright and faint Kmag limits for the 
;; e.g. Abs Mag vs. redshift plots.
  dlumsK_limit =  DLUMINOSITY(zphot_limit) /1e6
  
;; Working out the ABSOLUTE MAGNITUDE for each object
;; Note DIST_MOD = 5 log (D_L /10pc) which means if D_L is in Mpc:
;  Abs_iM_dr5   =  data.BEST_I[0] - (5 * alog10(dlums_dr5))   - 25.00 - kcor(fix(data.z/0.01))
  Abs_iM_dr5   =  data.IMAG - (5 * alog10(dlums_dr5))   - 25.00 - kcor(fix(data.z/0.01))
  Abs_iM_2slaq =  i_2slaq        - (5 * alog10(dlums_2slaq)) - 25.00 - kcor(fix(red_2slaq/0.01)) 
  Abs_iM_boss  =  boss_imag      - (5 * alog10(dlums_boss))  - 25.00 - kcor(fix(boss_red/0.01))
  Abs_i_limit        = i_band_mag        - (5* alog10(dlums_ibandmag)) - 25.00 - kcor(fix(i_band_mag_red/0.01))
  Abs_i_limit_bright = i_band_mag_bright - (5* alog10(dlums_ibandmag)) - 25.00 - kcor(fix(i_band_mag_red/0.01))

  print, 'Absolute i-band Mags calculated '
  print
  
  plot, boss_red,   boss_imag, $
        psym=3, $
        xrange=[0.0, 5.5], $
        yrange=[17.0, 22.5], $
        xstyle=1, ystyle=1        

  w_s82 = where(boss_ra lt 60.0 or boss_ra gt 300. and $
                (boss_dec ge -1.25 and boss_dec le 1.25), N_s82)

  formatstring='(f10.5,1x, f10.5,1x, f10.5,1x, f10.5,1x, f10.5)'
  openw, 10, 'BOSS_QSO_redshifts_AbsM_i_temp.dat'
;  for i=0LL, N_elements(Abs_iM_boss)-1 do begin
  for i=0LL, N_S82-1 do begin
     printf, 10, boss_ra[w_s82[i]], boss_dec[w_s82[i]], boss_red[w_s82[i]], boss_imag[w_s82[i]], Abs_iM_boss[w_s82[i]], $
             format=formatstring
  endfor
  close, 10
  

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  ;;;;;;;;  model errors
  
  ; redshifts = ['0.00', '0.51', '0.83', '1.08', '1.28', '1.39', '1.50', '1.63', $
  ;   '1.91', '2.42', '2.83', '3.06', '3.31', '3.87', '4.18', '4.89']
  ; numz = n_elements(redshifts)
  ; 
  ; mm = ['12.0', '12.5', '13.0', '13.5', '14.0']
  ; numM = n_elements(mm)
  ; 
  ; magMean = fltarr(numz, numM)
  ; magVar = fltarr(numz, numM)
  ; 
  ; 
  ; for i=0L, numz-1 do begin
  ; 
  ;   numgals = 0L
  ;   filename = strcompress('./model/errors/errors_0/master2_'+redshifts[i], /remove_all)
  ;   close, 1 & openr, 1, filename & readu, 1, numgals & close, 1
  ; 
  ;   mag = fltarr(numM, numgals)
  ;   mass = fltarr(numgals)
  ; 
  ; 
  ;   for err=0L, numErr-1 do begin
  ; 
  ;     numgals = 0L
  ; 
  ;     filename = strcompress('./model/errors/errors_'+string(err)+'/master2_'+redshifts[i], /remove_all)
  ;     print, 'reading file ', filename
  ;     close, 1 & openr, 1, filename
  ;     readu, 1, numgals
  ;     readu, 1, frac
  ; 
  ;     IN = { $    
  ;       magQ   : 0.0, $
  ;       quasar : 0.0  $
  ;       }
  ; 
  ;     IN2 = replicate(IN, numgals)
  ; 
  ;     readu, 1, IN2    
  ;     close, 1
  ;     mag[err, *] = IN2.magQ
  ; 
  ;   endfor
  ; 
  ; 
  ;   filename = strcompress('./model/master1_'+redshifts[i], /remove_all)
  ;   print, 'reading file ', filename
  ;   close, 1 & openr, 1, filename
  ;   readu, 1, numgals
  ; 
  ;   IN2 = { $    
  ;     mvir         : 0.0, $
  ;     vvir         : 0.0, $
  ;     x            : 0.0, $
  ;     y            : 0.0, $
  ;     z            : 0.0, $
  ;     velx         : 0.0, $
  ;     cent         : 0.0  $
  ;     }
  ; 
  ;   IN2 = replicate(IN2, numgals)
  ; 
  ;   readu, 1, IN2    
  ;   close, 1
  ;   mass = IN2.mvir
  ; 
  ; 
  ;   for mbin = 0, numM-1 do begin
  ;     w = where(mvir lt mm[i]+0.1 and mvir gt mm[i]-0.1, Num)
  ;     if Num gt 0 then begin
  ;       resistant_mean, mag[*, w], 999999, meanval, meansig, Nrej
  ;       magMean[i, mbin] = meanval
  ;       magVar[i, mbin] = (meansig*sqrt(Num-Nrej-1))
  ;     endif
  ;   endfor
  ; 
  ; 
  ; endfor

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  set_plot, 'PS'
  device, color = 1, $
;          filename = './figures/quasarEvolution_'+location+'.ps', $
          filename = 'Croton09_temp.eps', $
          xsize = 21.0, ysize = 11.5, $
          yoffset = 0.2,  xoffset = 0.2,  /encapsulated
  
  ymin = -20.0 & ymax = -30.0
;  ymin = -18.0 & ymax = -30.0
  xmin = 11.7 & xmax = 14.3
  
  range = [1.0e-4, 1.0e-9]
  c_level = reverse(loglevels(range))
  
  min_red =0.0
  max_red =5.3

  XTICKLEN  = 0.05
  YTICKLEN  = 0.05

  ;; Dashed lines = host halo space density, as inferred
  contour, phi, rs, mag, $
           position=[0.16, 0.20, 0.84, 0.96], $
           /follow, $
           xrange = [min_red, max_red], $
           yrange = [ymin, ymax], $
           xstyle = 1, ystyle = 9, $
           levels = c_level, $
           thick=4, $
           c_linestyle = ls1, $
           charsize = csiz, charthick=4.4, $
           c_color = col3, $    ;, c_colors = col1
           /nodata, $
           XTICKLEN=XTICKLEN, YTICKLEN=YTICKLEN, $
           xtitle = 'redshift',  $
           ytitle = 'M!DbJ!N - 5logh!D70!N' 

  plotsym, 0, 0.35, /fill
  bigboss = 'y'
  if bigboss eq 'y' then begin
     

     ;; 2SLAQ QSO L-z distribution
     loadct, 39
     plotsym, 0, 0.25, /fill
     oplot, red_2slaq, Abs_iM_2slaq, psy=8, color= 100
     
     plotsym, 0, 0.20, /fill
     ;; BOSS L-z distribution!!
     oplot, boss_red,  Abs_iM_boss, psy=8, color= 254
     
     ;; SDSS DR5 L-z distribution
     plotsym, 0, 0.15, /fill
     ;;taking out the i=19.1 for SDSS low-z, 
     ;; i = 20.2 for high-z SDSS selection
;     high_z = where(data.z ge 2.90, N_highz)
;     data[high_z].imag =  data[high_z].imag - 1.1
     ;oplot, data.z,   data.imag,  psym=8, color=0  
     oplot, data.z, Abs_iM_dr5,    psym=8, color=0
     
     plotsym, 0, 0.35, /fill
     ;; Assuming BigBOSS goes to r_AB=23.4
     ;; and r-i ~ 0.3 for QSOs...
     plotsym, 0, 0.35, /fill
;     oplot, data.z,   (data.imag+3.80), psym=8   , color=254
     
     ;; i=21.85 limit 
     oplot, i_band_mag_red, Abs_i_limit,        color=128., thick=6.0
     oplot, i_band_mag_red, Abs_i_limit_bright, color=128., thick=6.0


     plotsym, 0, 0.6, /fill
     legend, [' '], psym=8,  color=0,  pos=[3.4,-24.7], $
             box=0, thick=8, charsize=1.8, charthick=2.8
     legend, [' '], psym=8, color=100, pos=[3.4,-23.2], $
             box=0, thick=8, charsize=1.8, charthick=2.8
     legend, [' '], psym=8, color=254, pos=[3.4,-21.7], $
             box=0, thick=8, charsize=1.8, charthick=2.8
;     legend, [' '], psym=8, color=254, pos=[3.4,-19.5], $
 ;            box=0, thick=8, charsize=1.8, charthick=2.8
;     xyouts, 3.9, -24.0, 'SDSS DR5' , color=0,   charsize=1.6, charthick=4.8
     xyouts, 3.9, -24.0, 'SDSS DR7' , color=0,   charsize=1.6, charthick=4.8
     xyouts, 3.9, -22.5, '2SLAQ QSO', color=100, charsize=1.6, charthick=4.8
     xyouts, 3.9, -21.0, 'BOSS'     , color=254, charsize=1.6, charthick=4.8
;     xyouts, 3.9, -18.5, 'BigBOSS'  , color=254, charsize=1.4, charthick=5.8
;     xyouts, 4.5, -26.5, 'i=21.85', color=128, charsize=1.3, charthick=4.8
     xyouts, 4.5, -26.5, 'i=22.00', color=128, charsize=1.3, charthick=4.8
     xyouts, 0.5, -28.2, 'i=18.00', color=128, charsize=1.3, charthick=4.8
  endif
  

  mm =  ['12.0', '12.5', '13.0', '13.5', '14.0']
  mm2 = ['6.0', '7.0', '8.0', '9.0', '10.0']

;  mm  = ['11.0', '11.5', '12.0', '12.5', '13.0', '13.5', '14.0']
;  mm2 = ['5.0', '6.0', '7.0', '8.0', '9.0', '10.0', '10.0']

  for j=0L, n_elements(mm)-1 do begin

    G = 4.3e-9
    H0 = 100.0
    Hz = H0 * sqrt(0.3*(1.0+rs)^3.0 + 0.7)
    ; Hz = H0 * sqrt(0.25*(1.0+rs)^3.0 + 0.75)

    vvir = (10.0*G*Hz*(10.0^mm[j]))^(1.0/3.0)
    mBH = 7.25 + 4.18 * alog10(gam*vvir/200.0)  ;in h=0.7 units
    Lbol = eta * 3.3e4*(10.0^mBH)  ;in h=0.7 units

    ;; Hopkins et al. 2006 Eq.2
    ; LB = Lbol / ( 6.25*(Lbol/1e10)^(-0.37) + 9.00*(Lbol/1e10)^(-0.012) )
    ; magB = -2.5*alog10(LB) + 5.41
    ; magQ = magB - 0.07

    magQ = -2.66*(alog10(Lbol)+alog10(3.839e26)) + 79.42  ;in h=0.7 units

    ;; 
    ;;  Lines of constant halo masses
    ;;
    loadct, 39
;    oplot, rs, magQ, linestyle = ls0, color = col1, thick = tck
    
    ; Lbol = eta * 10.0^( -1.99 + 1.39*alog10((gam^3.0)*Hz*((10.0^mm[j])/(1.0e13))) ) * 1.0e12
    ; magQ = -2.66*(alog10(Lbol)+alog10(3.839e26)) + 79.42  ;in h=0.7 units
    ; oplot, rs, magQ, linestyle = 1, color = col1, thick = tck

    ;;
    ;; Lines of constant BH mass
    ;;
    loadct, 0
    mBH = 1.0*mm2[j]*Hz/Hz
    Lbol = eta * 3.3e4*(10.0^mBH)
    magQ = -2.66*(alog10(Lbol)+alog10(3.839e26)) + 79.42
;    oplot, rs, magQ, color = col2, thick = tck2, linestyle = ls2

  endfor


  ;; legend, 'log M!Dhalo!N='+mm[0], box=0, charsize = csiz2, pos=[1.25, -22.2]
;  legend, 'log M!Dhalo!N='+mm[0], box=0, charsize = csiz2, charthick=3.0, pos=[0.65, -22.9]
  ;; legend, 'log M!Dhalo!N='+mm[4], box=0, charsize = csiz2, pos=[1.7, -30.0]
 ; legend, 'log M!Dhalo!N='+mm[4], box=0, charsize = csiz2, charthick=3.0, pos=[0.3, -30.0]

;;  legend, 'log M!DBH!N='+mm2[0], box=0, charsize = csiz2, charthick=4.0, pos=[4.85, -19.0], /clear
 ; legend, 'log M!DBH!N='+mm2[0], box=0, charsize = csiz2, charthick=4.0, pos=[4.85, -21.5], /clear
;;  legend, 'log M!DBH!N='+mm2[1], box=0, charsize = csiz2, charthick=4.0, pos=[4.85, -21.5], /clear
 ; legend, 'log M!DBH!N='+mm2[4], box=0, charsize = csiz2, charthick=4.0, pos=[4.76, -29.5], /clear


  ; px[0] = 2.8 & py[0] = -22.2
  ; px[1] = 4.1 & py[1] = -24.7
  ; px[2] = 4.2 & py[2] = -26.5
  ; px[3] = 4.3 & py[3] = -28.3
  ; px[4] = 3.9 & py[4] = -29.9

  ; ; legend, 'log M!Dhalo!N (h!U-1!NMpc) = '+mm[0], box=0, charsize = csiz2, pos=[px[0], py[0]]
  ; legend, 'log M!Dhalo!N='+mm[0], box=0, charsize = csiz2, pos=[px[0], py[0]]
  ; for i=1L, n_elements(mm)-1 do legend, mm[i], box=0, charsize = csiz2, pos=[px[i], py[i]]
  ; ; legend, 'log M!Dhalo!N='+mm[4], box=0, charsize = csiz2, pos=[px[4], py[4]]

  virial_plot = 'n'

  if virial_plot eq 'y' then begin 
     ;; Overplotting SDSS points from 
     ;; e.g. Shen et al., 2008, ApJ, 680, 169 
     ;; BIASES IN VIRIAL BLACK HOLE  MASSES: AN SDSS PERSPECTIVE
     
     ;; CIV BH esimates
     w_CIV_BH7    = where(data.BH_CIV gt 0.0 and data.BH_CIV le 7.99, N_BH7)
     w_CIV_BH8_lo = where(data.BH_CIV gt 8.0 and data.BH_CIV le 8.49, N_BH8_lo)
     w_CIV_BH8_hi = where(data.BH_CIV gt 8.5 and data.BH_CIV le 8.99, N_BH8_hi)
     w_CIV_BH9_lo = where(data.BH_CIV gt 9.0 and data.BH_CIV le 9.49, N_BH9_lo)
     w_CIV_BH9_hi = where(data.BH_CIV gt 9.5 and data.BH_CIV le 9.99, N_BH9_hi)
     w_CIV_BH10   = where(data.BH_CIV gt 10.0, N_BH10)
     
     ;; MGII BH esimates
     w_MGII_BH7    = where(data.BH_MGII gt 0.0 and data.BH_MGII le 7.99, N_BH7)
     w_MGII_BH8_lo = where(data.BH_MGII gt 8.0 and data.BH_MGII le 8.49, N_BH8_lo)
     w_MGII_BH8_hi = where(data.BH_MGII gt 8.5 and data.BH_MGII le 8.99, N_BH8_hi)
     w_MGII_BH9_lo = where(data.BH_MGII gt 9.0 and data.BH_MGII le 9.49, N_BH9_lo)
     w_MGII_BH9_hi = where(data.BH_MGII gt 9.5 and data.BH_MGII le 9.99, N_BH9_hi)
     w_MGII_BH10   = where(data.BH_MGII gt 10.0, N_BH10)
     
     
     ;; HBETA BH esimates
     w_HBETA_BH7    = where(data.BH_HBETA gt 0.0 and data.BH_HBETA le 7.99, N_BH7)
     w_HBETA_BH8_lo = where(data.BH_HBETA gt 8.0 and data.BH_HBETA le 8.49, N_BH8_lo)
     w_HBETA_BH8_hi = where(data.BH_HBETA gt 8.5 and data.BH_HBETA le 8.99, N_BH8_hi)
     w_HBETA_BH9_lo = where(data.BH_HBETA gt 9.0 and data.BH_HBETA le 9.49, N_BH9_lo)
     w_HBETA_BH9_hi = where(data.BH_HBETA gt 9.5 and data.BH_HBETA le 9.99, N_BH9_hi)
     w_HBETA_BH10   = where(data.BH_HBETA gt 10.0, N_BH10)
     
     
     plotsym, 0, 0.25, /fill
     ;oplot, data.z,   data.imag, psym=3
     
     loadct, 39
     ;oplot, data[w_CIV_BH7].z,   data[w_CIV_BH7].imag, psym=8   , color=48
     ;oplot, data[w_MGII_BH7].z,  data[w_MGII_BH7].imag, psym=8  , color=64
     ;oplot, data[w_HBETA_BH7].z, data[w_HBETA_BH7].imag, psym=8 , color=80
     
     oplot, data[w_CIV_BH7].z,    data[w_CIV_BH7].imag, psym=8   , color=32
     oplot, data[w_CIV_BH8_lo].z, data[w_CIV_BH8_lo].imag, psym=8   , color=64
     oplot, data[w_CIV_BH8_hi].z, data[w_CIV_BH8_hi].imag, psym=8   , color=96
     oplot, data[w_CIV_BH9_lo].z, data[w_CIV_BH9_lo].imag, psym=8   , color=128
     oplot, data[w_CIV_BH9_hi].z, data[w_CIV_BH9_hi].imag, psym=8   , color=220
     oplot, data[w_CIV_BH10].z,   data[w_CIV_BH10].imag, psym=8   , color=254
     
     oplot, data[w_MGII_BH7].z,    data[w_MGII_BH7].imag, psym=8   , color=32
     oplot, data[w_MGII_BH8_lo].z, data[w_MGII_BH8_lo].imag, psym=8   , color=64
     oplot, data[w_MGII_BH8_hi].z, data[w_MGII_BH8_hi].imag, psym=8   , color=96
     oplot, data[w_MGII_BH9_lo].z, data[w_MGII_BH9_lo].imag, psym=8   , color=128
     oplot, data[w_MGII_BH9_hi].z, data[w_MGII_BH9_hi].imag, psym=8   , color=220
     oplot, data[w_MGII_BH10].z,   data[w_MGII_BH10].imag, psym=8   , color=254
     
     oplot, data[w_HBETA_BH7].z,    data[w_HBETA_BH7].imag, psym=8   , color=32
     oplot, data[w_HBETA_BH8_lo].z, data[w_HBETA_BH8_lo].imag, psym=8   , color=64
     oplot, data[w_HBETA_BH8_hi].z, data[w_HBETA_BH8_hi].imag, psym=8   , color=96
     oplot, data[w_HBETA_BH9_lo].z, data[w_HBETA_BH9_lo].imag, psym=8   , color=128
     oplot, data[w_HBETA_BH9_hi].z, data[w_HBETA_BH9_hi].imag, psym=8   , color=220
     oplot, data[w_HBETA_BH10].z,   data[w_HBETA_BH10].imag, psym=8   , color=254
     
     ;y_dip = ['-24.0', '-23.5', '-23.0', '-22.5', '-22.0', '-21.5' ]
     y_dip = ['-21.0', '-20.5', '-20.0', '-19.5', '-19.0', '-18.5' ]
     
     xyouts, 2, y_dip[0], '      log(BH_mass) < 8.0', color=32
     xyouts, 2, y_dip[1], '8.0 < log(BH_mass) < 8.5', color=64
     xyouts, 2, y_dip[2], '8.5 < log(BH_mass) < 9.0', color=96
     xyouts, 2, y_dip[3], '9.0 < log(BH_mass) < 9.5', color=128
     xyouts, 2, y_dip[4], '9.5 < log(BH_mass) < 10.0', color=220
     xyouts, 2, y_dip[5], '      log(BH_mass) > 10.0', color=254
     
     ;oplot, data[w_MGII_BH8].z,  data[w_MGII_BH8].imag, psym=8 , color=128 ;
     ;oplot, data[w_HBETA_BH8].z, data[w_HBETA_BH8].imag, psym=8 , color=154
     
     ;oplot, data[w_CIV_BH9].z,   data[w_CIV_BH9].imag, psym=8   , color=224
     ;oplot, data[w_MGII_BH9].z,  data[w_MGII_BH9].imag, psym=8  , color=240
     ;oplot, data[w_HBETA_BH9].z, data[w_HBETA_BH9].imag, psym=8 , color=254
     
  endif

  axis, yrange = [ymin-0.71, ymax-0.71], $
        yaxis = 1, $
        ytitle = 'M!Di!N [z=2] - 5logh!D70!N', $
        ycharsize = 1.0, $
        charthick=4.4, $
        ystyle = 1, charsize = csiz, /save

  !p.multi = 0
  device, /close_file
  set_plot, 'X'
  loadct, 0


end







