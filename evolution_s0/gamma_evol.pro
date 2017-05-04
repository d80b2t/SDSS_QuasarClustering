;+
; NAME:
;       gamma_evol.pro
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
readcol, 's0_values_for_plotting.dat', r0, r0_err, gamma, gamma_err, $
         survey_z, survey
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
print, 'READ-IN Ross08.dat'







zz=[0.0, 0.5, 1.0, 2.0, 3.0, 5.0, 10.0]
;zz=[10,5,3,2,1,0.5,0]
tt=getage(zz)

qso_redshift = [0.526,0.804,1.026,1.225,1.413,1.579, 1.745, 1.921, 2.131,2.475]
qso_lookback_time = getage(qso_redshift)
r_nought = qso_redshift * 6.0




; (1) Create a plot of y versus x with the top axis missing. In my case, I had:
;     The line with xstyle=8+1 tells it to not plot the top xaxis.

loadct, 13
set_plot, 'ps'
device, filename='gamma_from_xis_Wlookback_time.ps', xsize=12, ysize=8,  /inches, /color
;plot, abs(y(o).tau-tau0), y(o).log_ratio, $
;plot, qso_redshift, r_nought, $
plot, tt, r_nought, $
;plot, zz, r_nought, $
      psym=1, $
      /nodata,$
      xrange=[15,0], yrange=[-0.5,3.0], $
      xstyle=8+1,ystyle=1,$
      xtitle='Age of the Universe (Gyr)', $
;      ytitle='log !8L!d!6X!n/!8L!dB!n!6', $
      ytitle='!8s!d!60!n/ h^-1 MpC', $
      charsize=2, $
      position=[0.15,0.15,0.95,0.85], $
      color=0

plotsym,0,2,/fill
;plotsym, t_lookback, s0 ;, psym=0, /FILL, color=0
oplot, t_lookback, gamma, psym=8, color=0, thick=4;, symsize=4
oploterror, t_lookback, gamma, t_lookback_lo, s0_minus, $
            /lobar, errthick=4, errcolor=0, psym=1, color=0
oploterror, t_lookback, gamma, t_lookback_hi, s0_plus, $
            /hibar, errthick=4, errcolor=0, psym=1, color=0


oplot, t_lookback_Shen07, s0_Shen07, psym=1, color=192, thick=4;, symsize=4
oploterror, t_lookback_Shen07, s0_Shen07,t_lookback_Shen07_lo, err_s0_Shen07, $
            /lobar, errthick=4, errcolor=192, psym=1, color=192
oploterror, t_lookback_Shen07, s0_Shen07, t_lookback_Shen07_hi, err_s0_Shen07, $
            /hibar, errthick=4, errcolor=192, psym=1, color=192


oplot, t_lookback_2QZ, s0_2QZ, psym=1, color=128, thick=4;, symsize=4
oploterror, t_lookback_2QZ, s0_2QZ, t_lookback_2QZ_lo, s0_minus_2QZ, $
            /lobar, errthick=4, errcolor=128, psym=1, color=128
oploterror, t_lookback_2QZ, s0_2QZ, t_lookback_2QZ_hi, s0_plus_2QZ, $
            /hibar, errthick=4, errcolor=128, psym=1, color=128

clr = fix((survey MOD 8) * 32.)
plots, t_lookback_surveys, r0, psym=4, color=clr





zlab=['0','0.5','1','2','3','5','10']
;ttlab=['0','0.5','1','2','3','5','10']
nticks=n_elements(zz)

axis, xaxis=1, xtickv=tt, xtickn=zlab, $
      xticks=nticks-1, xtitle='Redshift (!8z!6)',charsize=2

device, /close





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; From /Volumes/Bulk/npr/cos_pc19a_npr/programs/bias_evoluion/r_0_comp.pro
; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


z_err_lo_2QZ = abs(z_bar_2QZ - lo_z_2QZ)
z_err_hi_2QZ = abs(z_bar_2QZ - hi_z_2QZ)

z_err_lo_Shen07 = abs(z_bar_Shen07 -  z_lo_Shen07)
z_err_hi_Shen07 = abs(z_bar_Shen07 -  z_hi_Shen07)


loadct, 6
set_plot, 'ps'
device, filename='gamma_from_xis_Wredshift.ps', xsize=12, ysize=8,  /inches, /color

plot, survey_z, r0, xrange=[0,6], yrange=[-0.5,3.0], $ 
      psym=4, $
      xstyle=3, ystyle=3, thick=2.2, xthick=2.2, $
      ythick=2.2, charsize=1.8, charthick=2.2, $
      title='r!I0!N Evolution', xtitle='z, redshift', ytitle='r!I0!N', $
      color=0



oplot, z_bar_Shen07, s0_Shen07, psym=1, color=192, thick=4;, symsize=4
oploterror, z_bar_Shen07, s0_Shen07, z_err_lo_Shen07, err_s0_Shen07, $
            /lobar, errthick=4, errcolor=192, psym=1, color=192
oploterror, z_bar_Shen07, s0_Shen07, z_err_hi_Shen07, err_s0_Shen07, $
            /hibar, errthick=4, errcolor=192, psym=1, color=192



oplot, z_bar_2QZ, s0_2QZ, psym=1, color=128, thick=4;, symsize=4
oploterror, z_bar_2QZ, s0_2QZ, z_err_lo_2QZ, s0_minus_2QZ, $
            /lobar, errthick=4, errcolor=128, psym=1, color=128
oploterror, z_bar_2QZ, s0_2QZ, z_err_hi_2QZ, s0_plus_2QZ, $
            /hibar, errthick=4, errcolor=128, psym=1, color=128


clr = fix((survey MOD 8) * 32.)
plots, survey_z, r0, psym=4, color=clr








device, /close
set_plot, 'X'







end

