;+
; NAME:
;       xis_evol_pro
;
; PURPOSE:
;       To plot the evolution of REDSHIFT-SPACE s0 over >85% of the lifetime
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
print, '----------------------------------------------------------'
print, '----------------------------------------------------------'
print, '--  !!!!! You have to run the "red" routine before this !!'
print, '--  PSU_IDL> red         '
print, '    red, omega0=0.237, omegalambda=0.763, h100=0.73   '
print, '----------------------------------------------------------'
print, '----------------------------------------------------------'

print
print, 'You have to run the "red" routine before this!!' 
print

print
readcol, 's0_values_for_plotting.dat', $
         s0, s0_err, gamma, gamma_err, $
         survey_z, survey
t_lookback_surveys = getage(survey_z)
;print, 'READ-IN s0_values_for_plotting.dat'


print
readcol, 'Shen07.dat', z_lo_Shen07, z_bar_Shen07, z_hi_Shen07, $
         s0_Shen07, err_s0_Shen07
t_lookback_Shen07    = getage(z_bar_Shen07)
t_lookback_Shen07_lo = abs(getage(z_bar_Shen07) - getage(z_lo_Shen07))
t_lookback_Shen07_hi = abs(getage(z_bar_Shen07) - getage(z_hi_Shen07))
print, 'READ-IN Shen07.dat'


print
readcol, 'Wake04_s0.dat', $
         z_lo_Wake04, z_bar_Wake04, z_hi_Wake04, $
         s0_Wake04, err_s0_Wake04
t_lookback_Wake04    = getage(z_bar_Wake04)
t_lookback_Wake04_lo = abs(getage(z_bar_Wake04) - getage(z_lo_Wake04))
t_lookback_Wake04_hi = abs(getage(z_bar_Wake04) - getage(z_hi_Wake04))
print, 'READ-IN Wake04.dat'

print
readcol, 'Constantin_Vogeley_2006_s0.dat', $
         z_lo_Cons06, z_bar_Cons06, z_hi_Cons06, $
         s0_Cons06, err_s0_Cons06
t_lookback_Cons06    = getage(z_bar_Cons06)
t_lookback_Cons06_lo = abs(getage(z_bar_Cons06) - getage(z_lo_Cons06))
t_lookback_Cons06_hi = abs(getage(z_bar_Cons06) - getage(z_hi_Cons06))
print, 'READ-IN Constantin_Vogeley_2006_s0.dat'


print
readcol, '../2QZ/Croom05_Table2.dat', lo_z_2QZ, z_bar_2QZ, hi_z_2QZ, $
         s0_2QZ, s0_plus_2QZ, s0_minus_2QZ
t_lookback_2QZ    = getage(z_bar_2QZ)
t_lookback_2QZ_lo = abs(getage(z_bar_2QZ) -  getage(hi_z_2QZ))
t_lookback_2QZ_hi = abs(getage(z_bar_2QZ) -  getage(lo_z_2QZ))
print, 'READ-IN Croom05_Table2.dat'


print
;readcol, 'Ross08_xis_UNIFORM_evol_1s25_floating_gamma.dat', $
readcol, 'Ross08_xis_UNIFORM_evol_1s25_fixed_gamma.dat', $
         lo_z, z_bar, hi_z, s0, s0_plus, s0_minus, $
         gamma, gamma_plus, gamma_minus, s_hi_fit
t_lookback    = getage(z_bar)
t_lookback_lo = abs(getage(z_bar) -  getage(hi_z))
t_lookback_hi = abs(getage(z_bar) -  getage(lo_z))
print, 'READ-IN Ross08_xis_UNIFORM_evol.dat (fitting to 25 h^-1 Mpc)'
print





zz=[0.0, 0.5, 1.0, 2.0, 2.92, 5.0, 10.0]
;zz=[10,5,3,2,1,0.5,0]
tt=getage(zz)
tlab=['13.8', '8.8 ', '6.1', '3.5', '2.3', '1.3', '0.5']

qso_redshift = [0.526,0.804,1.026,1.225,1.413,1.579, 1.745, 1.921, 2.131,2.475]
qso_lookback_time = getage(qso_redshift)
r_nought = qso_redshift * 6.0




; (1) Create a plot of y versus x with the top axis missing. In my case, I had:
;     The line with xstyle=8+1 tells it to not plot the top xaxis.

loadct, 6
set_plot, 'ps'
device, filename='s0_with_lookback_time.ps', $
        xsize=8, ysize=6,  /inches, /color, xoffset=0, yoffset=0.2
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
;      ytitle='!8s!d!60!n/ !8h!E-1!n!8 MpC', $
      ytitle='!8s!I0!n / !8h!E-1!n!8 MpC', $
      charsize=2, $
      position=[0.15,0.15,0.95,0.85], $
      color=0

oplot, t_lookback_Shen07, s0_Shen07, psym=1, color=192, thick=4;, symsize=4
oploterror, t_lookback_Shen07, s0_Shen07,t_lookback_Shen07_hi, err_s0_Shen07, $
            /lobar, errthick=4, errcolor=192, psym=1, color=192 
oploterror, t_lookback_Shen07, s0_Shen07,t_lookback_Shen07_lo, err_s0_Shen07, $
            /hibar, errthick=4, errcolor=192, psym=1, color=192  


oplot, t_lookback_Wake04, s0_Wake04, psym=1, color=64, thick=4;, symsize=4
oploterror, t_lookback_Wake04, s0_Wake04, t_lookback_Wake04_hi, $
            err_s0_Wake04, /lobar, errthick=4, errcolor=64, psym=1, color=64
oploterror, t_lookback_Wake04, s0_Wake04, t_lookback_Wake04_lo,  $
            err_s0_Wake04, /hibar, errthick=4, errcolor=64, psym=1, color=64


oplot, t_lookback_2QZ, s0_2QZ, psym=1, color=128, thick=4;, symsize=4
oploterror, t_lookback_2QZ, s0_2QZ, t_lookback_2QZ_lo, s0_minus_2QZ, $
            /lobar, errthick=4, errcolor=128, psym=1, color=128
oploterror, t_lookback_2QZ, s0_2QZ, t_lookback_2QZ_hi, s0_plus_2QZ, $
            /hibar, errthick=4, errcolor=128, psym=1, color=128 

clr = fix((survey MOD 8) * 32.)
plots, t_lookback_surveys, s0, psym=4, color=clr


plotsym,0,2,/fill
;plotsym, t_lookback, s0 ;, psym=0, /FILL, color=0
oplot, t_lookback, s0, psym=8, color=0, thick=4;, symsize=4
oploterror, t_lookback, s0, t_lookback_lo, s0_minus, $
            /lobar, errthick=4, errcolor=0, psym=1, color=0
oploterror, t_lookback, s0, t_lookback_hi, s0_plus, $
            /hibar, errthick=4, errcolor=0, psym=1, color=0


xyouts, 13.0, 27, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0


zlab=['0','0.5','1','2','3','5','10']
;ttlab=['0','0.5','1','2','3','5','10']
nticks=n_elements(zz)

axis, xaxis=1, xtickv=tt, xtickn=zlab, $
      xticks=nticks-1, xtitle='!8 Redshift (!8z!8)',charsize=2

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

z_err_lo_Wake04 = abs(z_bar_Wake04 -  z_lo_Wake04)
z_err_hi_Wake04 = abs(z_bar_Wake04 -  z_hi_Wake04)

z_err_lo_Cons06 = abs(z_bar_Cons06 -  z_lo_Cons06)
z_err_hi_Cons06 = abs(z_bar_Cons06 -  z_hi_Cons06)


loadct, 6
set_plot, 'ps'
device, filename='s0_with_redshift_z3.ps', $
        xsize=8.5, ysize=6.0,  /inches, /color, $
        xoffset=0, yoffset=0.2
plot, z_bar, s0, $
      position=[0.14,0.14,0.96,0.98], $
;      xrange=[0,2.92], yrange=[0.,30], $ 
      xrange=[0.00,2.92], yrange=[0.,25], $ 
      psym=3, $
      xstyle=8+1, ystyle=3, $
      thick=4.2, xthick=4.2, ythick=4.2, $
      charsize=2.2, charthick=4.2, $
      ;title='!6s!I0!N Evolution', $
      xtitle='!8z, redshift', $
      ytitle='!8s!I0!n / !8h!E-1!n!8 Mpc', $
      /nodata, $
      color=0

s0_full = findgen(4)
s0_full_err = findgen(4)
for i=0L, n_elements(s0_full)-1 do s0_full(i) =5.95
for i=0L, n_elements(s0_full_err)-1 do s0_full_err(i) =0.45
oplot, (findgen(4)), s0_full, linestyle=0, thick=4, color=192
oplot, (findgen(4)), s0_full+s0_full_err, linestyle=1, thick=4, color=192
oplot, (findgen(4)), s0_full-s0_full_err, linestyle=1, thick=4, color=192
;s0_full = [5.50, 6.40, 6.40, 5.50]
;z_bar_full = [0.0, 0.0, 2.92, 2.92]
;polyfill, z_bar_full, s0_full, color=180





loadct, 6
plotsym,3,2.0,/fill, thick=4
oplot, z_bar_Wake04, s0_Wake04, psym=8, color=64, thick=4;, symsize=4
oploterror, z_bar_Wake04, s0_Wake04, z_err_lo_Wake04, err_s0_Wake04, $
            /lobar, errthick=4, errcolor=64, psym=1, color=64
oploterror, z_bar_Wake04, s0_Wake04, z_err_hi_Wake04, err_s0_Wake04, $
            /hibar, errthick=4, errcolor=64, psym=1, color=64

loadct, 6
plotsym,4,2.2,/fill, thick=4
oplot, z_bar_Cons06, s0_Cons06, psym=8, color=192, thick=4;, symsize=4
oploterror, z_bar_Cons06, s0_Cons06, z_err_lo_Cons06, err_s0_Cons06, $
            /lobar, errthick=4, errcolor=192, psym=1, color=192
oploterror, z_bar_Cons06, s0_Cons06, z_err_hi_Cons06, err_s0_Cons06, $
            /hibar, errthick=4, errcolor=192, psym=1, color=192

loadct, 6
plotsym,8,1.4,/fill, thick=4
oplot, z_bar_2QZ, s0_2QZ, psym=8, color=128, thick=4;, symsize=4
oploterror, z_bar_2QZ, s0_2QZ, z_err_lo_2QZ, s0_minus_2QZ, $
            /lobar, errthick=4, errcolor=128, psym=8, color=128
oploterror, z_bar_2QZ, s0_2QZ, z_err_hi_2QZ, s0_plus_2QZ, $
            /hibar, errthick=4, errcolor=128, psym=8, color=128


;clr = fix((survey MOD 8) * 32.)
;plots, survey_z, s0, psym=4, color=clr


plotsym,0,2
oplot, z_bar, s0, psym=8, color=0, thick=4;, symsize=4
plotsym,0,2, /fill
w= where(z_bar le 2.9, N)
oplot, z_bar[w], s0[w], psym=8, color=0, thick=4;, symsize=4
oploterror, z_bar, s0, z_err_lo, s0_minus, $
            /lobar, errthick=1, errcolor=0, psym=1, color=0
oploterror, z_bar, s0, z_err_hi, s0_plus, $
            /hibar, errthick=1, errcolor=0, psym=1, color=0
oploterror, z_bar[w], s0[w], z_err_lo[w], s0_minus[w], $
            /lobar, errthick=4, errcolor=0, psym=1, color=0
oploterror, z_bar[w], s0[w], z_err_hi[w], s0_plus[w], $
            /hibar, errthick=4, errcolor=0, psym=1, color=0



;zz=[0.0, 0.5, 1.0, 2.0, 3.0, 5.0, 10.0]
;;zz=[10,5,3,2,1,0.5,0]
;tt=getage(zz)

;qso_redshift = [0.526,0.804,1.026,1.225,1.413,1.579, 1.745, 1.921, 2.131,2.475]
;qso_lookback_time = getage(qso_redshift)
;r_nought = qso_redshift * 6.0

axis, xaxis=1, xtickv=zz, xtickn=tlab, $
      xticks=nticks-1, $
      xthick=4.2, charthick=4.2, $
      xtitle='!8 Age of the Universe (Gyr)',charsize=2


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Quasar/AGN Labels
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
loadct, 6
plotsym,0,1.0,/fill, thick=4
legend, ['!3SDSS DR5Q (uni)'], psym=8, color=0, pos=[0.1,24], box=0, $
        charthick=4.2, charsize=2.2
;plotsym,8,1.0, thick=4
;legend, ['SDSS photo-z'], psym=8, color=64, pos=[0.1,26.5], box=0, $     
;        charthick=4.2, charsize=1.8
plotsym,8,1.0,/fill, thick=4
legend, ['2QZ'], psym=8, color=128, pos=[0.1,21], box=0, $
        charthick=4.2, charsize=2.2
plotsym,3,1.0,/fill, thick=4
legend, ['SDSS AGN'], psym=8, color=64, pos=[0.1,18], box=0, $
        charthick=4.2, charsize=2.2
loadct, 6
xyouts, 0.35,13.0, 'Seyferts', color=0, charthick=4.2, charsize=2.2
plotsym,4,1.0,/fill, thick=4
legend, [''], psym=8, color=192, pos=[0.1,15], box=0, $
        charthick=4.2, charsize=2.2

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







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; REDSHIFT 6 (SIX) plot
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
loadct, 6
set_plot, 'ps'
device, filename='s0_with_redshift_z6.ps', $
        xsize=8, ysize=6,  $
        /inches, /color, xoffset=0.1, yoffset=0.1
plot, survey_z, s0, $
      position=[0.14,0.14,0.98,0.98], $
      xrange=[0,5], yrange=[0.,30], $ 
      psym=4, $
      xstyle=8+1, ystyle=1, $
      thick=4.2, xthick=4.2, ythick=4.2, $
      charsize=2.2, charthick=4.2, $
      ;title='!6s!I0!N Evolution', $
      xtitle='!8z, redshift', $
      ytitle='!8s!I0!n / !8h!E-1!n!8 Mpc', $
      color=0

oplot, z_bar_Shen07, s0_Shen07, psym=1, color=192, thick=4;, symsize=4
oploterror, z_bar_Shen07, s0_Shen07, z_err_lo_Shen07, err_s0_Shen07, $
            /lobar, errthick=4, errcolor=192, psym=1, color=192
oploterror, z_bar_Shen07, s0_Shen07, z_err_hi_Shen07, err_s0_Shen07, $
            /hibar, errthick=4, errcolor=192, psym=1, color=192


oplot, z_bar_Wake04, s0_Wake04, psym=1, color=64, thick=4;, symsize=4
oploterror, z_bar_Wake04, s0_Wake04, z_err_lo_Wake04, err_s0_Wake04, $
            /lobar, errthick=4, errcolor=64, psym=1, color=64
oploterror, z_bar_Wake04, s0_Wake04, z_err_hi_Wake04, err_s0_Wake04, $
            /hibar, errthick=4, errcolor=64, psym=1, color=64


oplot, z_bar_2QZ, s0_2QZ, psym=1, color=128, thick=4;, symsize=4
oploterror, z_bar_2QZ, s0_2QZ, z_err_lo_2QZ, s0_minus_2QZ, $
            /lobar, errthick=4, errcolor=128, psym=1, color=128
oploterror, z_bar_2QZ, s0_2QZ, z_err_hi_2QZ, s0_plus_2QZ, $
            /hibar, errthick=4, errcolor=128, psym=1, color=128


clr = fix((survey MOD 8) * 32.)
plots, survey_z, s0, psym=4, color=clr


; lo_z, z_bar, hi_z, s0, s0_plus, s0_minus, gamma, s_hi_fit
plotsym,0,2,/fill
;plotsym, t_lookback, s0 ;, psym=0, /FILL, color=0
oplot, z_bar, s0, psym=8, color=0, thick=4;, symsize=4
oploterror, z_bar, s0, z_err_lo, s0_minus, $
            /lobar, errthick=4, errcolor=0, psym=1, color=0
oploterror, z_bar, s0, z_err_hi, s0_plus, $
            /hibar, errthick=4, errcolor=0, psym=1, color=0


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

