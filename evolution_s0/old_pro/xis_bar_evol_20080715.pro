;+
; NAME:
;       xis_evol_pro
;
; PURPOSE:
;       To plot the evolution of s0/r0/bias over >85% of the lifetime
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
print, 'You have to run the "red" routine before this!!' 
print

print
readcol, 's0_values_for_plotting.dat', $
         r0, r0_err, gamma, gamma_err, survey_z, survey
t_lookback_surveys = getage(survey_z)
;print, 'READ-IN r0_values_for_plotting.dat'


print
readcol, 'Shen07.dat', z_lo_Shen07, z_bar_Shen07, z_hi_Shen07, $
         s0_Shen07, err_s0_Shen07
t_lookback_Shen07    = getage(z_bar_Shen07)
t_lookback_Shen07_lo = abs(getage(z_bar_Shen07) - getage(z_lo_Shen07))
t_lookback_Shen07_hi = abs(getage(z_bar_Shen07) - getage(z_hi_Shen07))
print, 'READ-IN Shen07.dat'


print
readcol, 'Myers06.dat', z_lo_Myers07, z_bar_Myers07, z_hi_Myers07, $
         s0_Myers07, err_s0_Myers07
t_lookback_Myers07    = getage(z_bar_Myers07)
t_lookback_Myers07_lo = abs(getage(z_bar_Myers07) - getage(z_lo_Myers07))
t_lookback_Myers07_hi = abs(getage(z_bar_Myers07) - getage(z_hi_Myers07))
print, 'READ-IN Myers06.dat'


print
readcol, '../2QZ/Croom05_Table2.dat', lo_z_2QZ, z_bar_2QZ, hi_z_2QZ, $
         s0_2QZ, s0_plus_2QZ, s0_minus_2QZ
t_lookback_2QZ    = getage(z_bar_2QZ)
t_lookback_2QZ_lo = abs(getage(z_bar_2QZ) -  getage(hi_z_2QZ))
t_lookback_2QZ_hi = abs(getage(z_bar_2QZ) -  getage(lo_z_2QZ))
print, 'READ-IN Croom05_Table2.dat'


print
readcol, 'Ross08_xis_UNIFORM_evol.dat', $
         lo_z, z_bar, hi_z, s0, s0_plus, s0_minus, $
         gamma, gamma_plus, gamma_minus, s_hi_fit
t_lookback    = getage(z_bar)
t_lookback_lo = abs(getage(z_bar) -  getage(hi_z))
t_lookback_hi = abs(getage(z_bar) -  getage(lo_z))
print, 'READ-IN Ross08_xis_UNIFORM_evol.dat'






zz=[0.0, 0.5, 1.0, 2.0, 3.0, 5.0, 10.0]
;zz=[10,5,3,2,1,0.5,0]
tt=getage(zz)

qso_redshift = [0.526,0.804,1.026,1.225,1.413,1.579, 1.745, 1.921, 2.131,2.475]
qso_lookback_time = getage(qso_redshift)
r_nought = qso_redshift * 6.0




; (1) Create a plot of y versus x with the top axis missing. In my case, I had:
;     The line with xstyle=8+1 tells it to not plot the top xaxis.

loadct, 6
set_plot, 'ps'
device, filename='s0_bar_with_lookback_time.ps', xsize=8, ysize=6,  /inches, /color
plot, tt, r_nought, $
      psym=1, $
      /nodata,$
      xrange=[13.8,0], yrange=[0,30], $
      xstyle=8+1,ystyle=1,$
      xtitle='!8 Age of the Universe (Gyr)', $
      ytitle='!8s!I0!n / !8h!E-1!n!8 MpC', $
      charsize=2, $
      position=[0.15,0.15,0.95,0.85], $
      color=0

oplot, t_lookback_Shen07, s0_Shen07, psym=1, color=192, thick=4;, symsize=4
oploterror, t_lookback_Shen07, s0_Shen07,t_lookback_Shen07_hi, err_s0_Shen07, $
            /lobar, errthick=4, errcolor=192, psym=1, color=192 
oploterror, t_lookback_Shen07, s0_Shen07,t_lookback_Shen07_lo, err_s0_Shen07, $
            /hibar, errthick=4, errcolor=192, psym=1, color=192  


oplot, t_lookback_Myers07, s0_Myers07, psym=1, color=64, thick=4;, symsize=4
oploterror, t_lookback_Myers07, s0_Myers07, t_lookback_Myers07_hi, $
            err_s0_Myers07, /lobar, errthick=4, errcolor=64, psym=1, color=64
oploterror, t_lookback_Myers07, s0_Myers07, t_lookback_Myers07_lo,  $
            err_s0_Myers07, /hibar, errthick=4, errcolor=64, psym=1, color=64


oplot, t_lookback_2QZ, s0_2QZ, psym=1, color=128, thick=4;, symsize=4
oploterror, t_lookback_2QZ, s0_2QZ, t_lookback_2QZ_lo, s0_minus_2QZ, $
            /lobar, errthick=4, errcolor=128, psym=1, color=128
oploterror, t_lookback_2QZ, s0_2QZ, t_lookback_2QZ_hi, s0_plus_2QZ, $
            /hibar, errthick=4, errcolor=128, psym=1, color=128 

clr = fix((survey MOD 8) * 32.)
plots, t_lookback_surveys, r0, psym=4, color=clr


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

z_err_lo_Myers07 = abs(z_bar_Myers07 -  z_lo_Myers07)
z_err_hi_Myers07 = abs(z_bar_Myers07 -  z_hi_Myers07)

;;
;; cf. Croom et al., 2005, MNRAS, 356, 415 and Fig. 18. 
;;
loadct, 6
set_plot, 'ps'
device, filename='s0_bar_with_redshift.ps', xsize=8, ysize=6,  /inches, /color
plot, survey_z, r0, xrange=[0,3], yrange=[-0.1,0.6], $ 
      psym=4, $
      xstyle=3, ystyle=3, thick=2.2, xthick=2.2, $
      ythick=2.2, charsize=1.8, charthick=2.2, $
      title='!6s!I0!N Evolution', $
      xtitle='!8z, redshift', $
      ytitle='!8s!I0!n / !8h!E-1!n!8 MpC', $
      color=0

;oplot, z_bar_Shen07, s0_Shen07, psym=1, color=192, thick=4;, symsize=4
;oploterror, z_bar_Shen07, s0_Shen07, z_err_lo_Shen07, err_s0_Shen07, $
;            /lobar, errthick=4, errcolor=192, psym=1, color=192
;oploterror, z_bar_Shen07, s0_Shen07, z_err_hi_Shen07, err_s0_Shen07, $
;            /hibar, errthick=4, errcolor=192, psym=1, color=192


;oplot, z_bar_2QZ, s0_2QZ, psym=1, color=128, thick=4;, symsize=4
;oploterror, z_bar_2QZ, s0_2QZ, z_err_lo_2QZ, s0_minus_2QZ, $
;            /lobar, errthick=4, errcolor=128, psym=1, color=128
;oploterror, z_bar_2QZ, s0_2QZ, z_err_hi_2QZ, s0_plus_2QZ, $
            /hibar, errthick=4, errcolor=128, psym=1, color=128

clr = fix((survey MOD 8) * 32.)
plots, survey_z, r0, psym=4, color=clr


; lo_z, z_bar, hi_z, s0, s0_plus, s0_minus, gamma, s_hi_fit
plotsym,0,2,/fill
;plotsym, t_lookback, s0 ;, psym=0, /FILL, color=0
oplot, z_bar, s0_bar20, psym=8, color=0, thick=4;, symsize=4
oploterror, z_bar, s0_bar20, z_err_lo, s0_minus, $
            /lobar, errthick=4, errcolor=0, psym=1, color=0
oploterror, z_bar, s0_bar20, z_err_hi, s0_plus, $
            /hibar, errthick=4, errcolor=0, psym=1, color=0


xyouts, 0.25, 0.5, '!!!! V. PRELIMINARY RESULT !!!!', $
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







end

