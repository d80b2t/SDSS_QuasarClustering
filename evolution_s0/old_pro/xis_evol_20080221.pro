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


readcol, 'r0_values_for_plotting.dat', r0, r0_err, gamma, gamma_err, $
         survey_z, survey
t_lookback_surveys = getage(survey_z)

readcol, '../2QZ/Croom05_Table2.dat', lo_z_2QZ, z_bar_2QZ, hi_z_2QZ, $
         s0_2QZ, s0_plus_2QZ, s0_minus_2QZ

;readcol, 'Shen07.dat', z_lo_Shen07, z_hi_Shen07, z_bar_Shen07, $
;         s0_Shen07, err_s0_Shen07

;t_lookback_Shen07 = getage(z_bar_Shen07)

t_lookback_2QZ = getage(z_bar_2QZ)
t_lookback_2QZ_lo = abs(getage(z_bar_2QZ) -  getage(hi_z_2QZ))
t_lookback_2QZ_hi = abs(getage(z_bar_2QZ) -  getage(lo_z_2QZ))

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
device, filename='s0_with_redshift.ps', xsize=12, ysize=8,  /inches, /color
;plot, abs(y(o).tau-tau0), y(o).log_ratio, $
;plot, qso_redshift, r_nought, $
plot, tt, r_nought, $
;plot, zz, r_nought, $
      psym=1, $
      /nodata,$
      xrange=[15,0], yrange=[0,15], $
      xstyle=8+1,ystyle=1,$
      xtitle='Age of the Universe (Gyr)', $
;      ytitle='log !8L!d!6X!n/!8L!dB!n!6', $
      ytitle='!8s!d!60!n/ h^-1 MpC', $
      charsize=2, $
      position=[0.15,0.15,0.95,0.85] ;, $
;      color=0

;if (survey eq 1) then oplot, t_lookback_surveys, r0,  psym=4, color=32
;   oplot,  t_lookback_surveys, r0,  psym=4;, color=(8*survey[j]+32)
;   oplot,  t_lookback_surveys[0], r0[0],  psym=4;, color=(8*survey[j]+32)
;   oplot,  t_lookback_surveys, r0,  psym=4, color=(8*survey[j]+32)
;endfor

clr = fix((survey MOD 8) * 32.)
plots, t_lookback_surveys, r0, psym=4, color=clr


;oplot, qso_redshift, r_nought, psym=4
;oplot, qso_lookback_time, r_nought, psym=4

;oplot, z_bar_2QZ, s0_2QZ, psym=1, color=128
oplot, t_lookback_2QZ, s0_2QZ, psym=1, color=128, thick=4;, symsize=4

oploterror, t_lookback_2QZ, s0_2QZ, t_lookback_2QZ_lo, s0_minus_2QZ, $
            /lobar, errthick=4, errcolor=128, psym=1, color=128
oploterror, t_lookback_2QZ, s0_2QZ, t_lookback_2QZ_hi, s0_plus_2QZ, $
            /hibar, errthick=4, errcolor=128, psym=1, color=128
;oploterror, z_bar_2QZ, s0_2QZ, hi_z_2QZ, s0_plus_2QZ, /lobar, errcolor=128
;
;oploterror, [ x,]  y, [xerr], yerr,   
;            [ /NOHAT, HATLENGTH= , ERRTHICK =, ERRSTYLE=, ERRCOLOR =, 
;              /LOBAR, /HIBAR, NSKIP = , NSUM = , ... OPLOT keywords ]
;psym 1+ 2* 3. 4diamond 5triangle 6square 7X 8 User-defined. USERSYM 


; (2) In IDL come up with the relation between redshift (zz) 
;     and look-back time (tau). Create a vector of redshifts you want
;     to plot
; /usr/common/rsi/lib/general/LibAstro
; http://cerebus.as.arizona.edu/~ioannis/research/red/
; 
; (3) Compute, the corresponding lookback times
;tt=interpol(abs(tautmp-tau0),ztmp,zz)
;
; (4) Create labels for the plot and note the number of tick 
;     marks you want for the axis

zlab=['0','0.5','1','2','3','5','10']
;ttlab=['0','0.5','1','2','3','5','10']
nticks=n_elements(zz)

; (5) use the axis command to add on the redshift axis

axis, xaxis=1, xtickv=tt, xtickn=zlab, $
      xticks=nticks-1, xtitle='Redshift (!8z!6)',charsize=2

device, /close





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; From /Volumes/Bulk/npr/cos_pc19a_npr/programs/bias_evoluion/r_0_comp.pro
; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

readcol, 'r0_values_for_plotting.dat', r0, r0_err, gamma, gamma_err, redshift, survey

readcol, '../2QZ/Croom05_Table2.dat', lo_z_2QZ, z_bar_2QZ, hi_z_2QZ, $
         s0_2QZ, s0_plus_2QZ, s0_minus_2QZ

z_err_lo_2QZ = abs(z_bar_2QZ - lo_z_2QZ)
z_err_hi_2QZ = abs(z_bar_2QZ - hi_z_2QZ)

loadct, 6
set_plot, 'ps'
device, filename='r0_with_redshift.ps', xsize=12, ysize=8,  /inches, /color

plot, redshift, r0, xrange=[0,6], yrange=[0.,15], $ 
      psym=4, $
      xstyle=3, ystyle=3, thick=2.2, xthick=2.2, $
      ythick=2.2, charsize=1.8, charthick=2.2, $
      title='r!I0!N Evolution', xtitle='z, redshift', ytitle='r!I0!N', $
      color=0

oplot, z_bar_2QZ, s0_2QZ, psym=1, color=128, thick=4;, symsize=4

oploterror, z_bar_2QZ, s0_2QZ, z_err_lo_2QZ, s0_minus_2QZ, $
            /lobar, errthick=4, errcolor=128, psym=1, color=128
oploterror, z_bar_2QZ, s0_2QZ, z_err_hi_2QZ, s0_plus_2QZ, $
            /hibar, errthick=4, errcolor=128, psym=1, color=128

clr = fix((survey MOD 8) * 32.)
plots, redshift, r0, psym=4, color=clr








device, /close
set_plot, 'X'







end

