;+
; NAME:
;       bias_evol.pro
;
; PURPOSE:
;       To plot the evolution of bias over >85% of the lifetime
;       of the Universe (oh I say that so flippantly!!) 
;
; PROCEDURES CALLED:
;       Need to call the ``red'' routines downloadable from 
;       http://cerebus.as.arizona.edu/~ioannis/research/red/
;       /usr/commom/rsi/lib/general/LibAstro/
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
print, '------------------------------------------------------'
print, '!!!!! You have to run the "red" routine before this !!'
print, 'PSU_IDL> red         '
print, '  red, omega0=0.237, omegalambda=0.763, h100=0.73   '
print, '------------------------------------------------------'
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
         z_bar_Shen07_tab, M_i_Shen07, phi_prime_Shen07, phi_Shen07, $
         n_qso_Shen07, D_z_Shen07, M_min_Shen07, bias_Shen07_tab
z_lo_Shen07 = z_bar_Shen07_tab-0.1
z_hi_Shen07 = z_bar_Shen07_tab+0.1
err_bias_Shen07 = 1e-8
print, 'READ-IN Shen07_Table6_bias.dat'


readcol, 'Shen07_measured_bias.dat', $
         z_lo_Shen07, z_bar_Shen07, z_hi_Shen07, bias_Shen07, err_bias_Shen07
t_lookback_Shen07    = getage(z_bar_Shen07)
t_lookback_Shen07_lo = abs(getage(z_bar_Shen07) - getage(z_lo_Shen07))
t_lookback_Shen07_hi = abs(getage(z_bar_Shen07) - getage(z_hi_Shen07))
print, 'READ-IN Shen07_measured_bias.dat'
print

readcol, 'McLure08_LBGs5pnt32.dat', $
         z_lo_McLure08, z_bar_McLure08, z_hi_McLure08, $
         bias_McLure08, err_bias_McLure08_plus, err_bias_McLure08_minus 
t_lookback_McLure08    = getage(z_bar_McLure08)
t_lookback_McLure08_lo = abs(getage(z_bar_McLure08) - getage(z_lo_McLure08))
t_lookback_McLure08_hi = abs(getage(z_bar_McLure08) - getage(z_hi_McLure08))
print, 'READ-IN McLure08_measured_bias.dat'
print

print
readcol, 'Myers07_bias_Table1.dat', $
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
bias_minus_2QZ =  bias_plus_2QZ
t_lookback_2QZ    = getage(z_bar_2QZ)
t_lookback_2QZ_lo = abs(getage(z_bar_2QZ) -  getage(hi_z_2QZ))
t_lookback_2QZ_hi = abs(getage(z_bar_2QZ) -  getage(lo_z_2QZ))
print, 'READ-IN Croom05_Table3.dat'
print

print
readcol, 'daAngela08_Fig13.dat', $
         lo_z_2SLAQ, z_bar_2SLAQ, hi_z_2SLAQ, $
         bias_2SLAQ, bias_2SLAQ_err
bias_2SLAQ_minus = bias_2SLAQ_err
bias_2SLAQ_plus = bias_2SLAQ_err
t_lookback_2SLAQ    = getage(z_bar_2SLAQ)
t_lookback_2SLAQ_lo = abs(getage(z_bar_2SLAQ) -  getage(hi_z_2SLAQ))
t_lookback_2SLAQ_hi = abs(getage(z_bar_2SLAQ) -  getage(lo_z_2SLAQ))
print, 'READ-IN daAngela08_Fig13.dat'
print


print
readcol, 'Ross08_bias_UNIFORM_evol.dat', $
         lo_z, z_bar, hi_z, $
         bias_UNI22, bias_plus, bias_minus 
t_lookback    = getage(z_bar)
t_lookback_lo = abs(getage(z_bar) -  getage(hi_z))
t_lookback_hi = abs(getage(z_bar) -  getage(lo_z))
print, 'READ-IN Ross08_bias_UNIFORM_evol.dat'
print
print


readcol, 'Lidz_2006_bias_v_z.dat', z_Lidz06, mass_a, mass_b, bias_Lidz06
print
t_lookback_Lidz06    = getage(z_Lidz06)


readcol, 'Basilakos08/bias_mass1e12.dat', $
         z_Basil1e12, b_wIA_Basil1e12, b_woIA_Basil1e12, /silent
readcol, 'Basilakos08/bias_mass7e12.dat', $
         z_Basil7e12, b_wIA_Basil7e12, b_woIA_Basil7e12, /silent
readcol, 'Basilakos08/bias_mass1e13.dat', $
         z_Basil1e13, b_wIA_Basil1e13, b_woIA_Basil1e13, /silent
readcol, 'Basilakos08/bias_mass7e13.dat', z_Basil7e13, b_woIA_Basil7e13, /silent
readcol, 'Basilakos08/bias_mass1e14.dat', z_Basil1e14, b_woIA_Basil1e14, /silent
print,' READ-IN the 3 Basilakos et al. (2008) models'
print


readcol, 'Hopkins07/Hopkins07_clstr_default.dat', $
         z_Hopkins07, bias_Hop07, $
         bias_Hop07_i22, bias_Hop07_i20, bias_Hop07_i19, /silent
readcol, 'Hopkins07/Hopkins07_clstr_extreme_feedback.dat', $
         z_Hopkins07_EF, bias_Hop07_EF, $
         bias_Hop07_i22_EF, bias_Hop07_i20_EF, bias_Hop07_i19_EF, /silent 
readcol, 'Hopkins07/Hopkins07_clstr_maximal.dat', $
         z_Hopkins07_Max, bias_Hop07_Max, $
         bias_Hop07_i22_Max, bias_Hop07_i20_Max, bias_Hop07_i19_Max, /silent 
print,' READ-IN the Hopkins et al. (2007)  models'
print


readcol, 'Jing98/halo_bias_J98.dat', $
         z_Jing98, J98_5d11, J98_1d12, J98_2d12, J98_3d12, J98_4d12, J98_5d12, $
         J98_6d12, J98_7d12, J98_8d12,  J98_9d12, J98_1d13, J98_1pnt6d13, J98_2d13
print, 'READ-IN Jing et al. (1998) bias models'
print


readcol, 'Sheth01/halo_bias_SMT01.dat', $
         z_Sheth01, S01_5d11, S01_1d12, S01_2d12, S01_3d12, S01_4d12, S01_5d12, $
         S01_6d12, S01_7d12, S01_8d12,  S01_9d12, S01_1d13, S01_1pnt6d13, S01_2d13
print, 'READ-IN Sheth et al. (2001) bias models'
print





zz=[0.0, 0.5, 1.0, 2.0, 3.0, 5.0, 10.0]
tt=getage(zz)

qso_redshift = [0.526,0.804,1.026,1.225,1.413,1.579, 1.745, 1.921, 2.131,2.475]
qso_lookback_time = getage(qso_redshift)
r_nought = qso_redshift * 6.0





z_err_lo = abs(z_bar - lo_z) 
z_err_hi = abs(z_bar - hi_z) 
z_err_lo_2QZ = abs(z_bar_2QZ - lo_z_2QZ)
z_err_hi_2QZ = abs(z_bar_2QZ - hi_z_2QZ)
z_err_lo_2SLAQ = abs(z_bar_2SLAQ - lo_z_2SLAQ)
z_err_hi_2SLAQ = abs(z_bar_2SLAQ - hi_z_2SLAQ)
z_err_lo_Shen07 = abs(z_bar_Shen07 -  z_lo_Shen07)
z_err_hi_Shen07 = abs(z_bar_Shen07 -  z_hi_Shen07)
z_err_lo_Myers07 = abs(z_bar_Myers07 -  z_lo_Myers07)
z_err_hi_Myers07 = abs(z_bar_Myers07 -  z_hi_Myers07)
z_err_lo_McLure08 = abs(z_bar_McLure08 -  z_lo_McLure08)
z_err_hi_McLure08 = abs(z_bar_McLure08 -  z_hi_McLure08)

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
loadct, 0
set_plot, 'ps'
device, filename='bias_with_redshift_z6_for_talks_temp.ps', $
        xsize=8.5, ysize=6.0,  $
        xoffset=0.0, yoffset=0.2, $
        /inches, /color

p=  [-0.2, -0.2, 1.3, 1.3]
pp =  [0.14, 0.12, 0.98, 0.98]
PolyFill, [p[0],p[0],p[2],p[2],p[0]],  [p[1],p[3],p[3],p[1],p[1]],  COLOR=0, /NORMAL


plot, survey_z, r0, $
      position=[0.14,0.14,0.96,0.98], $
      xrange=[0,6.2], yrange=[0.0,25], $ 
      /noerase, $
      psym=4, $
      xstyle=8+1, ystyle=3, $
      xthick=4.2, ythick=4.2, $
      thick=4.2, Charsize=1.8, charthick=4.2, $
      xtitle='!8z, redshift', $
      ytitle='linear bias, b', $
      /nodata, $
      color=255

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
             color=216, linestyle=0, thick=6
   oplot,    z_Basil7e12, b_wIA_Basil7e12, $
             color=216, linestyle=0, thick=6
   oplot,    z_Basil1e13, b_wIA_Basil1e13, $
             color=216, linestyle=0, thick=6
   loadct, 6
   legend, ['                  '], $
           linestyle=0, color=232, pos=[0.0,15.4], $
           box=0, thick=8, charthick=4.2 ;, charsize=1.8
   legend, ['Basilakos08'], pos=[0.46,16], $
           box=0, charthick=4.2, charsize=1.8

   xyouts, 5.0, 28, '!810!E14!NM!D!9n!3', $
           charsize=2.2, charthick=3.2, color=0
   xyouts, 5.0, 12, '!810!E13!8h!E-1!NM!D!9n!3', $
           charsize=2.2, charthick=3.2, color=0
   xyouts, 5.0, 5, '!810!E12!NM!D!9n!3', $
           charsize=2.2, charthick=3.2, color=0
end



if (choice_Hopkins07_fit eq 'y') then begin
   
;; 3 models: "default", "Extreme Feedback" and "Maximal"
;; Each model has 4 magnitude limits, >30, 22, 20,2 and 19.1
   
   oplot, z_Hopkins07,  bias_Hop07, $
          color=255, linestyle=0, thick=12
   oplot, z_Hopkins07,  bias_Hop07_i20, $
          color=255, linestyle=0, thick=2
;;   oplot, z_Hopkins07,  bias_Hop07_i19, $
;;          color=255, linestyle=2, thick=6
   
   oplot, z_Hopkins07_EF, bias_Hop07_EF,  $
          color=255, linestyle=1, thick=6
   oplot, z_Hopkins07_EF, bias_Hop07_i20_EF,  $
          color=255, linestyle=1, thick=2

   oplot, z_Hopkins07_Max, bias_Hop07_Max,  $
          color=255, linestyle=2,thick=8
   oplot, z_Hopkins07_Max, bias_Hop07_i20_Max,  $
          color=255, linestyle=2,thick=2

   xyouts, 0.85, 12.0, '!8Inefficient Feedback',charthick=4.2, charsize=1.4, color=255
   xyouts, 0.85, 10.0, '!8Efficient Feedback',charthick=4.2, charsize=1.4, color=255
   xyouts, 0.8, 8.0, '!8Maximal Growth', charthick=4.2, charsize=1.4, color=255
   
   legend, [''], linestyle=0, color=255, pos=[0.10,13.0], box=0, thick=8   
   legend, [''], linestyle=1, color=255, pos=[0.10,11.0], box=0, thick=8
   legend, [''], linestyle=2, color=255, pos=[0.10, 9.0], box=0, thick=8

   legend, [''],   pos=[0.72,13.2], $
           box=0, charthick=4.2, charsize=1.4, color=255
   legend, [''],   pos=[0.72,11.2], $
           box=0, charthick=4.2, charsize=1.4
   legend, [''],   pos=[0.72,9.2], $
           box=0, charthick=4.2, charsize=1.4, color=255

end 




; plotsym, 1cirlce, 2downarr, 3=5pointstar, 4triangle, 5upsidedown
; tri, 6leftarrow, 7right arrow, 8 square. 
loadct, 6
plotsym,0,1.8, color=192, /fill
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


loadct, 0
plotsym,0,1.5,/fill
oplot, z_bar, bias_UNI22, psym=8, color=255, thick=4;, symsize=4
oploterror, z_bar, bias_UNI22, z_err_lo, bias_minus, $
            /lobar, errthick=4, errcolor=255, psym=1, color=255
oploterror, z_bar, bias_UNI22, z_err_hi, bias_plus, $
            /hibar, errthick=4, errcolor=255, psym=1, color=255


choice_McLure08_plot = 'y'
;read, choice_McLure08_plot, PROMPT=' - Plot McLure08 LBG z=5.32 point? y/n  '
if choice_McLure08_plot eq 'y' then begin
   loadct, 0
   plotsym,4,2.4, /fill, thick=4
   oplot, z_bar_McLure08, bias_McLure08, psym=8, color=64, thick=4 ;, symsize=4
   oploterror, z_bar_McLure08, bias_McLure08, z_err_lo_McLure08, err_bias_McLure08_minus, $
               /lobar, errthick=4, errcolor=64, psym=8, color=64
   oploterror, z_bar_McLure08, bias_McLure08, z_err_hi_McLure08, err_bias_McLure08_plus, $
               /hibar, errthick=4, errcolor=64, psym=8, color=64

   plotsym,4,1.3, /fill, thick=4
   xyouts, 0.8, 14.5, '!3LBGs!8',  charthick=4.2, charsize=1.8, color=64
   legend, [''], psym=8, color=64, pos=[0.4,16], box=0, $
           charthick=4.2, charsize=1.8, thick=4.2
   loadct, 6
endif


zz=[0.0, 0.5, 1.0, 2.0, 3.0, 5.0, 10.0]
zlab=['0','','1','2','3','5','10']
tlab=['13.8', ' ', '6.1', '3.5', '2.3', '1.3', '0.5']
;ttlab=['0','0.5','1','2','3','5','10']

nticks=n_elements(zz)
loadct, 0
axis, xaxis=1, xtickv=zz, xtickn=tlab, $
      xticks=nticks-1, $
      xthick=4.2, charthick=4.2, $
      xtitle='!8 Age of the Universe (Gyr)',charsize=2, $
      color=255




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Quasar Labels
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
plotsym,0,1.25,/fill, thick=4
loadct, 0
xyouts, 0.8, 22.5, '!3SDSS DR5Q (uni)',  charthick=4.2, charsize=1.8, color=255
legend, [''], psym=8, color=255, pos=[0.4,24], box=0, $
        charthick=4.2, charsize=1.8

loadct, 6
plotsym,8,1, thick=4
xyouts, 0.8, 20.5, 'SDSS photo-z',  charthick=4.2, charsize=1.8, color=64
legend, [''], psym=8, color=64, pos=[0.4,22], box=0, $     
        charthick=4.2, charsize=1.8

plotsym,8,1,/fill, thick=4
xyouts, 0.8, 18.5, '2QZ',  charthick=4.2, charsize=1.8, color=128
legend, [''], psym=8, color=128, pos=[0.4,20], box=0, $
        charthick=4.2, charsize=1.8

plotsym,0,1, thick=4.2, /fill
xyouts, 0.8, 16.5, 'SDSS z>2.9!8',  charthick=4.2, charsize=1.8, color=192
legend, [''], psym=8, color=192, pos=[0.4,18], box=0, $
        charthick=4.2, charsize=1.8, thick=4.2
device, /close
set_plot, 'X'







choice_Croom05_fit = 'n'
;read, choice_Croom05_fit, PROMPT=' - Plot Croom et al. (2005) bias model fit? y/n  '
choice_Lidz06_fit = 'n'
;read, choice_Lidz06_fit, PROMPT=' - Plot Lidz et al. (2006) bias
;                                    model fit? y/n  '

choice_Basilakos08_fit = 'n'
;read, choice_Basilakos08_fit, PROMPT=' - Plot Basilakos et al. (2008) bias model fit? y/n  '
choice_Hopkins07_fit = 'n'
;read, choice_Hopkins07_fit, PROMPT=' - Plot Hopkins et al. (2008) bias model fit? y/n  '
choice_Jing98_fit = 'n'
;read, choice_Hopkins07_fit, PROMPT=' - Plot Jing et al. (1998) bias model fit? y/n  

choice_Sheth01_fit = 'y'
;read, choice_Hopkins07_fit, PROMPT=' - Plot Hopkins et al. (2008) bias model fit? y/n  





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   Evolution of bias upto REDSHIFT (3) THREE
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
loadct, 0
set_plot, 'ps'
device, filename='bias_with_redshift_z3_for_talks_temp.ps', $
        xsize=8.5, ysize=6.0,  $
        xoffset=0., yoffset=0.25, $
        /inches, /color

p=  [-0.2, -0.2, 1.3, 1.3]
pp =  [0.14, 0.12, 0.98, 0.98]
PolyFill, [p[0],p[0],p[2],p[2],p[0]],  [p[1],p[3],p[3],p[1],p[1]],  COLOR=0, /NORMAL


plot, survey_z, r0, $
      position=pp, $
      /noerase, $
      xrange=[0,2.92], yrange=[0.5,6.5], $ 
      psym=4, $
      xstyle=8+1, ystyle=1, $
      thick=4.2, xthick=4.2, ythick=4.2, $
      charsize=2.2, charthick=4.2, $
      xtitle='!8z, redshift', $
      ytitle='linear bias, b', $
     /nodata, $
      color=255

if (choice_Croom05_fit eq 'y') then begin
   loadct, 6
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
   print
   print, ' PLOTTING Basilakos08 models.... '
   print
   loadct, 6
   oplot,    z_Basil1e12, b_wIA_Basil1e12, color=216, linestyle=1, thick=6
   oplot,    z_Basil1e12, ((b_wIA_Basil1e12+b_wIA_Basil1e13)/2.), $
             color=216, linestyle=1, thick=6
   oplot,    z_Basil1e13, b_wIA_Basil1e13, color=216, linestyle=1, thick=6
end


if (choice_Hopkins07_fit eq 'y') then begin
   print
   print, ' PLOTTING Hopkins07 models.... '
   print

   loadct, 6
   oplot, z_Hopkins07,  bias_Hop07, $
          color=0, linestyle=0, thick=6
;   oplot, z_Hopkins07,  bias_Hop07_i20, $
;          color=0, linestyle=1, thick=6
;   oplot, z_Hopkins07,  bias_Hop07_i19, $
;          color=0, linestyle=2, thick=6
   
   oplot, z_Hopkins07_EF, bias_Hop07_EF,  $
          color=0, linestyle=1, thick=6
;   
   oplot, z_Hopkins07_Max, bias_Hop07_Max,  $
          color=0, linestyle=2, thick=6
   
;   legend, ['  ', '  ', '  '], $
;           linestyle=[0,1,2], color=[0,0,0], $
;           pos=[0.0,5.4], $
;           box=0, thick=8, charthick=4.2 ;, charsize=1.8
;   legend, ['Uniform growth to z~2', 'Extreme Feedback', 'Maximal Growth'], pos=[0.46,6], $
;           box=0, charthick=4.2, charsize=1.8

   legend, ['  '], linestyle=2, color=0, pos=[0.15,4.0], box=0, thick=8
   legend, ['  '], linestyle=1, color=0, pos=[0.15,3.6], box=0, thick=8
   legend, ['  '], linestyle=0, color=0, pos=[0.15,3.2], box=0, thick=8
   legend, ['!8Uniform growth to z~2'],   pos=[0.44,4.1], box=0, charthick=4.2, charsize=1.6
   legend, ['!8Efficient Feedback'],   pos=[0.44,3.7], box=0, charthick=4.2, charsize=1.6
   legend, ['!8Maximal Growth'], pos=[0.44,3.3], box=0, charthick=4.2, charsize=1.6

end 


if (choice_Jing98_fit eq 'y') then begin
   print
   print, ' PLOTTING Jing98 models.... '
   print
   loadct, 6
   oplot, z_Jing98, J98_5d11, color=160, linestyle=1, thick=4
   oplot, z_Jing98, J98_1d12, color=160, linestyle=1, thick=4
   oplot, z_Jing98, J98_2d12, color=160, linestyle=1, thick=4
end


if (choice_Sheth01_fit eq 'y') then begin
   print
   print, ' PLOTTING Sheth01 models.... '
   print
   loadct, 11
   oplot, z_Sheth01, S01_5d11, color=60, linestyle=0, thick=6
   oplot, z_Sheth01, S01_2d12, color=70, linestyle=0, thick=6
   oplot, z_Sheth01, S01_4d12, color=80, linestyle=0, thick=6
end

loadct, 6
plotsym,8,1.8, thick=4, /fill
oplot, z_bar_Myers07, bias_Myers07, psym=8, color=64, thick=4;, symsize=4
oploterror, z_bar_Myers07, bias_Myers07, z_err_lo_Myers07, err_bias_Myers07, $
            /lobar, errthick=4, errcolor=64, psym=8, color=64
oploterror, z_bar_Myers07, bias_Myers07, z_err_hi_Myers07, err_bias_Myers07, $
            /hibar, errthick=4, errcolor=64, psym=8, color=64

plotsym,8,1.7, thick=4, /fill
oplot, z_bar_2QZ, bias_2QZ, psym=8, color=128, thick=4;, symsize=4
oploterror, z_bar_2QZ, bias_2QZ, z_err_lo_2QZ, bias_minus_2QZ, $
            /lobar, errthick=4, errcolor=128, psym=8, color=128
oploterror, z_bar_2QZ, bias_2QZ, z_err_hi_2QZ, bias_plus_2QZ, $
            /hibar, errthick=4, errcolor=128, psym=8, color=128

loadct, 0
plotsym,3,1.9, color=255, thick = 4, /fill
oplot, z_bar_2SLAQ, bias_2SLAQ, psym=8, color=255, thick=4;, symsize=4
oploterror, z_bar_2SLAQ, bias_2SLAQ, lo_z_2SLAQ, bias_2SLAQ_minus, $
            /lobar, errthick=4, errcolor=255, psym=1, color=255
oploterror, z_bar_2SLAQ, bias_2SLAQ, hi_z_2SLAQ, bias_2SLAQ_plus, $
            /hibar, errthick=4, errcolor=255, psym=1, color=255


;plotsym,3,1.4, color=192, /fill
;oplot, z_bar_Gilli05, bias_Gilli05, psym=8, thick=6;, symsize=4
;oploterror, z_bar_Gilli05, bias_Gilli05, z_err_lo_Gilli05, err_bias_Gilli05, $
;            /lobar, errthick=4, errcolor=192, psym=8
;oploterror, z_bar_Gilli05, bias_Gilli05, z_err_hi_Gilli05, err_bias_Gilli05, $
;            /hibar, errthick=4, errcolor=192, psym=8

;clr = fix((survey MOD 8) * 32.)
;plots, survey_z, r0, psym=4, color=clr


loadct, 0
w = where(z_bar lt 2.2, N)
plotsym,0,2.0, thick=4, /fill
oplot, z_bar[w], bias_UNI22[w], psym=8, color=255, thick=4;, symsize=4
oploterror, z_bar[w], bias_UNI22[w], z_err_lo[w], bias_minus[w], $
            /lobar, errthick=4, errcolor=255, psym=1, color=255
oploterror, z_bar[w], bias_UNI22[w], z_err_hi[w], bias_plus[w], $
            /hibar, errthick=4, errcolor=255, psym=1, color=255


if (choice_Basilakos08_fit eq 'y') then begin
   loadct, 6
   if (choice_Sheth01_fit eq 'y') then begin
      legend, [''], pos=[0.12,3.6], box=0, linestyle=1, thick=8, color=216
      xyouts, 0.50, 3.35, '!3Basilakos08',charthick=4.2, charsize=2.0, color=216
   endif

   if (choice_Sheth01_fit eq 'n') then begin
      legend, [''], pos=[0.12,3.6], box=0, linestyle=0, thick=8, color=232
      xyouts, 0.50, 3.35, '!3B08, !8IA',charthick=4.2, charsize=2.0, color=0
;   xyouts, 2.30, 5.2, '!810!E13!N!8h!E-1!NM!D!9n!3', $
      xyouts, 2.50, 4.8, '!813.0!N', $
              charsize=2.2, charthick=6.2, color=180
;   xyouts, 2.30, 3.8, '!810!E12.7!N!8h!E-1!NM!D!9n!3', $
      xyouts, 2.50, 3.6, '!812.7!N', $
              charsize=2.2, charthick=6.2, color=180
;   xyouts, 2.30, 3.0, '!810!E12!N!8h!E-1!NM!D!9n!3', $
      xyouts, 2.50, 2.5, '!812.0!N', $
              charsize=2.2, charthick=6.2, color=180
;   xyouts, 2.50, 2.40, '!8h!E-1!NM!D!9n!3', $
      xyouts, 2.10, 6.00, '!8log!I10!N !8h!E-1!NM!D!9n!3!N', $
              charsize=2.2, charthick=4.2, color=180
   endif
; M_sol in IDL: !NM!D!9n!3
endif


if (choice_Jing98_fit eq 'y') then begin

   loadct, 6
   legend, [''], pos=[0.12,3.6], box=0, linestyle=1, thick=8, color=160
   xyouts, 0.50, 3.35, '!3Jing98',charthick=4.2, charsize=2.0, color=160

;   xyouts, 2.50, 5.3, '!812.3!N', $
;           charsize=2.2, charthick=6.2, color=216
;   xyouts, 2.50, 4.4, '!812.0!N', $
;           charsize=2.2, charthick=6.2, color=216
;   xyouts, 2.50, 3.7, '!811.7!N', $
;           charsize=2.2, charthick=6.2, color=216
;   ;xyouts, 2.50, 2.40, '!8h!E-1!NM!D!9n!3', $
;   ;        charsize=2.2, charthick=4.2, color=32
;;   xyouts, 2.20, 2.00, '!3(log !8h!E-1!NM!D!9n!3!N)', $
;   xyouts, 2.10, 6.00, '!8log!I10!N !8h!E-1!NM!D!9n!3!N', $
;           charsize=2.2, charthick=4.2, color=216
endif


if (choice_Sheth01_fit eq 'y') then begin
   loadct, 11
   legend, [''], pos=[0.12,4.0], box=0, linestyle=0, thick=8, color=70
   xyouts, 0.50, 3.75, '!3Sheth01',charthick=4.2, charsize=2.0, color=70

   xyouts, 2.50, 5.3, '!812.6!N', $
           charsize=2.2, charthick=6.2, color=80
   xyouts, 2.50, 4.35, '!812.3!N', $
           charsize=2.2, charthick=6.2, color=70
   xyouts, 2.50, 3.2, '!811.7!N', $
           charsize=2.2, charthick=6.2, color=60
;   xyouts, 2.20, 2.00, '!3(log !8h!E-1!NM!D!9n!3!N)', $
   xyouts, 2.10, 6.00, '!8log!I10!N !8h!E-1!NM!D!9n!3!N', $
           charsize=2.2, charthick=4.2, color=70
endif


zz=[0.0, 0.5, 1.0, 2.0, 3.0, 5.0, 10.0]
zlab=['0','0.5','1','2','3','5','10']
tlab=['!813.8', '8.8 ', '6.1', '3.5', '2.3', '1.3', '0.5']

nticks=n_elements(zz)
loadct, 0
axis, xaxis=1, xtickv=zz, xtickn=tlab, $
      xticks=nticks-1, $
      xthick=4.2, charthick=4.2, $
      xtitle='!8 Age of the Universe (Gyr)',charsize=2, $
      color=255



;; if   xrange=[0,2.8], yrange=[-2.,20], $ 
loadct, 0
plotsym,0,1.25,/fill, thick=4.2
xyouts, 0.4, 5.8, '!3SDSS DR5Q (uni)',  charthick=4.2, charsize=2.0, color=255
legend, [''], psym=8, color=255, pos=[0.2,6.2], box=0, $
        charthick=4.2, charsize=2.0

loadct, 6
plotsym,8,1, thick=4.2, /fill
xyouts, 0.4, 5.3, 'SDSS photo-z',  charthick=4.2, charsize=2.0, color=64
legend, [''], psym=8, color=64, pos=[0.2,5.7], box=0, $     
        charthick=4.2, charsize=2.0, thick=4.2

plotsym,8,1,/fill, thick=4.2
xyouts, 0.4, 4.8, '2QZ!8',  charthick=4.2, charsize=2.0, color=128
legend, [''], psym=8, color=128, pos=[0.2,5.2], box=0, $
        charthick=4.2, charsize=2.0

loadct, 0
plotsym,3,1, thick=4.2, /fill
xyouts, 0.4, 4.3, '!32SLAQ!8',  charthick=4.2, charsize=2.0, color=255
legend, [''], psym=8, color=255, pos=[0.2,4.7], box=0, $
        charthick=4.2, charsize=2.0



device, /close
set_plot, 'X'




















end

