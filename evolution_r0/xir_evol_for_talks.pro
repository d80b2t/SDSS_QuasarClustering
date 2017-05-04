;+
; NAME:
;       xir_evol_pro
;
; PURPOSE:
;       To plot the evolution of r0/r0/bias over >85% of the lifetime
;       of the Universe (oh I say that so flippantly!!) 
;
; PROCEDURES CALLED:
;       Need to call the ``red'' routines downloadable from 
;       http://cerebus.as.arizona.edu/~ioannis/research/red/
;
;-


print
print
print, '----------------------------------------------------------'
print, '----------------------------------------------------------'
print, '--  !!!!! You have to run the "red" routine before this !!'
print, '--  PSU_IDL> red         '
print, '    red, omega0=0.237, omegalambda=0.763, h100=0.73   '
print, '----------------------------------------------------------'
print, '----------------------------------------------------------'


print
;readcol, 'r0_values_for_plotting.dat', $
readcol, 'r0_values_from_other_surveys.dat', $
         r0_surveys, r0_plus_surveys, r0_minus_surveys, $
         gamma_surveys, gamma_plus_surveys, gamma_minus_surveys, $
         z_surveys, z_min_surveys, z_max_surveys, surveys_type, /silent
t_lookback_surveys = getage(z_surveys)
print, 'READ-IN r0_values_for_plotting.dat'
print


readcol, 'Shen07_r0_values.dat', $
         z_lo_Shen07, z_bar_Shen07, z_hi_Shen07, $
         r0_Shen07, err_r0_Shen07, gamma_Shen07, gamma_err_Shen07
t_lookback_Shen07    = getage(z_bar_Shen07)
t_lookback_Shen07_lo = abs(getage(z_bar_Shen07) - getage(z_lo_Shen07))
t_lookback_Shen07_hi = abs(getage(z_bar_Shen07) - getage(z_hi_Shen07))
r0_plus_Shen07  = err_r0_Shen07
r0_minus_Shen07 = err_r0_Shen07
print, 'READ-IN Shen07.dat'
print


readcol, 'Myers06_r0_Table1.dat', $
         z_lo_Myers06, z_bar_Myers06, z_hi_Myers06, $
         r0_Myers06, err_r0_Myers06
t_lookback_Myers06    = getage(z_bar_Myers06)
t_lookback_Myers06_lo = abs(getage(z_bar_Myers06) - getage(z_lo_Myers06))
t_lookback_Myers06_hi = abs(getage(z_bar_Myers06) - getage(z_hi_Myers06))
r0_plus_Myers06  = err_r0_Myers06
r0_minus_Myers06 = err_r0_Myers06
print, 'READ-IN Myers06_r0_Table1.dat'
print

readcol, 'Coil07_DEEP2_r0.dat', $
         z_lo_Coil07, z_bar_Coil07, z_hi_Coil07, $
         r0_Coil07, r0_plus_Coil07, r0_minus_Coil07
t_lookback_Coil07    = getage(z_bar_Coil07)
t_lookback_Coil07_lo = abs(getage(z_bar_Coil07) -  getage(z_hi_Coil07))
t_lookback_Coil07_hi = abs(getage(z_bar_Coil07) -  getage(z_lo_Coil07))
print, 'READ-IN Coil07_DEEP2_r0.dat'
print


readcol, 'Adelberger05_r0.dat', $
         z_lo_Adelberger05, z_bar_Adelberger05, z_hi_Adelberger05, $
         r0_Adelberger05, r0_plus_Adelberger05, r0_minus_Adelberger05
t_lookback_Adelberger05    = getage(z_bar_Adelberger05)
t_lookback_Adelberger05_lo = abs(getage(z_bar_Adelberger05) -  getage(z_hi_Adelberger05))
t_lookback_Adelberger05_hi = abs(getage(z_bar_Adelberger05) -  getage(z_lo_Adelberger05))
print, 'READ-IN Adelberger05_r0.dat'
print



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    AGN data    (reading-in...)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
readcol, 'Gilli05.dat', $
         z_lo_Gilli05, z_bar_Gilli05, z_hi_Gilli05, $
         r0_Gilli05,  r0_plus_Gilli05, r0_minus_Gilli05
t_lookback_Gilli05    = getage(z_bar_Gilli05)
t_lookback_Gilli05_lo = abs(getage(z_bar_Gilli05) - getage(z_lo_Gilli05))
t_lookback_Gilli05_hi = abs(getage(z_bar_Gilli05) - getage(z_hi_Gilli05))
print, 'READ-IN Gilli05.dat'
print

readcol, 'Gilli08.dat', $
         z_lo_Gilli08, z_bar_Gilli08, z_hi_Gilli08, $
         r0_Gilli08, r0_plus_Gilli08, r0_minus_Gilli08
t_lookback_Gilli08    = getage(z_bar_Gilli08)
t_lookback_Gilli08_lo = abs(getage(z_bar_Gilli08) - getage(z_lo_Gilli08))
t_lookback_Gilli08_hi = abs(getage(z_bar_Gilli08) - getage(z_hi_Gilli08))
print, 'READ-IN Gilli08.dat'
print

readcol, 'Miyaji07.dat', $
         z_lo_Miyaji07, z_bar_Miyaji07, z_hi_Miyaji07, $
         r0_Miyaji07,  r0_plus_Miyaji07, r0_minus_Miyaji07
t_lookback_Miyaji07    = getage(z_bar_Miyaji07)
t_lookback_Miyaji07_lo = abs(getage(z_bar_Miyaji07) - getage(z_lo_Miyaji07))
t_lookback_Miyaji07_hi = abs(getage(z_bar_Miyaji07) - getage(z_hi_Miyaji07))
print, 'READ-IN Miyaji07.dat'
print

readcol, 'Yang06_r0_full.dat', $
         z_lo_Yang06, z_bar_Yang06, z_hi_Yang06, $
         r0_Yang06, r0_plus_Yang06, r0_minus_Yang06
t_lookback_Yang06    = getage(z_bar_Yang06)
t_lookback_Yang06_lo = abs(getage(z_bar_Yang06) - getage(z_lo_Yang06))
t_lookback_Yang06_hi = abs(getage(z_bar_Yang06) - getage(z_hi_Yang06))
print, 'READ-IN Yang06.dat'
print

readcol, 'Basilakos04_r0.dat', $
         z_lo_Basilakos04, z_bar_Basilakos04, z_hi_Basilakos04, $
         r0_Basilakos04, r0_plus_Basilakos04, r0_minus_Basilakos04
t_lookback_Basilakos04    = getage(z_bar_Basilakos04)
t_lookback_Basilakos04_lo = abs(getage(z_bar_Basilakos04) - getage(z_lo_Basilakos04))
t_lookback_Basilakos04_hi = abs(getage(z_bar_Basilakos04) - getage(z_hi_Basilakos04))
print, 'READ-IN Basilakos04_r0.dat'
print


print
readcol, 'Ross08_xir_UNIFORM_evol_gamma2pnt0_sigmamin1.dat', $
         lo_z, z_bar, hi_z, r0, r0_plus, r0_minus, $
         gamma, gamma_plus, gamma_minus
t_lookback    = getage(z_bar)
t_lookback_lo = abs(getage(z_bar) -  getage(hi_z))
t_lookback_hi = abs(getage(z_bar) -  getage(lo_z))
print, 'READ-IN Ross08_xir_UNIFORM_evol.dat'
print

print
readcol, 'Ross08_xir_UNIFORM_evol_RASS.dat', $
         lo_z_RASS, z_bar_RASS, hi_z_RASS, $
         r0_RASS, r0_plus_RASS, r0_minus_RASS
t_lookback_RASS    = getage(z_bar_RASS)
t_lookback_lo_RASS = abs(getage(z_bar_RASS) -  getage(hi_z_RASS))
t_lookback_hi_RASS = abs(getage(z_bar_RASS) -  getage(lo_z_RASS))
print, 'READ-IN Ross08_xir_UNIFORM_evol_RASS.dat'
print


zz=[0.0, 0.5, 1.0, 2.0, 3.0, 5.0, 10.0]
;zz=[10,5,3,2,1,0.5,0]
tt=getage(zz)

qso_redshift = [0.526,0.804,1.026,1.225,1.413,1.579, 1.745, 1.921, 2.131,2.475]
qso_lookback_time = getage(qso_redshift)
r_nought = qso_redshift * 6.0



choice_Quasar_points = 'y'
read, choice_Quasar_points, PROMPT=' - Plot Quasar points?? y/n  '
choice_AGN_points = 'y'
read, choice_AGN_points, PROMPT=' - Plot AGN points?? y/n  '


z_err_lo = abs(z_bar - lo_z) 
z_err_hi = abs(z_bar - hi_z) 
z_err_lo_RASS = abs(z_bar_RASS - lo_z_RASS) 
z_err_hi_RASS = abs(z_bar_RASS - hi_z_RASS) 
z_err_lo_Shen07 = abs(z_bar_Shen07 -  z_lo_Shen07)
z_err_hi_Shen07 = abs(z_bar_Shen07 -  z_hi_Shen07)
z_err_lo_Coil07 = abs(z_bar_Coil07 -  z_lo_Coil07)
z_err_hi_Coil07 = abs(z_bar_Coil07 -  z_hi_Coil07)
z_err_lo_Adelberger05 = abs(z_bar_Adelberger05 -  z_lo_Adelberger05)
z_err_hi_Adelberger05 = abs(z_bar_Adelberger05 -  z_hi_Adelberger05)
z_err_lo_Myers06 = abs(z_bar_Myers06 -  z_lo_Myers06)
z_err_hi_Myers06 = abs(z_bar_Myers06 -  z_hi_Myers06)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Redshift along the bottom, age of Uni along the top
;;
;; UPTO  REDSHIFT  3  (THREE) 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (1) Create a plot of y versus x with the top axis missing. In my case, I had:
;;     The line with xstyle=8+1 tells it to not plot the top xaxis.



set_plot, 'ps'
device, filename='r0_with_redshift_z3_for_talks_temp.ps', $
        xsize=8.5, ysize=6.0,  /inches, /color, $
        xoffset=0.0, yoffset=0.2

!p.multi=0
loadct, 0
p=  [-0.2, -0.2, 1.3, 1.3]
pp =  [0.14, 0.14, 0.98, 0.98]
PolyFill, [p[0],p[0],p[2],p[2],p[0]],  [p[1],p[3],p[3],p[1],p[1]],  $
          COLOR=0, /NORMAL

plot, z_bar, r0, $
      position=pp, $
      /noerase, $
      xrange=[0,2.92], yrange=[0.0,25], $ 
      psym=3, $
      xstyle=8+1, ystyle=3, $
      thick=8, xthick=4, ythick=8, $
      charsize=2.2, charthick=6, $
      xtitle='!8z, redshift', $
      ytitle='!8r!I0!n / !8h!E-1!n!8 Mpc', $
      /nodata, $
      color=255


r0_full = findgen(4)
for i=0L, n_elements(r0_full)-1 do r0_full(i) =8.00
oplot, (findgen(4)), r0_full, linestyle=1, thick=4, color=192




loadct, 0
plotsym,0,2
oplot, z_bar, r0, psym=8, color=255, thick=1;, symsize=4
oploterror, z_bar, r0, z_err_lo, r0_minus, $
            /lobar, errthick=1, errcolor=255, psym=1, color=255
oploterror, z_bar, r0, z_err_hi, r0_plus, $
            /hibar, errthick=1, errcolor=255, psym=1, color=255

w = where(z_bar lt 2.2)
plotsym,0,2,/fill
oplot, z_bar[w], r0[w], psym=8, color=255, thick=4;, symsize=4
oploterror, z_bar[w], r0[w], z_err_lo[w], r0_minus[w], $
            /lobar, errthick=4, errcolor=255, psym=1, color=255
oploterror, z_bar[w], r0[w], z_err_hi[w], r0_plus[w], $
            /hibar, errthick=4, errcolor=255, psym=1, color=255


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    AGN data,   REDSHIFT  3  (THREE) 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; AGN measurements from CDF N+S (Gilli05) and COSMOS (Miyaji07, Gilli08)
;; z_lo_AGN, z_bar_AGN, z_hi_AGN,      r0_AGN, r0_plus_AGN, r0_minus_AGN
;; oplot, z_bar_AGN, r0_AGN, psym=1, color=128, thick=4;, symsize=4
;; oploterror, z_bar_AGN, r0_AGN, z_lo_AGN, r0_minus_AGN, $
;;            /lobar, errthick=4, errcolor=128, psym=1, color=128
;; oploterror, z_bar_AGN, r0_AGN, z_hi_AGN, r0_plus_AGN, $
;;            /hibar, errthick=4, errcolor=128, psym=1, color=128

if (choice_AGN_points eq 'y') then begin
   loadct, 6
   plotsym,3,2.2,/fill
   oplot, z_bar_Gilli05, r0_Gilli05, psym=8, color=128, thick=4 ;, symsize=4
   oploterror, z_bar_Gilli05, r0_Gilli05, z_lo_Gilli05, r0_minus_Gilli05, $
               /lobar, errthick=4, errcolor=128, psym=1, color=128
   oploterror, z_bar_Gilli05, r0_Gilli05, z_hi_Gilli05, r0_plus_Gilli05, $
               /hibar, errthick=4, errcolor=128, psym=1, color=128
   
   plotsym,4,2.5, thick=4
   oplot, z_bar_Gilli08, r0_Gilli08, psym=8, color=128, thick=4 ;, symsize=4
   oploterror, z_bar_Gilli08, r0_Gilli08, z_lo_Gilli08, r0_minus_Gilli08, $
               /lobar, errthick=4, errcolor=128, psym=1, color=128
   oploterror, z_bar_Gilli08, r0_Gilli08, z_hi_Gilli08, r0_plus_Gilli08, $
               /hibar, errthick=4, errcolor=128, psym=1, color=128
   
   plotsym,4,2.4,/fill, thick=4
   oplot, z_bar_Miyaji07, r0_Miyaji07, psym=8, color=128, thick=4 ;, symsize=4
   oploterror, z_bar_Miyaji07, r0_Miyaji07, z_lo_Miyaji07, r0_minus_Miyaji07, $
              /lobar, errthick=4, errcolor=128, psym=1, color=128
  oploterror, z_bar_Miyaji07, r0_Miyaji07, z_hi_Miyaji07, r0_plus_Miyaji07, $
               /hibar, errthick=4, errcolor=128, psym=1, color=128
   

   A = FINDGEN(6) * (!PI*2/5.)
   X = COS(A)/1.75
   Y = SIN(A)/1.75
   USERSYM, Y, X, /fill
   oplot, z_bar_Basilakos04, r0_Basilakos04, $
          psym=8, color=24, symsize=4
   oploterror, z_bar_Basilakos04, r0_Basilakos04, $
               z_lo_Basilakos04, r0_minus_Basilakos04, $
               /lobar, errthick=4, errcolor=24, psym=4, color=24
   oploterror, z_bar_Basilakos04, r0_Basilakos04, $
               z_hi_Basilakos04, r0_plus_Basilakos04, $
               /hibar, errthick=4, errcolor=24, psym=4, color=24

    plotsym,4,2.5, thick=4
   oplot, z_bar_Gilli08, r0_Gilli08, psym=8, color=128, thick=4 ;, symsize=4
   oploterror, z_bar_Gilli08, r0_Gilli08, z_lo_Gilli08, r0_minus_Gilli08, $
               /lobar, errthick=4, errcolor=128, psym=1, color=128
   oploterror, z_bar_Gilli08, r0_Gilli08, z_hi_Gilli08, r0_plus_Gilli08, $
               /hibar, errthick=4, errcolor=128, psym=1, color=128

endif







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    Quasar data,  REDSHIFT  3  (THREE) 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if (choice_Quasar_points eq 'y') then begin
   X = [-4, 0, 4, 0, -4] 
   Y = [0, 4, 0, -4, 0] 
   USERSYM, X, Y
   oplot, z_bar_Shen07, r0_Shen07, psym=8, color=128, thick=4 ;, symsize=4
   oploterror, z_bar_Shen07, r0_Shen07, z_err_lo_Shen07, r0_minus_Shen07, $
               /lobar, errthick=4, errcolor=128, psym=1, color=128
   oploterror, z_bar_Shen07, r0_Shen07, z_err_hi_Shen07, r0_plus_Shen07, $
               /hibar, errthick=4, errcolor=128, psym=1, color=128
   
   plotsym,8,2, thick=4, /fill
   oplot, z_bar_Myers06, r0_Myers06, psym=8, color=64 ;, symsize=4
   oploterror, z_bar_Myers06, r0_Myers06, z_err_lo_Myers06, r0_minus_Myers06, $
               /lobar, errthick=4, errcolor=64, psym=1, color=64
   oploterror, z_bar_Myers06, r0_Myers06, z_err_hi_Myers06, r0_plus_Myers06, $
               /hibar, errthick=4, errcolor=64, psym=1, color=64  

   loadct, 13
   oplot, z_bar_Coil07, r0_Coil07, psym=4, color=24, symsize=2, thick=5
   oploterror, z_bar_Coil07, r0_Coil07, z_err_lo_Coil07, r0_minus_Coil07, $
               /lobar, errthick=4, errcolor=24, psym=1, color=24
   oploterror, z_bar_Coil07, r0_Coil07, z_err_hi_Coil07, r0_plus_Coil07, $
               /hibar, errthick=4, errcolor=24, psym=1, color=24  
   loadct, 6

   loadct, 13
   oplot, z_bar_Adelberger05, r0_Adelberger05, $
          psym=4, color=80, symsize=1, thick=15
   oploterror, z_bar_Adelberger05, r0_Adelberger05, $
               z_err_lo_Adelberger05, r0_minus_Adelberger05, $
               /lobar, errthick=4, errcolor=80, psym=1, color=80
   oploterror, z_bar_Adelberger05, r0_Adelberger05, $
               z_err_hi_Adelberger05, r0_plus_Adelberger05, $
               /hibar, errthick=4, errcolor=80, psym=1, color=80  
   loadct, 6

   
  
endif

loadct, 0
plotsym,0,2
oplot, z_bar, r0, psym=8, color=255, thick=1;, symsize=4
oploterror, z_bar, r0, z_err_lo, r0_minus, $
            /lobar, errthick=1, errcolor=255, psym=1, color=255
oploterror, z_bar, r0, z_err_hi, r0_plus, $
            /hibar, errthick=1, errcolor=255, psym=1, color=255
w = where(z_bar lt 2.2)
plotsym,0,2,/fill
oplot, z_bar[w], r0[w], psym=8, color=255, thick=4;, symsize=4
oploterror, z_bar[w], r0[w], z_err_lo[w], r0_minus[w], $
            /lobar, errthick=4, errcolor=255, psym=1, color=255
oploterror, z_bar[w], r0[w], z_err_hi[w], r0_plus[w], $
            /hibar, errthick=4, errcolor=255, psym=1, color=255




zz=[0.0, 0.5, 1.0, 2.0, 3.0, 5.0, 10.0]
zlab=['0','0.5','1','2','3','5','10']
tlab=['13.8', '8.8 ', '6.1', '3.5', '2.3', '1.3', '0.5']

nticks=n_elements(zz)

loadct, 0
axis, xaxis=1, xtickv=zz, xtickn=tlab, $
      xticks=nticks-1, $
      xthick=6, charthick=6, $
      xtitle='!8 Age of the Universe (Gyr)',charsize=2, $
      color=255


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    Quasar Labels
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if (choice_Quasar_points eq 'y') then begin

;if (choice_DR5Q eq 'y'
   loadct, 0
   plotsym,0,1.0,/fill, thick=4
 
   xyouts, 0.3, 23.0, '!3SDSS DR5Q (uni)', color=255, charthick=6, charsize=1.8
   legend, [''], psym=8, color=255, pos=[0.1,24.5], box=0, $
           charthick=4.2, charsize=1.8, thick=4.2


;if (choice_SDSS_photoz eq 'y') then begin
   loadct, 6
   plotsym,8,1.0, thick=4, /fill
   xyouts, 0.3, 21.5, 'SDSS photo-z', color=64, charthick=6, charsize=1.8
   legend, [''], psym=8, color=64, pos=[0.1,23.0], box=0, $     
           charthick=4.2, charsize=1.8, thick=4.2
;endif


   loadct, 13
   xyouts, 0.3, 20.0, 'SDSS-DEEP2', color=24, charthick=6, charsize=1.8
   legend, [''], psym=4, color=24, pos=[0.1,21.5], box=0, $
           charthick=4.2, charsize=1.8, thick=5.2

   xyouts, 0.3, 18.5, 'AGN-LBGs', color=80, charthick=6, charsize=1.8
   tri_one = [0.185, 0.22, 0.255, 0.22]
   tri_two = [18.75,   19.25,  18.75,  18.25]
   polyfill, tri_one, tri_two, color=80
;   X = [30, 100, 100, 30] & Y = [30, 30, 100, 100]  
;   polyfill, X, Y, thick=8, color=48
;   legend, [' '], psym=4, color=48, pos=[0.1,18.5], box=0, $
;           charthick=4.2, charsize=1.8, thick=7.2
   loadct, 6
endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    AGN Labels
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if (choice_AGN_points eq 'y') then begin

   loadct, 6
   xyouts, 1.5, 23.0, 'XMM-2dF (Basilakos04)!8', color=24, charthick=6, charsize=1.8
   A = FINDGEN(6) * (!PI*2/5.)
   X = COS(A) ;/1.75
   Y = SIN(A) ;/1.75
   USERSYM, Y, X, /fill
   legend, [''], psym=8, color=24, pos=[1.3,24.5], box=0, $
           charthick=4.2, charsize=1.8   

   loadct, 6
   xyouts, 1.5, 21.5, '!3CDF-N&S (Gilli05)', color=128, charthick=6, charsize=1.8
   plotsym,3,1.0,/fill, thick=4
   legend, [''], psym=8, color=128, pos=[1.3,23.0], box=0, $
           charthick=4.2, charsize=1.8
   loadct, 0
   xyouts, 0.82, 10.0, 'S', color=0, size=1, charthick=4
   xyouts, 0.94,  5.25, 'N', color=0, size=1, charthick=4

   loadct, 6
   xyouts, 1.5, 20.0, '!3XMM-COSMOS (Miyaji07)', color=128, charthick=6, charsize=1.8
   plotsym,4,1.0, /fill, thick=4
   legend, [''], psym=8, color=128, pos=[1.3,21.5], box=0, $
           charthick=4.2, charsize=1.8
   loadct, 0
   xyouts, 0.58,  12.3, 'U', color=0, size=1, charthick=4
   xyouts, 0.845,  6.45,  'M', color=0, size=1, charthick=4
   xyouts, 1.055,  11.45, 'S', color=0, size=1, charthick=4

   loadct, 6   
   xyouts, 1.5, 18.5, '!3XMM-COSMOS (Gilli08)', color=128, charthick=6, charsize=1.8
   plotsym,4,1.0, thick=4
   legend, [''], psym=8, color=128, pos=[1.3,20.0], box=0, $  
           charthick=4.2, charsize=1.8
  
endif

device, /close
set_plot, 'X'


;PSYM Value 
;Plotting Symbol 
;1
;Plus sign (+) 
;2
;Asterisk (*) 
;3
;Period (.) 
;4
;Diamond 
;5
;Triangle 
;6
;Square 
;7
;X 
;8
;User-defined. See USERSYM procedure. 
;9
;Undefined 
;10
;Histogram mode. Horizontal and vertical lines connect the plotted points, as opposed to the normal method of connecting points with straight lines. See Histogram Mode for an example. 



; plotsym:
; x   PSYM -  The following integer values of PSYM will create the
;             corresponding plot symbols
;     0 - circle
;     1 - downward arrow (upper limit), base of arrow begins at plot value             value
;     2 - upward arrow (lower limt)
;     3 - 5 pointed star
;     4 - triangle
;     5 - upside down triangle
;     6 - left pointing arrow
;     7 - right pointing arrow
;     8 - square






end

