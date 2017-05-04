;+
; NAME:
;       xir_evol_pro
;
; PURPOSE:
;       To plot the evolution of r0/r0/bias over >85% of the lifetime
;       of the Universe (oh I say that so flippantly!!) 
;
; EXPLANATION:
;
; CALLING SEQUENCE:
;       .run xi_plot
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
;       Need to call the ``red'' routines downloadable from 
;       http://cerebus.as.arizona.edu/~ioannis/research/red/
;
; EXAMPLES:
;
; COMMENTS:
;
; NOTES:
;
; MODIFICATION HISTORY:
;       Version 1.00  NPR    20th November 2007
;-


;read, choice, PROMPT='  A) SDSS z<3 Quasars '
;read, choice, PROMPT='  B) SDSS z>3 Quasars '
;read, choice, PROMPT='  C) Croom05 2QZ      '
; daAngela08, Ross07, Zehavi02,05a,05b...
; 
 
print
print
print, '------------------------------------------------------'
print, '!!!!! You have to run the "red" routine before this !!'
print, 'PSU_IDL> red         '
print, '  red, omega0=0.237, omegalambda=0.763, h100=0.73   '
print, '------------------------------------------------------'


print
;readcol, 'r0_values_for_plotting.dat', $
readcol, 'r0_values_from_other_surveys.dat', $
         r0_surveys, r0_plus_surveys, r0_minus_surveys, $
         gamma_surveys, gamma_plus_surveys, gamma_minus_surveys, $
         z_surveys, z_min_surveys, z_max_surveys, surveys_type
t_lookback_surveys = getage(z_surveys)
;print, 'READ-IN r0_values_for_plotting.dat'


print
readcol, 'Shen07_r0_values.dat', $
         z_lo_Shen07, z_bar_Shen07, z_hi_Shen07, $
         r0_Shen07, err_r0_Shen07, gamma_Shen07, gamma_err_Shen07
t_lookback_Shen07    = getage(z_bar_Shen07)
t_lookback_Shen07_lo = abs(getage(z_bar_Shen07) - getage(z_lo_Shen07))
t_lookback_Shen07_hi = abs(getage(z_bar_Shen07) - getage(z_hi_Shen07))
print, 'READ-IN Shen07.dat'


print
readcol, 'Myers06_r0_Table1.dat', $
         z_lo_Myers06, z_bar_Myers06, z_hi_Myers06, $
         r0_Myers06, err_r0_Myers06
t_lookback_Myers06    = getage(z_bar_Myers06)
t_lookback_Myers06_lo = abs(getage(z_bar_Myers06) - getage(z_lo_Myers06))
t_lookback_Myers06_hi = abs(getage(z_bar_Myers06) - getage(z_hi_Myers06))
print, 'READ-IN Myers06_r0_Table1.dat'


;; N.B. Croom et al. (2005)  s0  only !!!!
print
readcol, '../2QZ/Croom05_Table2.dat', $
         lo_z_2QZ, z_bar_2QZ, hi_z_2QZ, $
         r0_2QZ, r0_plus_2QZ, r0_minus_2QZ
t_lookback_2QZ    = getage(z_bar_2QZ)
t_lookback_2QZ_lo = abs(getage(z_bar_2QZ) -  getage(hi_z_2QZ))
t_lookback_2QZ_hi = abs(getage(z_bar_2QZ) -  getage(lo_z_2QZ))
print, 'READ-IN Croom05_Table2.dat'

print
readcol, 'Gilli05_08_AGN.dat', $
         z_lo_Gilli05, z_bar_Gilli05, z_hi_Gilli05, $
         r0_Gilli05, err_r0_Gilli05
t_lookback_Gilli05    = getage(z_bar_Gilli05)
t_lookback_Gilli05_lo = abs(getage(z_bar_Gilli05) - getage(z_lo_Gilli05))
t_lookback_Gilli05_hi = abs(getage(z_bar_Gilli05) - getage(z_hi_Gilli05))
print, 'READ-IN Gilli05.dat'

print
readcol, 'AGN_r0_evolution.dat', $
         z_lo_AGN, z_bar_AGN, z_hi_AGN, $
         r0_AGN, r0_plus_AGN, r0_minus_AGN
t_lookback_AGN    = getage(z_bar_AGN)
t_lookback_AGN_lo = abs(getage(z_bar_AGN) - getage(z_lo_AGN))
t_lookback_AGN_hi = abs(getage(z_bar_AGN) - getage(z_hi_AGN))
print, 'READ-IN AGN.dat'



print
readcol, 'Ross08_xir_UNIFORM_evol.dat', $
         lo_z, z_bar, hi_z, r0, r0_plus, r0_minus, $
         gamma, gamma_plus, gamma_minus, s_hi_fit
t_lookback    = getage(z_bar)
t_lookback_lo = abs(getage(z_bar) -  getage(hi_z))
t_lookback_hi = abs(getage(z_bar) -  getage(lo_z))
print, 'READ-IN Ross08_xir_UNIFORM_evol.dat'






zz=[0.0, 0.5, 1.0, 2.0, 3.0, 5.0, 10.0]
;zz=[10,5,3,2,1,0.5,0]
tt=getage(zz)

qso_redshift = [0.526,0.804,1.026,1.225,1.413,1.579, 1.745, 1.921, 2.131,2.475]
qso_lookback_time = getage(qso_redshift)
r_nought = qso_redshift * 6.0




; (1) Create a plot of y versus x with the top axis missing. In my case, I had:
;     The line with xstyle=8+1 tells it to not plot the top xaxis.

loadct, 6
;loadct, 13
set_plot, 'ps'
;device, filename='r0_with_lookback_time.ps', xsize=12, ysize=8, /inches, /color
device, filename='r0_with_lookback_time.ps', xsize=8, ysize=6,  /inches, /color
;plot, abs(y(o).tau-tau0), y(o).log_ratio, $
;plot, qso_redshift, r_nought, $
plot, tt, r_nought, $
;plot, zz, r_nought, $
      psym=1, $
      /nodata,$
      xrange=[13.8,0], yrange=[0,30], $
      xstyle=8+1,ystyle=1,$
      xtitle='!8 Age of the Universe (Gyr)', $
;      ytitle='log !8L!d!6X!n/!8L!dB!n!6', $
;      ytitle='!8r!d!60!n/ !8h!E-1!n!8 MpC', $
      ytitle='!8r!I0!n / !8h!E-1!n!8 MpC', $
      charsize=2, $
      position=[0.15,0.15,0.95,0.85], $
      color=0

oplot, t_lookback_Shen07, r0_Shen07, psym=1, color=192, thick=4;, symsize=4
oploterror, t_lookback_Shen07, r0_Shen07,t_lookback_Shen07_hi, err_r0_Shen07, $
            /lobar, errthick=4, errcolor=192, psym=1, color=192 
oploterror, t_lookback_Shen07, r0_Shen07,t_lookback_Shen07_lo, err_r0_Shen07, $
            /hibar, errthick=4, errcolor=192, psym=1, color=192  


oplot, t_lookback_Myers06, r0_Myers06, psym=1, color=64, thick=4;, symsize=4
oploterror, t_lookback_Myers06, r0_Myers06, t_lookback_Myers06_hi, $
            err_r0_Myers06, /lobar, errthick=4, errcolor=64, psym=1, color=64
oploterror, t_lookback_Myers06, r0_Myers06, t_lookback_Myers06_lo,  $
            err_r0_Myers06, /hibar, errthick=4, errcolor=64, psym=1, color=64


oplot, t_lookback_2QZ, r0_2QZ, psym=1, color=128, thick=4;, symsize=4
oploterror, t_lookback_2QZ, r0_2QZ, t_lookback_2QZ_lo, r0_minus_2QZ, $
            /lobar, errthick=4, errcolor=128, psym=1, color=128
oploterror, t_lookback_2QZ, r0_2QZ, t_lookback_2QZ_hi, r0_plus_2QZ, $
            /hibar, errthick=4, errcolor=128, psym=1, color=128 

plotsym,3,2,/fill ; filled or open STAR!!
oplot, t_lookback_Gilli05, r0_Gilli05, psym=8, color=192, thick=4;, symsize=4
oploterror, t_lookback_Gilli05, r0_Gilli05,t_lookback_Gilli05_hi, err_r0_Gilli05, $
            /lobar, errthick=4, errcolor=192, psym=1, color=192 
oploterror, t_lookback_Gilli05, r0_Gilli05,t_lookback_Gilli05_lo, err_r0_Gilli05, $
            /hibar, errthick=4, errcolor=192, psym=1, color=192  

clr = fix((surveys_type MOD 8) * 32.)
plots, t_lookback_surveys, r0, psym=4, color=clr


plotsym,0,2,/fill
;plotsym, t_lookback, r0 ;, psym=0, /FILL, color=0
oplot, t_lookback, r0, psym=8, color=0, thick=4;, symsize=4
oploterror, t_lookback, r0, t_lookback_lo, r0_minus, $
            /lobar, errthick=4, errcolor=0, psym=1, color=0
oploterror, t_lookback, r0, t_lookback_hi, r0_plus, $
            /hibar, errthick=4, errcolor=0, psym=1, color=0


xyouts, 13.0, 27, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0


zlab=['0','0.5','1','2','3','5','10']
;ttlab=['0','0.5','1','2','3','5','10']
nticks=n_elements(zz)

axis, xaxis=1, xtickv=tt, xtickn=zlab, $
      xticks=nticks-1, xtitle='!8 Redshift (!8z!6)',charsize=2

device, /close





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; From /Volumes/Bulk/npr/cos_pc19a_npr/programs/bias_evoluion/r_0_comp.pro
; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


z_err_lo = abs(z_bar - lo_z) 
z_err_hi = abs(z_bar - hi_z) 

z_err_lo_2QZ = abs(z_bar_2QZ - lo_z_2QZ)
z_err_hi_2QZ = abs(z_bar_2QZ - hi_z_2QZ)

z_err_lo_Shen07 = abs(z_bar_Shen07 -  z_lo_Shen07)
z_err_hi_Shen07 = abs(z_bar_Shen07 -  z_hi_Shen07)

z_err_lo_Myers06 = abs(z_bar_Myers06 -  z_lo_Myers06)
z_err_hi_Myers06 = abs(z_bar_Myers06 -  z_hi_Myers06)


loadct, 6
set_plot, 'ps'
;device, filename='r0_with_redshift.ps', xsize=12, ysize=8,  /inches, /color
device, filename='r0_with_redshift.ps', $
        xsize=8, ysize=6,  /inches, /color
plot, z_surveys, r0_surveys, $
      xrange=[0,5], yrange=[0.,30], $ 
      psym=4, $
      xstyle=3, ystyle=3, thick=2.2, xthick=2.2, $
      ythick=2.2, charsize=1.8, charthick=2.2, $
      title='!6r!I0!N Evolution', $
      xtitle='!8z, redshift', $
      ytitle='!8r!I0!n / !8h!E-1!n!8 MpC', $
      color=0


; lo_z, z_bar, hi_z, r0, r0_plus, r0_minus, gamma, s_hi_fit
plotsym,0,2,/fill
;plotsym, t_lookback, r0 ;, psym=0, /FILL, color=0
oplot, z_bar, r0, psym=8, color=0, thick=4;, symsize=4
oploterror, z_bar, r0, z_err_lo, r0_minus, $
            /lobar, errthick=4, errcolor=0, psym=1, color=0
oploterror, z_bar, r0, z_err_hi, r0_plus, $
            /hibar, errthick=4, errcolor=0, psym=1, color=0


oplot, z_bar_Shen07, r0_Shen07, psym=1, color=192, thick=4;, symsize=4
oploterror, z_bar_Shen07, r0_Shen07, z_err_lo_Shen07, err_r0_Shen07, $
            /lobar, errthick=4, errcolor=192, psym=1, color=192
oploterror, z_bar_Shen07, r0_Shen07, z_err_hi_Shen07, err_r0_Shen07, $
            /hibar, errthick=4, errcolor=192, psym=1, color=192


oplot, z_bar_Myers06, r0_Myers06, psym=1, color=64, thick=4;, symsize=4
oploterror, z_bar_Myers06, r0_Myers06, z_err_lo_Myers06, err_r0_Myers06, $
            /lobar, errthick=4, errcolor=64, psym=1, color=64
oploterror, z_bar_Myers06, r0_Myers06, z_err_hi_Myers06, err_r0_Myers06, $
            /hibar, errthick=4, errcolor=64, psym=1, color=64


oplot, z_bar_2QZ, r0_2QZ, psym=1, color=128, thick=4;, symsize=4
oploterror, z_bar_2QZ, r0_2QZ, z_err_lo_2QZ, r0_minus_2QZ, $
            /lobar, errthick=4, errcolor=128, psym=1, color=128
oploterror, z_bar_2QZ, r0_2QZ, z_err_hi_2QZ, r0_plus_2QZ, $
            /hibar, errthick=4, errcolor=128, psym=1, color=128


clr = fix((surveys_type MOD 8) * 32.)
plots, z_surveys, r0, psym=4, color=clr



xyouts, 0.25, 27, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0


; !7 is the Greek character set and !3 is the standard character set.
; e.g. H beta is H!7b!3
; 
; SUPERSCRIPT/SUBSCRIPT:-
;
; !E or !U = superscript
; !I or !D = subscript
; !N = back to normal







device, /close
set_plot, 'X'




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Redshift along the bottom, age of Uni along the top
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


z_err_lo = abs(z_bar - lo_z) 
z_err_hi = abs(z_bar - hi_z) 

z_err_lo_2QZ = abs(z_bar_2QZ - lo_z_2QZ)
z_err_hi_2QZ = abs(z_bar_2QZ - hi_z_2QZ)

z_err_lo_Shen07 = abs(z_bar_Shen07 -  z_lo_Shen07)
z_err_hi_Shen07 = abs(z_bar_Shen07 -  z_hi_Shen07)

z_err_lo_Myers06 = abs(z_bar_Myers06 -  z_lo_Myers06)
z_err_hi_Myers06 = abs(z_bar_Myers06 -  z_hi_Myers06)


; (1) Create a plot of y versus x with the top axis missing. In my case, I had:
;     The line with xstyle=8+1 tells it to not plot the top xaxis.
loadct, 6
set_plot, 'ps'
;device, filename='r0_with_redshift.ps', xsize=12, ysize=8,  /inches, /color
device, filename='r0_with_redshift_v2.ps', $
        xsize=8.5, ysize=6.5,  /inches, /color, $
        xoffset=0, yoffset=0.2
plot, z_bar, r0, $
      position=[0.15,0.15,0.98,0.98], $
;      xrange=[-0.2,6.5], yrange=[0.,30], $ 
      xrange=[-0.1,3.2], yrange=[0.,30], $ 
      psym=3, $
      xstyle=8+1, ystyle=1, $
      thick=4.2, xthick=4.2, ythick=4.2, $
      charsize=2.2, charthick=4.2, $
;      title='!6r!I0!N Evolution', $
      xtitle='!8z, redshift', $
      ytitle='!8r!I0!n / !8h!E-1!n!8 MpC', $
      color=0

; lo_z, z_bar, hi_z, r0, r0_plus, r0_minus, gamma, s_hi_fit
plotsym,0,2,/fill
;plotsym, t_lookback, r0 ;, psym=0, /FILL, color=0
oplot, z_bar, r0, psym=8, color=0, thick=4;, symsize=4
oploterror, z_bar, r0, z_err_lo, r0_minus, $
            /lobar, errthick=4, errcolor=0, psym=1, color=0
oploterror, z_bar, r0, z_err_hi, r0_plus, $
            /hibar, errthick=4, errcolor=0, psym=1, color=0

;; AGN measurements from CDF N+S (Gilli05) and COSMOS (Miyaji07, Gilli08)
;z_lo_AGN, z_bar_AGN, z_hi_AGN,      r0_AGN, r0_plus_AGN, r0_minus_AGN
oplot, z_bar_AGN, r0_AGN, psym=1, color=128, thick=4;, symsize=4
oploterror, z_bar_AGN, r0_AGN, z_lo_AGN, r0_minus_AGN, $
            /lobar, errthick=4, errcolor=128, psym=1, color=128
oploterror, z_bar_AGN, r0_AGN, z_hi_AGN, r0_plus_AGN, $
            /hibar, errthick=4, errcolor=128, psym=1, color=128





;      xtitle='!8 Age of the Universe (Gyr)', $
;zz=[0.0, 0.5, 1.0, 2.0, 3.0, 5.0, 10.0]
;zz=[10,5,3,2,1,0.5,0]
;tt=getage(zz)

;qso_redshift = [0.526,0.804,1.026,1.225,1.413,1.579, 1.745, 1.921, 2.131,2.475]
;qso_lookback_time = getage(qso_redshift)
;r_nought = qso_redshift * 6.0


zz=[0.0, 0.5, 1.0, 2.0, 3.0, 5.0, 10.0]
zlab=['0','0.5','1','2','3','5','10']
tlab=['13.8', '8.8 ', '6.1', '3.5', '2.3', '1.3', '0.5']
;ttlab=['0','0.5','1','2','3','5','10']

nticks=n_elements(zz)

axis, xaxis=1, xtickv=zz, xtickn=tlab, $
      xticks=nticks-1, $
      xthick=4.2, charthick=4.2, $
      xtitle='!8 Age of the Universe (Gyr)',charsize=2

device, /close
set_plot, 'X'




end

