;+
; NAME:
;       xis_plot_pro
;
; PURPOSE:
;       To plot the calculated correlation functions for SDSS DR5
;       quasars. This program is primarily for xi(s). 
;-



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;    xi(s),   the usual, log-log plot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

readcol, 'OP/OP_20080508/k_output_UNI22.dat', $
         s_log, s, xis_std, delta_xis, DD, DR, RR, xis_LS, xis_HAM, ratio 
print
print, 'SDSS Quasar xi(s) read-in, k_output_UNI22'
print
xis_q = xis_LS                       ; just setting the xi_Q(s) to the xi_LS
poisson = (1.+xis_q) * (sqrt(2./DD)) ; Poisson errors, da Angela et al. (2005).

readcol, 'jackknife/xis/k_output_UNI22_jackknife_errors.dat', $
         i_jack, j_jack, COV, jack
print
print, 'SDSS Quasar xi(s) read-in, k_output_UNI22'
print

!p.multi=0

loadct, 0
;loadct, 6  ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='xis_DR5_quasars_for_talks_temp.ps', $
        xsize=7.5, ysize=6.0, /inches, /color

p=  [-0.2, -0.2, 1.3, 1.3]
pp =  [0.14, 0.12, 0.98, 0.98]
PolyFill, [p[0],p[0],p[2],p[2],p[0]],  [p[1],p[3],p[3],p[1],p[1]],  COLOR=0, /NORMAL


plot, s, xis_q, $
      /xlog, /ylog, $
      position=pp, $ ; [0.14, 0.12, 0.98, 0.98], $ ; if just 1 panel
      xrange=[0.5, 300], yrange=[0.001001, 90], $ ; bring down to 500 w/o V. PREL.
      psym=4, $
      /noerase, $
      xstyle=1, ystyle=1, $
      xthick=4, ythick=4, thick=8, $
      charsize=2.2, charthick=8, $
      xtitle=' s / h!E-1!N Mpc', $
      ytitle=' !7n(!3s)', $
      ytickformat='(f6.2)', $
      /nodata, $
      color= 255    ;; if polyfill is "on", then loadct=0 and this is white.

choice_SDSS_QSOs = 'n'
read, choice_SDSS_QSOs, PROMPT=' - Plot SDSS QSOs 0.30<z<2.20 (UNIFORMs)? y/n  '
if (choice_SDSS_QSOs eq 'y') then begin

   plotsym,0, 1.8, /fill  ;for UNI22
   oplot, s, xis_q, psym=8, thick=8, color=255         ;also psym=4 is nice.
   oplot, s, xis_q, linestyle=0, thick=8, color=255
   errplot, s, (xis_q-jack), (xis_q+jack), thick=4.0, color=255

   legend, [''], psym=8, box=0, position=[10.,56.], color=255
   xyouts, 15.0, 34.0, 'SDSS DR5Q (uni)', charsize=2.2, charthick=6, color=255
   xyouts, 15.0, 15.3, '0.3 < z < 2.2 ', charsize=2.2, charthick=6, color=255 

   
   choice_single_PLfit = 'n'
   read, choice_single_PLfit, PROMPT=' - Plot Single PL fit model?  y/n   '
   if choice_single_PLfit eq 'y' then begin
      ;; 1 < s < 25 h^-1 Mpc
      s_model = (findgen(250)/10d)
      w= where(s_model ge 1.00, N)
      Single_PL_fit = (s_model[w]/5.95)^(-1.16)
      oplot, s_model[w], Single_PL_fit, $
             linestyle = 0, thick=6, color=255 
      ;; 1 < s < 100 h^-1 Mpc
      s_model = (findgen(1000)/10d)
      w= where(s_model ge 1.00, N)
      Single_PL_fit = (s_model[w]/5.90)^(-1.57)
      oplot, s_model[w], Single_PL_fit, $
             linestyle = 1, thick=6, color=255
   endif
endif
print

le_sign = String(108B)






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots 2QZ xi(s), if you want     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_2QZ = 'n'
read, choice_2QZ, PROMPT=' - Plot 2QZ?  y/n   '
if choice_2QZ eq 'y' then begin
   
   readcol, '2QZ/Croom05/all_xir98.out', s_2QZ, xis_LS_2QZ, err_2QZ, /silent
   print
   print, '2QZ xi(s) read-in'
   print

   loadct, 6
   plotsym,8, 1.5, /fill
   oplot,   s_2QZ, xis_LS_2QZ, color= 160, thick=8, linestyle=1
   oplot,   s_2QZ, xis_LS_2QZ, color= 160, psym=8
   errplot, s_2QZ, (xis_LS_2QZ-err_2QZ), (xis_LS_2QZ+err_2QZ), $
            color=160, linestyle=1, thick=8

   xyouts, 15.0, 6.0, '2QZ  ',  charsize=2.2, charthick=6, color=160
   legend, [''], psym=8, box=0, position=[10.,10.], color=160
     
endif
print



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots 2SLAQ QSO xi(s), if you want     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_2SLAQ_QSOs = 'n'
read, choice_2SLAQ_QSOs, PROMPT=' - Plot 2SLAQ+2QZ?  y/n   '
if choice_2SLAQ_QSOs eq 'y' then begin
   
   readcol, "xis_2SLAQ_QSO_daAngela08.dat", s_2SLAQ_QSO, $
            xis_LS_2SLAQ_QSO, err_2SLAQ_QSO
   print
   print, '2SLAQ+2QZ QSO xi(s) read-in'
   print

   loadct, 6
   plotsym,8, 1.5, /fill
   oplot,   s_2SLAQ_QSO, xis_LS_2SLAQ_QSO, color= 64, thick=8, linestyle=2
   oplot,   s_2SLAQ_QSO, xis_LS_2SLAQ_QSO, color= 64, psym=8
   errplot, s_2SLAQ_QSO, $
            (xis_LS_2SLAQ_QSO-err_2SLAQ_QSO), (xis_LS_2SLAQ_QSO+err_2SLAQ_QSO), $
            thick=8, color=64, linestyle=2 

   xyouts, 15.0, 2.0, '2SLAQ + 2QZ',  charsize=2.2, charthick=6, color=64 
   legend, [''], psym=8, box=0, position=[10.,3.3], color=64, thick=6

endif
print



choice_DR5_overplot = 'n'
read, choice_DR5_overplot, PROMPT='Overplot SDSS DR5 UNI22s again??'
if choice_DR5_overplot eq 'y' then begin
   readcol, 'OP/OP_20080508/k_output_UNI22.dat', $
            s_log, s, xis_std, delta_xis, DD, DR, RR, xis_LS, xis_HAM, ratio 
   xis_q = xis_LS               ; just setting the xi_Q(s) to the xi_LS
   poisson = (1.+xis_q) * (sqrt(2./DD)) 
   plotsym,0, 1.5, /fill                               ;for UNI22
   oplot, s, xis_q, psym=8, thick=8, color=0        ;also psym=4 is nice.
;   oplot, s, xis_q, linestyle=0, thick=8, color=0
   errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=0
endif
print




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots xi(s), log-linearly for values around zero... MIDDLE PANEL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

print 
print, 'ADDING PANEL FOR VALUES OF xi(s) near-zero, +/-0.05, linearly'
readcol, 'OP/OP_20080508/k_output_UNI22.dat', $
         s_log, s, xis_std, delta_xis, DD, DR, RR, xis_LS, xis_HAM, ratio, /silent
print
print, 'SDSS Quasar xi(s) read-in, k_output_UNI22'
print

xis_q = xis_LS                       ; just setting the xi_Q(s) to the xi_LS
poisson = (1.+xis_q) * (sqrt(2./DD)) ;

p = [0.24, 0.20, 0.58, 0.48]
loadct, 0
polyfill, [p[0],p[0],p[2],p[2],p[0]], $
          [p[1],p[3],p[3],p[1],p[1]], $
          COLOR=0, /NORMAL

plot, s, xis_q, /xlog, $
       position=p, $  ; IF INSERT PANEL
      xrange=[50, 300], yrange=[-0.04, 0.04], $ ; IF INSERT PANEL
      /noerase, $
      psym=4, $
      color=255, $
      xthick=4, ythick=4, thick=8, $
      xstyle=1, ystyle=1, $
      /nodata, $
      xcharsize=1.6, ycharsize=1.2, charthick=8

plotsym,0, 1.2, /fill  ;for UNI22
oplot, s, xis_q, psym=8, color=255    ;color=128        ;128, green
errplot, s, (xis_q-jack), (xis_q+jack), thick=4.0, color=255


if choice_2QZ eq 'y' then begin
   readcol, '2QZ/Croom05/all_xir98.out', s_2QZ, xis_LS_2QZ, err_2QZ
   print, '2QZ xi(s) read-in (again)'
   print
   loadct, 6
   plotsym,8, 1.4, /fill
   oplot,   s_2QZ, xis_LS_2QZ, color= 160, psym=8
   errplot, s_2QZ, (xis_LS_2QZ-err_2QZ), (xis_LS_2QZ+err_2QZ), $
            color=160, linestyle=1
endif
print


if choice_2SLAQ_QSOs eq 'y' then begin
   readcol, "xis_2SLAQ_QSO_daAngela08.dat", s_2SLAQ_QSO, $
            xis_LS_2SLAQ_QSO, err_2SLAQ_QSO
   print, '2SLAQ+2QZ QSO xi(s) read-in (again)'
   print
   loadct, 6
   plotsym,8, 1.4, /fill
   oplot,   s_2SLAQ_QSO, xis_LS_2SLAQ_QSO, color= 64, psym=8
   errplot, s_2SLAQ_QSO, $
            (xis_LS_2SLAQ_QSO-err_2SLAQ_QSO), (xis_LS_2SLAQ_QSO+err_2SLAQ_QSO), $
            thick=4.0, color=64, linestyle=2
endif
print



device, /close
set_plot, 'X'

close, /all









end

