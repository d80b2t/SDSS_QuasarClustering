pro plotEvolution

  numErr = 5;100

  location = 'fits_disp_gamma1.0_eta0.5'

  gam = 1.0
  eta = 0.5

  col0 = 0 & col1 = 60 & col2 = 150 & col3 = 60
  ls0 = 0 & ls1 = 5 & ls2 = 1
  ssiz = 2.0
  hat = 100
  tck = 4 & tck2 = 2
  csiz = 1.5 & csiz2 = 0.9

  !x.thick = 2
  !y.thick = 2
  !p.charthick = 2

  close, 1

  set_plot, 'PS'
  device, color = 1, $
;          filename = './figures/quasarEvolution_'+location+'.ps', $
          filename = 'Croton09_temp.ps', $
          xsize = 20, ysize = 12, $
          yoffset = 8.0,  xoffset = 0.0, /portrait


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
    ; Hz = H0 * sqrt(0.25*(1.0+rs[i])^3.0 + 0.75)

    vvir = (10.0*G*Hz*mvir)^(1.0/3.0)

    ; ;; Baes et al. 2003 Eq.3
    ; sigma = (alog10(gam*vvir/200.0) - 0.21) / 0.96
    ; ;; Tremaine et al. 2002
    ; mBH = 8.13 + 4.02*sigma

    mBH = 7.25 + 4.18 * alog10(gam*vvir/200.0)  ;in h=0.7 units
    Lbol = eta * 3.3e4*(10.0^mBH)  ;in h=0.7 units
    magQ = -2.66*(alog10(Lbol)+alog10(3.839e26)) + 79.42  ;in h=0.7 units

    ;; Hopkins et al. 2006 Eq.2
    ; LB = Lbol / ( 6.25*(Lbol/1e10)^(-0.37) + 9.00*(Lbol/1e10)^(-0.012) )
    ; magB = -2.5*alog10(LB) + 5.41
    ; magQ = magB - 0.07


    ;;  Croom et al. 2004 QLF
    PhiStar = 1.7e-6
    alpL = -3.3 & betL = -1.1
    Mstar0 = -21.6
    k1 = 1.4 & k2 = -0.3

    if rs[i] gt 3.0 then begin
      alpL = alpL + 0.5*(rs[i]-3.0)
      k1 = 1.22 & k2 = -0.23
    endif

    Mstar = Mstar0 - 2.5*(k1*rs[i] + k2*rs[i]*rs[i])

    Phi[i, *] = PhiStar / ( (10.0^(0.4*(alpL+1)*(magQ-Mstar))) + (10.0^(0.4*(betL+1)*(magQ-Mstar))) )

    mag[i, *] = magQ
    mass[i, *] = mvir


  endfor


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


  ymin = -20.0 & ymax = -30.0
  xmin = 11.7 & xmax = 14.3


  range = [1.0e-4, 1.0e-9]
  c_level = reverse(loglevels(range))

  contour, phi, rs, mag, /follow, xrange = [0, 6.0], yrange = [ymin, ymax], xstyle = 1, ystyle = 9, $
    levels = c_level, c_linestyle = ls1, charsize = csiz, c_color = col3, $
    ytitle = 'M!DbJ!N - 5logh!D70!N', xtitle = 'redshift';, c_colors = col1


  mm = ['12.0', '12.5', '13.0', '13.5', '14.0']
  mm2 = ['7.0', '8.0', '9.0', '10.0', '10.0']
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

    loadct, 39
    oplot, rs, magQ, linestyle = ls0, color = col1, thick = tck
    
    ; Lbol = eta * 10.0^( -1.99 + 1.39*alog10((gam^3.0)*Hz*((10.0^mm[j])/(1.0e13))) ) * 1.0e12
    ; magQ = -2.66*(alog10(Lbol)+alog10(3.839e26)) + 79.42  ;in h=0.7 units
    ; oplot, rs, magQ, linestyle = 1, color = col1, thick = tck


    loadct, 0
    mBH = 1.0*mm2[j]*Hz/Hz
    Lbol = eta * 3.3e4*(10.0^mBH)
    magQ = -2.66*(alog10(Lbol)+alog10(3.839e26)) + 79.42
    oplot, rs, magQ, color = col2, thick = tck2, linestyle = ls2

  endfor


  ; legend, 'log M!Dhalo!N='+mm[0], box=0, charsize = csiz2, pos=[1.25, -22.2]
  legend, 'log M!Dhalo!N='+mm[0], box=0, charsize = csiz2, pos=[0.65, -22.9]
  ; legend, 'log M!Dhalo!N='+mm[4], box=0, charsize = csiz2, pos=[1.7, -30.0]
  legend, 'log M!Dhalo!N='+mm[4], box=0, charsize = csiz2, pos=[0.3, -30.0]

  legend, 'log M!DBH!N='+mm2[0], box=0, charsize = csiz2, pos=[4.85, -21.5], /clear
  legend, 'log M!DBH!N='+mm2[3], box=0, charsize = csiz2, pos=[4.76, -29.5], /clear


  ; px[0] = 2.8 & py[0] = -22.2
  ; px[1] = 4.1 & py[1] = -24.7
  ; px[2] = 4.2 & py[2] = -26.5
  ; px[3] = 4.3 & py[3] = -28.3
  ; px[4] = 3.9 & py[4] = -29.9

  ; ; legend, 'log M!Dhalo!N (h!U-1!NMpc) = '+mm[0], box=0, charsize = csiz2, pos=[px[0], py[0]]
  ; legend, 'log M!Dhalo!N='+mm[0], box=0, charsize = csiz2, pos=[px[0], py[0]]
  ; for i=1L, n_elements(mm)-1 do legend, mm[i], box=0, charsize = csiz2, pos=[px[i], py[i]]
  ; ; legend, 'log M!Dhalo!N='+mm[4], box=0, charsize = csiz2, pos=[px[4], py[4]]



  axis, yrange = [ymin-0.71, ymax-0.71], yaxis = 1, ytitle = 'M!Di!N [z=2] - 5logh!D70!N', ystyle = 1, charsize = csiz, /save






  !p.multi = 0
  device, /close_file
  set_plot, 'X'
  loadct, 0


end







