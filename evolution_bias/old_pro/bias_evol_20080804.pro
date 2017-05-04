;+
; NAME:
;       bias_evol.pro
;
; PURPOSE:
;       To plot the evolution of bias over >85% of the lifetime
;       of the Universe (oh I say that so flippantly!!) 
;
; EXPLANATION:
;
; CALLING SEQUENCE:
;       .run bias_evol
;
; INPUTS:
;       A list of xis_q (or xir_q?) and  xi_matter values and files
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
;       /usr/commom/rsi/lib/general/LibAstro/
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
;  Zehavi02,05a,05b, daAngela08, Ross07, Ross08a, Ross08b.... ;-)
; 
 
print
print
print, '------------------------------------------------------'
print, '!!!!! You have to run the "red" routine before this !!'
print, 'PSU_IDL> red         '
print, '  red, omega0=0.237, omegalambda=0.763, h100=0.73   '
print, '------------------------------------------------------'
print

print
readcol, 'bias_values_for_plotting.dat', $
         r0, r0_err, gamma, gamma_err, $
         survey_z, survey
t_lookback_surveys = getage(survey_z)
print, 'READ-IN bias_values_for_plotting.dat'
print


print
readcol, 'Shen07_Table6_bias.dat', $
         z_bar_Shen07, M_i_Shen07, phi_prime_Shen07, phi_Shen07, $
         n_qso_Shen07, D_z_Shen07, M_min_Shen07, bias_Shen07
z_lo_Shen07 = z_bar_Shen07-0.1
z_hi_Shen07 = z_bar_Shen07+0.1
err_bias_Shen07 = 1e-8
print, 'READ-IN Shen07_Table6_bias.dat'

readcol, 'Shen07_measured_bias.dat', $
         z_lo_Shen07, z_bar_Shen07, z_hi_Shen07, bias_Shen07, err_bias_Shen07
t_lookback_Shen07    = getage(z_bar_Shen07)
t_lookback_Shen07_lo = abs(getage(z_bar_Shen07) - getage(z_lo_Shen07))
t_lookback_Shen07_hi = abs(getage(z_bar_Shen07) - getage(z_hi_Shen07))
print, 'READ-IN Shen07_measured_bias.dat'
print


print
readcol, 'Myers07_bias_Table1.dat', $
         ;z_lo, z_med, z_hi, bias, b_plus, b_min
         z_lo_Myers07, z_hi_Myers07, z_bar_Myers07, $
         bias_Myers07, err_bias_Myers07_plus, err_bias_Myers07_minus
err_bias_Myers07 = (err_bias_Myers07_plus + err_bias_Myers07_minus) / 2.0d
t_lookback_Myers07    = getage(z_bar_Myers07)
t_lookback_Myers07_lo = abs(getage(z_bar_Myers07) - getage(z_lo_Myers07))
t_lookback_Myers07_hi = abs(getage(z_bar_Myers07) - getage(z_hi_Myers07))
print, 'READ-IN Myerbias6.dat'
print

print
readcol, 'Croom05_Table3.dat', $
         lo_z_2QZ, z_bar_2QZ, hi_z_2QZ, $
         M_bJ_2QZ, M_bJ_star_2QZ, $
         phi_2QZ,  bias_2QZ, bias_plus_2QZ
;         lo_z_2QZ, z_bar_2QZ, hi_z_2QZ, $
;         bias_2QZ, bias_plus_2QZ, bias_minus_2QZ
bias_minus_2QZ =  bias_plus_2QZ
t_lookback_2QZ    = getage(z_bar_2QZ)
t_lookback_2QZ_lo = abs(getage(z_bar_2QZ) -  getage(hi_z_2QZ))
t_lookback_2QZ_hi = abs(getage(z_bar_2QZ) -  getage(lo_z_2QZ))
print, 'READ-IN Croom05_Table3.dat'
print


print
readcol, 'Ross08_bias_UNIFORM_evol.dat', $
         lo_z, z_bar, hi_z, $
         bias_UNI22, bias_plus, bias_minus 
;bias_UNI22 = bias
t_lookback    = getage(z_bar)
t_lookback_lo = abs(getage(z_bar) -  getage(hi_z))
t_lookback_hi = abs(getage(z_bar) -  getage(lo_z))
print, 'READ-IN Ross08_bias_UNIFORM_evol.dat'
print
;print


readcol, 'Lidz_2006_bias_v_z.dat', z_Lidz06, mass_a, mass_b, bias_Lidz06
t_lookback_Lidz06    = getage(z_Lidz06)


readcol, 'Basilakos08/bias_mass1e12.dat', $
         z_Basil1e12, b_wIA_Basil1e12, b_woIA_Basil1e12
readcol, 'Basilakos08/bias_mass7e12.dat', $
         z_Basil7e12, b_wIA_Basil7e12, b_woIA_Basil7e12
readcol, 'Basilakos08/bias_mass1e13.dat', $
         z_Basil1e13, b_wIA_Basil1e13, b_woIA_Basil1e13
readcol, 'Basilakos08/bias_mass7e13.dat', z_Basil7e13, b_woIA_Basil7e13
readcol, 'Basilakos08/bias_mass1e14.dat', z_Basil1e14, b_woIA_Basil1e14
print,' READ-IN the 3 Basilakos et al. (2008) models'
print


readcol, 'Hopkins07/Hopkins07_clstr_default.dat', $
         z_Hopkins07, bias_Hop07, $
         bias_Hop07_i22, bias_Hop07_i20, bias_Hop07_i19 
readcol, 'Hopkins07/Hopkins07_clstr_extreme_feedback.dat', $
         z_Hopkins07_EF, bias_Hop07_EF, $
         bias_Hop07_i22_EF, bias_Hop07_i20_EF, bias_Hop07_i19_EF 
readcol, 'Hopkins07/Hopkins07_clstr_maximal.dat', $
         z_Hopkins07_Max, bias_Hop07_Max, $
         bias_Hop07_i22_Max, bias_Hop07_i20_Max, bias_Hop07_i19_Max 

print,' READ-IN the Hopkins et al. (2007)  models'
print







zz=[0.0, 0.5, 1.0, 2.0, 3.0, 5.0, 10.0]
;zz=[10,5,3,2,1,0.5,0]
tt=getage(zz)

qso_redshift = [0.526,0.804,1.026,1.225,1.413,1.579, 1.745, 1.921, 2.131,2.475]
qso_lookback_time = getage(qso_redshift)
r_nought = qso_redshift * 6.0




; (1) Create a plot of y versus x with the top axis missing. In my case, I had:
;     The line with xstyle=8+1 tells it to not plot the top xaxis.


;zlab=['0','0.5','1','2','3','5','10']
;ttlab=['0','0.5','1','2','3','5','10']
;nticks=n_elements(zz)

;axis, xaxis=1, xtickv=tt, xtickn=zlab, $
;      xthick=4.2, charthick=4.2, $
;      xticks=nticks-1, xtitle='!8 Redshift (!8z!6)',charsize=2







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

x_Croom05_fit    = findgen(1000)/100
y_Croom05_fit    = (0.59)      + (0.289* (1+x_Croom05_fit)^2)
y_Croom05_fit_hi = (0.59+0.19) + ((0.289+0.035) * (1+x_Croom05_fit)^2)
y_Croom05_fit_lo = (0.59-0.19) + ((0.289-0.035) * (1+x_Croom05_fit)^2)

choice_Croom05_fit = 'n'
;read, choice_Croom05_fit, PROMPT=' - Plot Croom et al. (2005) bias model fit? y/n  '
choice_Lidz06_fit = 'n'
;read, choice_Lidz06_fit, PROMPT=' - Plot Lidz et al. (2006) bias model fit? y/n  '
choice_Basilakos08_fit = 'n'
;read, choice_Basilakos08_fit, PROMPT=' - Plot Basilakos et al. (2008) bias model fit? y/n  '
choice_Hopkins07_fit = 'y'
;read, choice_Hopkins07_fit, PROMPT=' - Plot Hopkins et al. (2008) bias model fit? y/n  '



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   Evolution of bias upto  REDSHIFT  6  (SIX)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
loadct, 6
set_plot, 'ps'
device, filename='bias_with_redshift_z6.ps', $
        xsize=8.5, ysize=6.0,  $
        xoffset=0.0, yoffset=0.2, $
        /inches, /color
plot, survey_z, r0, $
      position=[0.14,0.14,0.96,0.98], $
      xrange=[0,6.2], yrange=[-2.,30], $ 
      psym=4, $
      xstyle=8+1, ystyle=3, $
      xthick=4.2, ythick=4.2, $
      thick=4.2, Charsize=1.8, charthick=4.2, $
;      title='Evolution of bias', $
      xtitle='!8z, redshift', $
      ytitle='linear bias, b', $
      /nodata, $
      color=0

if (choice_Croom05_fit eq 'y') then begin
   oplot, x_Croom05_fit, y_Croom05_fit, $
          color=0, linestyle=0
   oplot, x_Croom05_fit, y_Croom05_fit_hi, $
          color=0, linestyle=2
   oplot, x_Croom05_fit, y_Croom05_fit_lo, $
          color=0, linestyle=2
endif


if (choice_Lidz06_fit eq 'y') then begin
   oplot, z_Lidz06, bias_Lidz06, $
          color=32, linestyle=0, thick=6
   lines = indgen(1)
   legend, ['                  '], linestyle=lines, color=32, pos=[0.1,9.4], $
           box=0, thick=8, charthick=4.2 ;, charsize=1.8
   legend, ['Lidz et al. (2006)'], pos=[0.6,10], $
           box=0, charthick=4.2, charsize=1.8
endif


if (choice_Basilakos08_fit eq 'y') then begin
   oplot,    z_Basil1e12, b_wIA_Basil1e12, $
             color=232, linestyle=0, thick=6
;   oplot,    z_Basil1e12, b_w0IA_Basil1e12, $
;             color=232, linestyle=1, thick=6
;   oplot,    z_Basil1e12, ((b_wIA_Basil1e12+b_wIA_Basil1e13)/2.), $
;             color=232, linestyle=0, thick=6
   oplot,    z_Basil7e12, b_wIA_Basil7e12, $
             color=232, linestyle=0, thick=6
;   oplot,    z_Basil7e12, b_woIA_Basil7e12, $
;             color=232, linestyle=0, thick=6
   oplot,    z_Basil1e13, b_wIA_Basil1e13, $
             color=232, linestyle=0, thick=6
;   oplot,    z_Basil1e13, b_woIA_Basil1e13, $
;             color=232, linestyle=0, thick=6

;   oplot,    z_Basil1e13, ((b_wIA_Basil1e13+b_woIA_Basil1e14)/2.), $
;             color=232, linestyle=0, thick=6

;   oplot,    z_Basil7e13, b_woIA_Basil7e13, $
;             color=232, linestyle=1, thick=6
;   oplot,    z_Basil1e14, b_woIA_Basil1e14, $
;             color=232, linestyle=1, thick=6

;   legend, ['                  '], $
;           linestyle=1, color=232, pos=[0.0,17.4], $
;           box=0, thick=8, charthick=4.2 ;, charsize=1.8
;   legend, ['Basilakos08, w/o IA'], pos=[0.46,18], $
;           box=0, charthick=4.2, charsize=1.8
   legend, ['                  '], $
           linestyle=0, color=232, pos=[0.0,15.4], $
           box=0, thick=8, charthick=4.2 ;, charsize=1.8
   legend, ['Basilakos08, IA'], pos=[0.46,16], $
           box=0, charthick=4.2, charsize=1.8

   xyouts, 5.0, 28, '!810!E14!NM!D!9n!3', $
           charsize=2.2, charthick=3.2, color=0
   xyouts, 5.0, 12, '!810!E13!NM!D!9n!3', $
           charsize=2.2, charthick=3.2, color=0
   xyouts, 5.0, 5, '!810!E12!NM!D!9n!3', $
           charsize=2.2, charthick=3.2, color=0
end



if (choice_Hopkins07_fit eq 'y') then begin
   
;; 3 models: "default", "Extreme Feedback" and "Maximal"
;; Each model has 4 magnitude limits, >30, 22, 20,2 and 19.1
   
   
   oplot, z_Hopkins07,  bias_Hop07, $
          color=0, linestyle=0, thick=6
   oplot, z_Hopkins07,  bias_Hop07_i20, $
          color=0, linestyle=1, thick=6
   oplot, z_Hopkins07,  bias_Hop07_i19, $
          color=0, linestyle=2, thick=6

   
;   oplot, z_Hopkins07_EF, bias_Hop07_EF,  $
;          color=0, linestyle=1, thick=6
;   
;   oplot, z_Hopkins07_Max, bias_Hop07_Max,  $
;          color=0, linestyle=2,thick=6

   legend, ['  '], linestyle=0, color=0, pos=[0.10,19.0], box=0, thick=8   
   legend, ['  '], linestyle=1, color=0, pos=[0.10,16.5], box=0, thick=8
   legend, ['  '], linestyle=2, color=0, pos=[0.10,14.0], box=0, thick=8
;   legend, ['Uniform growth to z~2'],   pos=[0.72,19.2], box=0, charthick=4.2, charsize=1.4
;   legend, ['Efficient Feedback'],   pos=[0.72,16.7], box=0, charthick=4.2, charsize=1.4
;   legend, ['Maximal Growth'], pos=[0.72,14.2], box=0, charthick=4.2, charsize=1.4
   
   legend, ['!8L~L!E*!N'],   pos=[0.72,19.2], box=0, charthick=4.2, charsize=1.4
   legend, ['!8i=20.2'],   pos=[0.72,16.7], box=0, charthick=4.2, charsize=1.4
   legend, ['!8i=19.0'], pos=[0.72,14.2], box=0, charthick=4.2, charsize=1.4

   ;legend, ['  ', '  ', '  '], $
   ;        linestyle=[0,1,2], color=[32,32,32], $
   ;        pos=[0.0,15.4], $
   ;        box=0, thick=8, charthick=4.2 ;, charsize=1.8
   ;legend, ['!3L~L!E*!N', '!3i=20.2', '!31=19.0'], pos=[0.46,16], $
   ;        box=0, charthick=4.2, charsize=1.8

end 






; plotsym, 1cirlce, 2downarr, 3=5pointstar, 4triangle, 5upsidedown
; tri, 6leftarrow, 7right arrow, 8 square. 
plotsym,0,1.4, color=192
oplot, z_bar_Shen07, bias_Shen07, psym=8, thick=6;, symsize=4
oploterror, z_bar_Shen07, bias_Shen07, z_err_lo_Shen07, err_bias_Shen07, $
            /lobar, errthick=4, errcolor=192, psym=8
oploterror, z_bar_Shen07, bias_Shen07, z_err_hi_Shen07, err_bias_Shen07, $
            /hibar, errthick=4, errcolor=192, psym=8

plotsym,8,1
oplot, z_bar_Myers07, bias_Myers07, psym=8, color=64, thick=4;, symsize=4
oploterror, z_bar_Myers07, bias_Myers07, z_err_lo_Myers07, err_bias_Myers07, $
            /lobar, errthick=4, errcolor=64, psym=8, color=64
oploterror, z_bar_Myers07, bias_Myers07, z_err_hi_Myers07, err_bias_Myers07, $
            /hibar, errthick=4, errcolor=64, psym=8, color=64

plotsym,8,1, /fill
oplot, z_bar_2QZ, bias_2QZ, psym=8, color=128, thick=4;, symsize=4
oploterror, z_bar_2QZ, bias_2QZ, z_err_lo_2QZ, bias_minus_2QZ, $
            /lobar, errthick=4, errcolor=128, psym=8, color=128
oploterror, z_bar_2QZ, bias_2QZ, z_err_hi_2QZ, bias_plus_2QZ, $
            /hibar, errthick=4, errcolor=128, psym=8, color=128


;plotsym,3,1.4, color=192, /fill
;oplot, z_bar_Gilli05, bias_Gilli05, psym=8, thick=6;, symsize=4
;oploterror, z_bar_Gilli05, bias_Gilli05, z_err_lo_Gilli05, err_bias_Gilli05, $
;            /lobar, errthick=4, errcolor=192, psym=8
;oploterror, z_bar_Gilli05, bias_Gilli05, z_err_hi_Gilli05, err_bias_Gilli05, $
;            /hibar, errthick=4, errcolor=192, psym=8

;clr = fix((survey MOD 8) * 32.)
;plots, survey_z, r0, psym=4, color=clr


; lo_z, z_bar, hi_z, bias, bias_plus, bias_minus, gamma, s_hi_fit
plotsym,0,1.5,/fill
;plotsym, t_lookback, bias ;, psym=0, /FILL, color=0
oplot, z_bar, bias_UNI22, psym=8, color=0, thick=4;, symsize=4
oploterror, z_bar, bias_UNI22, z_err_lo, bias_minus, $
            /lobar, errthick=4, errcolor=0, psym=1, color=0
oploterror, z_bar, bias_UNI22, z_err_hi, bias_plus, $
            /hibar, errthick=4, errcolor=0, psym=1, color=0


;; if  xrange=[0,5.8], yrange=[-2.,30]: 


zz=[0.0, 0.5, 1.0, 2.0, 3.0, 5.0, 10.0]
zlab=['0','','1','2','3','5','10']
tlab=['13.8', ' ', '6.1', '3.5', '2.3', '1.3', '0.5']
;ttlab=['0','0.5','1','2','3','5','10']

nticks=n_elements(zz)

axis, xaxis=1, xtickv=zz, xtickn=tlab, $
      xticks=nticks-1, $
      xthick=4.2, charthick=4.2, $
      xtitle='!8 Age of the Universe (Gyr)',charsize=2


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Quasar Labels
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
plotsym,0,1.25,/fill, thick=4
legend, ['!3SDSS DR5Q (uni)'], psym=8, color=0, pos=[0.4,29], box=0, $
        charthick=4.2, charsize=1.8
plotsym,8,1, thick=4
legend, ['SDSS photo-z'], psym=8, color=64, pos=[0.4,27], box=0, $     
        charthick=4.2, charsize=1.8
plotsym,8,1,/fill, thick=4
legend, ['2QZ'], psym=8, color=128, pos=[0.4,25], box=0, $
        charthick=4.2, charsize=1.8
plotsym,0,1, thick=4
legend, ['SDSS z>2.9!8'], psym=8, color=192, pos=[0.4,23], box=0, $
        charthick=4.2, charsize=1.8

device, /close
set_plot, 'X'






choice_Croom05_fit = 'n'
;read, choice_Croom05_fit, PROMPT=' - Plot Croom et al. (2005) bias model fit? y/n  '
choice_Lidz06_fit = 'n'
;read, choice_Lidz06_fit, PROMPT=' - Plot Lidz et al. (2006) bias model fit? y/n  '
choice_Basilakos08_fit = 'y'
;read, choice_Basilakos08_fit, PROMPT=' - Plot Basilakos et al. (2008) bias model fit? y/n  '
choice_Hopkins07_fit = 'n'
;read, choice_Hopkins07_fit, PROMPT=' - Plot Hopkins et al. (2008) bias model fit? y/n  '


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   Evolution of bias upto REDSHIFT (3) THREE
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
loadct, 6
set_plot, 'ps'
device, filename='bias_with_redshift_z3.ps', $
        xsize=8.5, ysize=6.0,  $
        xoffset=0., yoffset=0.2, $
        /inches, /color
plot, survey_z, r0, $
      position=[0.14,0.14,0.96,0.98], $
;      xtitle='!8z, redshift', $
;      ytitle='linear bias, b', $
      xrange=[0,2.92], yrange=[0.0,8], $ 
      psym=4, $
      xstyle=8+1, ystyle=3, $
      thick=4.2, xthick=4.2, ythick=4.2, $
      charsize=2.2, charthick=4.2, $
;      title='Evolution of bias', $
      xtitle='!8z, redshift', $
      ytitle='linear bias, b', $
     /nodata, $
      color=0

if (choice_Croom05_fit eq 'y') then begin
   oplot, x_Croom05_fit, y_Croom05_fit, $
          color=0, linestyle=0
   oplot, x_Croom05_fit, y_Croom05_fit_hi, $
          color=0, linestyle=2
   oplot, x_Croom05_fit, y_Croom05_fit_lo, $
          color=0, linestyle=2
endif

if (choice_Lidz06_fit eq 'y') then begin
   oplot, z_Lidz06, bias_Lidz06, $
          color=32, linestyle=0, thick=6
   lines = indgen(1)
   legend, ['                  '], linestyle=lines, color=32, pos=[0.1,9.4], $
           box=0, thick=8, charthick=4.2 ;, charsize=1.8
   legend, ['Lidz et al. (2006)'], pos=[0.6,10], $
           box=0, charthick=4.2, charsize=1.8
endif

if (choice_Basilakos08_fit eq 'y') then begin
   oplot,    z_Basil1e12, b_wIA_Basil1e12, $
             color=232, linestyle=0, thick=6
;   oplot,    z_Basil1e12, b_w0IA_Basil1e12, $
;             color=232, linestyle=1, thick=6
   oplot,    z_Basil1e12, ((b_wIA_Basil1e12+b_wIA_Basil1e13)/2.), $
             color=232, linestyle=0, thick=6
;   oplot,    z_Basil7e12, b_wIA_Basil7e12, $
;             color=232, linestyle=0, thick=6
;   oplot,    z_Basil7e12, b_woIA_Basil7e12, $
;             color=232, linestyle=0, thick=6
   oplot,    z_Basil1e13, b_wIA_Basil1e13, $
             color=232, linestyle=0, thick=6
;   oplot,    z_Basil1e13, b_woIA_Basil1e13, $
;             color=232, linestyle=0, thick=6

;   oplot,    z_Basil1e13, ((b_wIA_Basil1e13+b_woIA_Basil1e14)/2.), $
;             color=232, linestyle=0, thick=6

;   oplot,    z_Basil7e13, b_woIA_Basil7e13, $
;             color=232, linestyle=1, thick=6
;   oplot,    z_Basil1e14, b_woIA_Basil1e14, $
;             color=232, linestyle=1, thick=6

   legend, ['                  '], linestyle=0, color=232, pos=[0.0,4.5], box=0, thick=8, charthick=4.2 ;, charsize=1.8
;   legend, ['                  '], linestyle=1, color=232, pos=[0.0,5.0], box=0, thick=8, charthick=4.2 ;, charsize=1.8

;   legend, ['Basilakos08, w/o IA'], pos=[0.22,5.0], box=0, charthick=4.2, charsize=1.8
   legend, ['Basilakos08, IA'], pos=[0.22,4.5], box=0, charthick=4.2, charsize=1.8

   xyouts, 5.0, 28, '!810!E14!NM!D!9n!3', $
           charsize=2.2, charthick=3.2, color=0
   xyouts, 5.0, 12, '!810!E13!NM!D!9n!3', $
           charsize=2.2, charthick=3.2, color=0
   xyouts, 5.0, 5, '!810!E12!NM!D!9n!3', $
           charsize=2.2, charthick=3.2, color=0
end



if (choice_Hopkins07_fit eq 'y') then begin
   
;; 3 models: "default", "Extreme Feedback" and "Maximal"
;; Each model has 4 magnitude limits, >30, 22, 20,2 and 19.1
   
   
   oplot, z_Hopkins07,  bias_Hop07, $
          color=0, linestyle=0, thick=6
   oplot, z_Hopkins07,  bias_Hop07_i20, $
          color=0, linestyle=1, thick=6
   oplot, z_Hopkins07,  bias_Hop07_i19, $
          color=0, linestyle=2, thick=6
   
;   oplot, z_Hopkins07_EF, bias_Hop07_EF,  $
;          color=0, linestyle=1, thick=6
;   
;   oplot, z_Hopkins07_Max, bias_Hop07_Max,  $
;          color=0, linestyle=2, thick=6

   

;   legend, ['  ', '  ', '  '], $
;           linestyle=[0,1,2], color=[0,0,0], $
;           pos=[0.0,5.4], $
;           box=0, thick=8, charthick=4.2 ;, charsize=1.8
;   legend, ['Uniform growth to z~2', 'Extreme Feedback', 'Maximal Growth'], pos=[0.46,6], $
;           box=0, charthick=4.2, charsize=1.8

   legend, ['  '], linestyle=2, color=0, pos=[0.15,5.1], box=0, thick=8
   legend, ['  '], linestyle=1, color=0, pos=[0.15,4.6], box=0, thick=8
   legend, ['  '], linestyle=0, color=0, pos=[0.15,4.1], box=0, thick=8
   legend, ['!8i=19.0'],   pos=[0.44,5.2], box=0, charthick=4.2, charsize=1.6
   legend, ['!8i=20.2'],   pos=[0.44,4.7], box=0, charthick=4.2, charsize=1.6
   legend, ['!8L~L!U*!N'], pos=[0.44,4.2], box=0, charthick=4.2, charsize=1.6


end 



; plotsym, 1cirlce, 2downarr, 3=5pointstar, 4triangle, 5upsidedown
; tri, 6leftarrow, 7right arrow, 8 square. 
plotsym,0,1.4, color=192
oplot, z_bar_Shen07, bias_Shen07, psym=8, thick=6;, symsize=4
;oploterror, z_bar_Shen07, bias_Shen07, z_err_lo_Shen07, err_bias_Shen07, $
;            /lobar, errthick=4, errcolor=192, psym=8
;oploterror, z_bar_Shen07, bias_Shen07, z_err_hi_Shen07, err_bias_Shen07, $
;            /hibar, errthick=4, errcolor=192, psym=8

plotsym,8,1
oplot, z_bar_Myers07, bias_Myers07, psym=8, color=64, thick=4;, symsize=4
oploterror, z_bar_Myers07, bias_Myers07, z_err_lo_Myers07, err_bias_Myers07, $
            /lobar, errthick=4, errcolor=64, psym=8, color=64
oploterror, z_bar_Myers07, bias_Myers07, z_err_hi_Myers07, err_bias_Myers07, $
            /hibar, errthick=4, errcolor=64, psym=8, color=64

plotsym,8,1, /fill
oplot, z_bar_2QZ, bias_2QZ, psym=8, color=128, thick=4;, symsize=4
oploterror, z_bar_2QZ, bias_2QZ, z_err_lo_2QZ, bias_minus_2QZ, $
            /lobar, errthick=4, errcolor=128, psym=8, color=128
oploterror, z_bar_2QZ, bias_2QZ, z_err_hi_2QZ, bias_plus_2QZ, $
            /hibar, errthick=4, errcolor=128, psym=8, color=128


;plotsym,3,1.4, color=192, /fill
;oplot, z_bar_Gilli05, bias_Gilli05, psym=8, thick=6;, symsize=4
;oploterror, z_bar_Gilli05, bias_Gilli05, z_err_lo_Gilli05, err_bias_Gilli05, $
;            /lobar, errthick=4, errcolor=192, psym=8
;oploterror, z_bar_Gilli05, bias_Gilli05, z_err_hi_Gilli05, err_bias_Gilli05, $
;            /hibar, errthick=4, errcolor=192, psym=8

;clr = fix((survey MOD 8) * 32.)
;plots, survey_z, r0, psym=4, color=clr


; lo_z, z_bar, hi_z, bias, bias_plus, bias_minus, gamma, s_hi_fit
plotsym,0,1.2,/fill
;plotsym, t_lookback, bias ;, psym=0, /FILL, color=0
oplot, z_bar, bias_UNI22, psym=8, color=0, thick=4;, symsize=4
oploterror, z_bar, bias_UNI22, z_err_lo, bias_minus, $
            /lobar, errthick=4, errcolor=0, psym=1, color=0
oploterror, z_bar, bias_UNI22, z_err_hi, bias_plus, $
            /hibar, errthick=4, errcolor=0, psym=1, color=0



zz=[0.0, 0.5, 1.0, 2.0, 3.0, 5.0, 10.0]
zlab=['0','0.5','1','2','3','5','10']
tlab=['!813.8', '8.8 ', '6.1', '3.5', '2.3', '1.3', '0.5']

nticks=n_elements(zz)

axis, xaxis=1, xtickv=zz, xtickn=tlab, $
      xticks=nticks-1, $
      xthick=4.2, charthick=4.2, $
      xtitle='!8 Age of the Universe (Gyr)',charsize=2



;; if   xrange=[0,2.8], yrange=[-2.,20], $ 
plotsym,0,1.25,/fill, thick=4
legend, ['!3SDSS DR5Q (uni)'], psym=8, color=0, pos=[0.2,7.7], box=0, $
        charthick=4.2, charsize=2.0
plotsym,8,1, thick=4
legend, ['SDSS photo-z'], psym=8, color=64, pos=[0.2,7.2], box=0, $     
        charthick=4.2, charsize=2.0
plotsym,8,1,/fill, thick=4
legend, ['2QZ'], psym=8, color=128, pos=[0.2,6.7], box=0, $
        charthick=4.2, charsize=2.0
plotsym,0,1, thick=4
legend, ['SDSS z>2.9'], psym=8, color=192, pos=[0.2,6.2], box=0, $
        charthick=4.2, charsize=2.0





; !7 is the Greek character set and !3 is the standard character set.
; e.g. H beta is H!7b!3
; 
; SUPERSCRIPT/SUBSCRIPT:-
;
; !E or !U = superscript
; !I or !D = subscript
; !N = back to normal
; !  = Italic,  

device, /close
set_plot, 'X'


















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; From /Volumes/Bulk/npr/cos_pc19a_npr/programs/bias_evoluion/r_0_comp.pro
;; 
;; Then (and I'm *so* pleased with myself for this!), using
;; curvefit, I have found that the evolution of the xi_rho_20 can be given by an 
;; exponetial:
;;	F(x) = a * exp(b*x) + c 
;; where 
;;      a = 0.2041253448
;;      b =    -1.0823273659
;;      c = 0.0178005192
;;
;; Done by:
;; PSU_IDL> readcol, 'bias_z_DR5Q.dat', a,b,c  
;; PSU_IDL> x=b
;; PSU_IDL> y=c
;; PSU_IDL> weights = make_array(10)
;; PSU_IDL> for i=0L,n_elements(weights)-1 do weights[i]=1d
;; PSU_IDL> A = [0.10,-0.2,0.]   
;; PSU_IDL> yfit = CURVEFIT(X, Y, weights, A, SIGMA, FUNCTION_NAME='gfunct') 
;;
;; where: 
;; PRO gfunct, X, A, F, pder  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;redshift= 1.0
;xis_bar = 0.4
READ, redshift, PROMPT='Enter redshift : ' 
READ, xis_bar, PROMPT='Enter xi(s)_bar_20_gg : ' 

A=[0.2041253448, -1.0823273659, 0.0178005192]
bx = EXP(A[1] * redshift)  
F = A[0] * bx + A[2] 

omega= 0.265
omegaz = omega/(omega+(1.-omega)*(1.+redshift)^(-3.))

;       xi_bar = xi_bar*3./(smax*smax*smax-smin*smin*smin)
       xi_rho =  F
       bias = sqrt((xis_bar/xi_rho)-4./45.*omegaz^(1.2))-omegaz^(0.6)/3
       
print, 'xi_bar_20_mass is ', F, ' at redshift  ',   redshift, ' meaning the bias is  ', bias





end

