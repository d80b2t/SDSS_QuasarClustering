;;+
;; NAME:
;;       xis_plot_pro
;;
;; PURPOSE:
;;       To plot the calculated correlation functions for SDSS DR5
;;       quasars. This program is primarily for xi(s). 
;;
;; CALLING SEQUENCE:
;;       .run xi_plot
;;
;; OPTIONAL INPUTS:
;;       None.
;;
;; KEYWORD PARAMETERS:
;;       n/a
;;
;; OUTPUTS:
;;       various
;;
;; OPTIONAL OUTPUTS:
;;       also various
;;
;; COMMON BLOCKS:
;;       None.
;;
;; NOTES:
;;       /usr/common/rsi/lib/general/LibAstro/  
;;    
;; MODIFICATION HISTORY:
;;       Version 1.00  NPR    20th November 2007
;;-


;talk = 2.5
talk = 1.0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;    xi(s),   the usual, log-log plot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

readcol, 'k_output_UNI22.dat', $
         s_log, s, xis_std, delta_xis, DD, DR, RR, xis_LS, xis_HAM, ratio 
print
print, 'SDSS Quasar xi(s) read-in, k_output_UNI22'
print

;; just setting the xi_Q(s) to the xi_LS
xis_q = xis_LS                       

;; Poisson errors, e.g. da Angela et al. (2005).
poisson = (1.+xis_q) * (sqrt(2./DD)) 


readcol, 'k_output_UNI22_jackknife_errors.dat', $
         i_jack, j_jack, COV, jack
print
print, 'SDSS Quasar xi(s) read-in, k_output_UNI22'
print

;!p.multi=[0,1,2]
;!p.multi=[0,1,1]
!p.multi=0

loadct, 0
loadct, 6  ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='xis_DR5_quasars_temp.eps', $
        xsize=8.5, ysize=8.0, $
        yoffset=0.2, $
        /inches, /color, /ENCAPSULATED

p=  [-0.2, -0.2, 1.3, 1.3]
;pp =  [0.14, 0.12, 0.98, 0.98]  ;; for .pdfs
pp =  [0.19, 0.12, 0.98, 0.98]  ;; for .eps



plot, s, xis_q, $
      /xlog, /ylog, $
;      position=[0.22, 0.38, 0.98, 0.98], $ ; if top of 3 panels
      position=[0.19, 0.28, 0.98, 0.98], $ ; if top of 2 panels
;      position=pp, $            ; [0.14, 0.12, 0.98, 0.98], $ ; if just 1 panel
;      xrange=[0.5, 300], yrange=[0.001001, 500], $ ; bring down to 500 
      xrange=[0.5, 300], yrange=[0.001001, 90], $ 
      psym=4, $
      /noerase, $
      xstyle=1, ystyle=1, $
      xthick=4, ythick=4, thick=4*talk, $
      charsize=2.2, charthick=4.2*talk, $
;      xtitle=' s / h!E-1!N Mpc', $
      ytitle=' !7n(!3s)', $
      xtickformat='(a1)', $
      ytickformat='(f6.2)', $
      /nodata, $
      color= 255    ;; if polyfill is "on", then loadct=0 and this is white.

choice_SDSS_QSOs = 'n'
read, choice_SDSS_QSOs, PROMPT=' - Plot SDSS QSOs 0.30<z<2.20 (UNIFORMs)? y/n  '
if (choice_SDSS_QSOs eq 'y') then begin
   
   plotsym,0, 1.25*(talk/2d), /fill ;for UNI22
   plotsym,0, 1.25, /fill           ;for UNI22
   oplot, s, xis_q, psym=8, thick=4*talk, color=255 
   oplot, s, xis_q, linestyle=0, thick=4, color=255
   errplot, s, (xis_q-jack), (xis_q+jack), thick=4.0, color=255
   
;   if yrange_max eq 500 then begin
;      legend, [''], psym=8, box=0, position=[10.,256.]   
;      xyouts, 15.0, 128.0, 'SDSS DR5Q (uni)', charsize=2.2, charthick=6.2, color=255 
;   endif
   
   legend, [''], box=0, position=[10.,56.], psym=8
   xyouts, 15.0, 34.0, 'SDSS DR5Q (uni)', charsize=2.2, charthick=6.2, color=255
   legend, [''], box=0, position=[6.,22.], linestyle=0, thick=6, color=0
   xyouts, 15.0, 15.3,  '0.3 < z < 2.2 ', charsize=2.2, charthick=6.2, color=255 


   

   choice_jaca08_model = 'n'
   read, choice_jaca08_model, PROMPT=' - Plot da Angela (2008) Fig. 5 model?  y/n   '
   if choice_jaca08_model eq 'y' then begin
      readcol, "jaca_models/model_xis_w800_beta0.32_om0.3_r1_6.0_gamma1_1.45_r2_7.25_gamma2_2.30_smooth2.dat", $
               r_model, xi_model, format = 'd,d'
      ;; the above model covers 0.2 < s < 40.2 Mpc h^1 
      boost=1.5
      
      oplot, r_model, (xi_model*boost), linestyle = 0, thick = 4
      oplot, findgen(101)/100.*(80.-40.)+40., (((findgen(101)/100.*(80.-40.)+40.)/7.35)^(-2.30)*(1.+2./3.*0.32+0.2*0.32*0.32)*boost), linestyle = 0, thick = 4
   endif
   
   choice_single_PLfit = 'n'
   read, choice_single_PLfit, PROMPT=' - Plot Single PL fit model(s)?  y/n   '
   if choice_single_PLfit eq 'y' then begin
      ;; 1 < s < 25 h^-1 Mpc
      s_model = (findgen(250)/10d)
      w= where(s_model ge 1.00, N)
      Single_PL_fit = (s_model[w]/5.95)^(-1.16)
      oplot, s_model[w], Single_PL_fit, $
             linestyle = 0, thick = 4*talk, color=0 ;255 
      ;; 1 < s < 100 h^-1 Mpc
      s_model = (findgen(1000)/10d)
      w= where(s_model ge 1.00, N)
      Single_PL_fit = (s_model[w]/5.90)^(-1.57)
      oplot, s_model[w], Single_PL_fit, $
             linestyle = 1, thick = 4*talk, color=0 ;255
   endif
endif
print

le_sign = String(108B)

  
endif
print
   



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   0.30 < z < 0.68,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_0pnt30z0pnt68 = 'n'
;read, choice_0pnt30z0pnt68, PROMPT=' - Plot the 0.30<z<0.68 (UNIFORMs)?  y/n  '
if choice_0pnt30z0pnt68 eq 'y' then begin
   
   readcol, "k_output_UNI22_0pnt30z0pnt68_10log.dat", $ 
            log_s, s_0pnt30, xis_std, delta_xis, DD_0pnt30, DR, RR, $
            xis_LS_0pnt30, xis_HAM, ratio
   print
   print, 'k_output_UNI22_0pnt30z0pnt68.dat read-in '
   print

   poisson_0pnt30 = (1.+xis_LS_0pnt30) * (sqrt(2./DD_0pnt30))
   oplot,   s_0pnt30, xis_LS_0pnt30, psym=4, color=24
   oplot,   s_0pnt30, xis_LS_0pnt30, linestyle=0,color=24
   errplot, s_0pnt30, $
            (xis_LS_0pnt30-poisson_0pnt30), (xis_LS_0pnt30+poisson_0pnt30), $
            thick=4.0, color=24

endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   0.68 < z < 0.92,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_0pnt68z0pnt92 = 'n'
;read, choice_0pnt68z0pnt92, PROMPT=' - Plot the 0.68<z<0.92 (UNIFORMs)?  y/n  '
if choice_0pnt68z0pnt92 eq 'y' then begin
   
   readcol, "k_output_UNI22_0pnt68z0pnt92_10log.dat", $
            log_s, s_0pnt68, xis_std, delta_xis, DD_0pnt68, DR, RR, $
            xis_LS_0pnt68, xis_HAM, ratio
   print
   print, 'k_output_UNI22_0pnt68z0pnt92_10log.dat read-in '
   print
   
   poisson_0pnt68 = (1.+xis_LS_0pnt68) * (sqrt(2./DD_0pnt68))
   
   oplot,   s_0pnt68, xis_LS_0pnt68, psym=4, color=48
   ;oplot,   s_0pnt68, xis_LS_0pnt68, linestyle=1,color=48
   errplot, s_0pnt68, $
            (xis_LS_0pnt68-poisson_0pnt68), (xis_LS_0pnt68+poisson_0pnt68), $
            thick=4.0, color=48
   xyouts, 5.0, 150.0, 'Uniform  0.68<z<0.92', $
           charsize=2.2, charthick=4.2, color=48

endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   0.92 < z < 1.13,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_0pnt92z1pnt13 = 'n' 
;read, choice_0pnt92z1pnt13, PROMPT=' - Plot the 0.92<z<1.13 (UNIFORMs)?  y/n  '
if choice_0pnt92z1pnt13 eq 'y' then begin
   
   readcol, "k_output_UNI22_0pnt92z1pnt13_10log.dat", $
            s_log, s_0pnt92, xis_std, delta_xis, DD_0pnt92, DR, RR, $
            xis_LS_0pnt92, xis_HAM, ratio
   print
   print, 'k_output_UNI22_0pnt92z1pnt13.dat read-in '
   print
   
   poisson_0pnt92 = (1.+xis_LS_0pnt92) * (sqrt(2./DD_0pnt92))
   
   oplot,   s_0pnt92, xis_LS_0pnt92, psym=4, color=72
   oplot,   s_0pnt92, xis_LS_0pnt92, linestyle=2,color=72
   errplot, s_0pnt92, $
            (xis_LS_0pnt92-poisson_0pnt92), (xis_LS_0pnt92+poisson_0pnt92), $
            thick=4.0, color=72
   xyouts, 5.0, 150.0, 'Uniform  0.68<z<0.92', $
           charsize=2.2, charthick=4.2, color=72
   
endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   1.13 < z < 1.32,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_1pnt13z1pnt32 = 'n' 
;read, choice_1pnt13z1pnt32, PROMPT=' - Plot the 1.13<z<1.32 (UNIFORMs)?  y/n  '
if choice_1pnt13z1pnt32 eq 'y' then begin
   
   readcol, "k_output_UNI22_1pnt13z1pnt32_10log.dat", $
            s_log, s_1pnt13, xis_std, delta_xis, DD_1pnt13, DR, RR, $
            xis_LS_1pnt13, xis_HAM, ratio
   print
   print, 'k_output_UNI22_1pnt13z1pnt32.dat read-in '
   print

   poisson_1pnt13 = (1.+xis_LS_1pnt13) * (sqrt(2./DD_1pnt13))
   
   oplot,   s_1pnt13, xis_LS_1pnt13, psym=4, color=96
   oplot,   s_1pnt13, xis_LS_1pnt13, linestyle=2,color=96
   errplot, s_1pnt13, $
            (xis_LS_1pnt13-poisson_1pnt13), (xis_LS_1pnt13+poisson_1pnt13), $
            thick=4.0, color=96
 xyouts, 5.0, 150.0, 'Uniform  1.13<z<1.32', $
           charsize=2.2, charthick=4.2, color=96

endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   1.32 < z < 1.50,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_1pnt32z1pnt50 = 'n' 
;read, choice_1pnt32z1pnt50, PROMPT=' - Plot the 1.32<z<1.50 (UNIFORMs)?  y/n  '
if choice_1pnt32z1pnt50 eq 'y' then begin
   
   readcol, "k_output_UNI22_1pnt32z1pnt50_10log.dat", $
            s_log, s_1pnt32, xis_std, delta_xis, DD_1pnt32, DR, RR, $
            xis_LS_1pnt32, xis_HAM, ratio
   print
   print, 'k_output_UNI22_1pnt32z1pnt50.dat read-in '
   print

   poisson_1pnt32 = (1.+xis_LS_1pnt32) * (sqrt(2./DD_1pnt32))
   
   oplot,   s_1pnt32, xis_LS_1pnt32, psym=4, color=120
   oplot,   s_1pnt32, xis_LS_1pnt32, linestyle=2,color=120
   errplot, s_1pnt32, $
            (xis_LS_1pnt32-poisson_1pnt32), (xis_LS_1pnt32+poisson_1pnt32), $
            thick=4.0, color=120
 xyouts, 5.0, 150.0, 'Uniform  1.32<z<1.50', $
           charsize=2.2, charthick=4.2, color=120

 choice_plfit = 'n'
   read, choice_plfit, PROMPT=' --- Plot PL Fit 1.32<z<1.50 (UNIFORMs)? y/n  '
   if (choice_plfit eq 'y') then begin
      s_set=findgen(100)
      s_nought = 6.05
      gamma    = 1.670
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, color=120
      xis_q_div_plfit = (xis_q / plfit_1) 
      s_set=findgen(25)
      s_nought = 6.10
      gamma    = 1.635
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, linestyle=1, color=120
      xis_q_div_plfit = (xis_q / plfit_1) 
   endif
endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   1.50 < z < 1.66,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_1pnt50z1pnt66 = 'n' 
;read, choice_1pnt50z1pnt66, PROMPT=' - Plot the 1.50<z<1.66 (UNIFORMs)?  y/n  '
if choice_1pnt50z1pnt66 eq 'y' then begin
   
   readcol, "k_output_UNI22_1pnt50z1pnt66_10log.dat", $
            s_log, s_1pnt50, xis_std, delta_xis, DD_1pnt50, DR, RR, $
            xis_LS_1pnt50, xis_HAM, ratio
   print
   print, 'k_output_UNI22_1pnt50z1pnt66.dat read-in '
   print

   poisson_1pnt50 = (1.+xis_LS_1pnt50) * (sqrt(2./DD_1pnt50))
   
   oplot,   s_1pnt50, xis_LS_1pnt50, psym=4, color=144
   oplot,   s_1pnt50, xis_LS_1pnt50, linestyle=2,color=144
   errplot, s_1pnt50, $
            (xis_LS_1pnt50-poisson_1pnt50), (xis_LS_1pnt50+poisson_1pnt50), $
            thick=4.0, color=144
 xyouts, 5.0, 150.0, 'Uniform  0.68<z<0.92', $
           charsize=2.2, charthick=4.2, color=144


 choice_plfit = 'n'
   read, choice_plfit, PROMPT=' --- Plot PL Fit 1.50<z<1.66 (UNIFORMs)? y/n  '
   if (choice_plfit eq 'y') then begin
      s_set=findgen(100)
      s_nought = 6.05
      gamma    = 1.670
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, color=144
      xis_q_div_plfit = (xis_q / plfit_1) 
      s_set=findgen(25)
      s_nought = 6.10
      gamma    = 1.635
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, linestyle=1, color=144
      xis_q_div_plfit = (xis_q / plfit_1) 
   endif
endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   1.66 < z < 1.83,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_1pnt66z1pnt83 = 'n' 
;read, choice_1pnt66z1pnt83, PROMPT=' - Plot the 1.66<z<1.83 (UNIFORMs)?  y/n  '
if choice_1pnt66z1pnt83 eq 'y' then begin
   
   readcol, "k_output_UNI22_1pnt66z1pnt83_10log.dat", $
            s_log, s_1pnt66, xis_std, delta_xis, DD_1pnt66, DR, RR, $
            xis_LS_1pnt66, xis_HAM, ratio
   print
   print, 'k_output_UNI22_1pnt66z1pnt83.dat read-in '
   print

   poisson_1pnt66 = (1.+xis_LS_1pnt66) * (sqrt(2./DD_1pnt66))
   
   oplot,   s_1pnt66, xis_LS_1pnt66, psym=4, color=168
   oplot,   s_1pnt66, xis_LS_1pnt66, linestyle=2,color=168
   errplot, s_1pnt66, $
            (xis_LS_1pnt66-poisson_1pnt66), (xis_LS_1pnt66+poisson_1pnt66), $
            thick=4.0, color=168
 xyouts, 5.0, 150.0, 'Uniform  0.68<z<0.92', $
           charsize=2.2, charthick=4.2, color=168


 choice_plfit = 'n'
   read, choice_plfit, PROMPT=' --- Plot PL Fit 1.66<z<1.83 (UNIFORMs)? y/n  '
   if (choice_plfit eq 'y') then begin
      s_set=findgen(100)
;      s_nought = 
;      gamma    = 
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, color=168
      xis_q_div_plfit = (xis_q / plfit_1) 
      s_set=findgen(25)
;      s_nought = 
;      gamma    = 
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, linestyle=1, color=168
      xis_q_div_plfit = (xis_q / plfit_1) 
   endif
endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   1.83 < z < 2.02,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_1pnt83z2pnt02 = 'n' 
;read, choice_1pnt83z2pnt02, PROMPT=' - Plot the 1.83<z<2.02 (UNIFORMs)?  y/n  '
if choice_1pnt83z2pnt02 eq 'y' then begin
   
   readcol, "k_output_UNI22_1pnt83z2pnt02_10log.dat", $
            s_log, s_1pnt83, xis_std, delta_xis, DD_1pnt83, DR, RR, $
            xis_LS_1pnt83, xis_HAM, ratio
   print
   print, 'k_output_UNI22_1pnt83z2pnt02.dat read-in '
   print

   poisson_1pnt83 = (1.+xis_LS_1pnt83) * (sqrt(2./DD_1pnt83))
   
   oplot,   s_1pnt83, xis_LS_1pnt83, psym=4, color=192
   oplot,   s_1pnt83, xis_LS_1pnt83, linestyle=2,color=192
   errplot, s_1pnt83, $
            (xis_LS_1pnt83-poisson_1pnt83), (xis_LS_1pnt83+poisson_1pnt83), $
            thick=4.0, color=192
 xyouts, 5.0, 150.0, 'Uniform  1.83<z<2.02', $
           charsize=2.2, charthick=4.2, color=192

choice_plfit = 'n'
   read, choice_plfit, PROMPT=' --- Plot PL Fit 1.83<z<2.02 (UNIFORMs)? y/n  '
   if (choice_plfit eq 'y') then begin
      s_set=findgen(100)
;      s_nought = 
;      gamma    = 
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, color=192
      xis_q_div_plfit = (xis_q / plfit_1) 
      s_set=findgen(25)
;      s_nought = 
;      gamma    = 
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, linestyle=1, color=192
      xis_q_div_plfit = (xis_q / plfit_1) 
   endif

endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   2.02 < z < 2.25,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_2pnt02z2pnt25 = 'n' 
;read, choice_2pnt02z2pnt25, PROMPT=' - Plot the 2.02<z<2.25 (UNIFORMs)?  y/n  '
if choice_2pnt02z2pnt25 eq 'y' then begin
   
   readcol, "k_output_UNI22_2pnt02z2pnt20_10log.dat", $
            s_log, s_2pnt02, xis_std, delta_xis, DD_2pnt02, DR, RR, $
            xis_LS_2pnt02, xis_HAM, ratio
   print, 'k_output_UNI22_2pnt02z2pnt20.dat read-in '
   print
   
   poisson_2pnt02 = (1.+xis_LS_2pnt02) * (sqrt(2./DD_2pnt02))
   
;   oplot,   s_2pnt02, xis_LS_2pnt02, psym=4, color=216
;   oplot,   s_2pnt02, xis_LS_2pnt02, linestyle=2,color=216
;   errplot, s_2pnt02, $
;            (xis_LS_2pnt02-poisson_2pnt02), (xis_LS_2pnt02+poisson_2pnt02), $
;            thick=4.0, color=216
   xyouts, 5.0, 150.0, 'Uniform  2.02<z<2.25', $
           charsize=2.2, charthick=4.2, color=216
   choice_plfit = 'n'
   read, choice_plfit, PROMPT=' --- Plot PL Fit 2.02<z<2.25 (UNIFORMs)? y/n  '
   if (choice_plfit eq 'y') then begin
      s_set=findgen(100)
;      s_nought = 
;      gamma    = 
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, color=216
      xis_q_div_plfit = (xis_q / plfit_1) 
      s_set=findgen(25)
      s_nought = 3.90
      gamma    = 1.90
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, linestyle=1, color=216
      xis_q_div_plfit = (xis_q / plfit_1) 
   endif
   
   
   readcol, "k_output_UNI22_2pnt02z2pnt20_10log.dat", $
            s_log, s_2pnt02, xis_std, delta_xis, DD_2pnt02, DR, RR, $
            xis_LS_2pnt02, xis_HAM, ratio
   print, 'k_output_UNI22_2pnt02z2pnt20_10log.dat'
   print
   
   poisson_2pnt02 = (1.+xis_LS_2pnt02) * (sqrt(2./DD_2pnt02))
   oplot,   s_2pnt02, xis_LS_2pnt02, psym=4, color=116
   oplot,   s_2pnt02, xis_LS_2pnt02, linestyle=1,color=116
   errplot, s_2pnt02, $
            (xis_LS_2pnt02-poisson_2pnt02), (xis_LS_2pnt02+poisson_2pnt02), $
            thick=4.0, color=116
   
endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   2.25 < z < 2.90,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_2pnt25z2pnt90 = 'n' 
;read, choice_2pnt25z2pnt90, PROMPT=' - Plot the 2.25<z<2.90 (UNIFORMs)?  y/n  '
if choice_2pnt25z2pnt90 eq 'y' then begin
   
   readcol, "k_output_UNI22_2pnt20z2pnt90_10log.dat", $
            s_log, s_2pnt25, xis_std, delta_xis, DD_2pnt25, DR, RR, $
            xis_LS_2pnt25, xis_HAM, ratio
   print
   print, 'k_output_UNI22_2pnt25z2pnt90.dat read-in '
   print

   poisson_2pnt25 = (1.+xis_LS_2pnt25) * (sqrt(2./DD_2pnt25))
   
   oplot,   s_2pnt25, xis_LS_2pnt25, psym=4, color=240
   oplot,   s_2pnt25, xis_LS_2pnt25, linestyle=2,color=240
   errplot, s_2pnt25, $
            (xis_LS_2pnt25-poisson_2pnt25), (xis_LS_2pnt25+poisson_2pnt25), $
            thick=4.0, color=240
   xyouts, 5.0, 150.0, 'Uniform  2.25<z<2.90', $
           charsize=2.2, charthick=4.2, color=240

endif
print



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots 2QZ xi(s), if you want     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_2QZ = 'n'
read, choice_2QZ, PROMPT=' - Plot 2QZ?  y/n   '
if choice_2QZ eq 'y' then begin
   
   readcol, 'all_xir98.out', s_2QZ, xis_LS_2QZ, err_2QZ, /silent
   print
   print, '2QZ xi(s) read-in'
   print
   
   plotsym,8, 1.0*(talk/2d), /fill
   plotsym,8, 1.0, /fill
   oplot,   s_2QZ, xis_LS_2QZ, color= 160, thick=5*talk, linestyle=1
   oplot,   s_2QZ, xis_LS_2QZ, color= 160, psym=8
   errplot, s_2QZ, (xis_LS_2QZ-err_2QZ), (xis_LS_2QZ+err_2QZ), $
            color=160, linestyle=1, thick=4.0*talk
;   errfill, s_2QZ, xis_LS_2QZ, err_2QZ, color=64
;   xyouts, 5.0, 150.0, '2QZ  0.3<z<2.2',  charsize=2.2, charthick=6.2, color=160
;;   xyouts, 15.0, 16.0, '2QZ  ',  charsize=2.2, charthick=6.2, color=160  ;; if y_max =500
   xyouts, 15.0, 6.0, '2QZ  ',  charsize=2.2, charthick=6.2, color=160
;   xyouts, 5.0, 55.0, 'Croom et al. (2005)',  charsize=2.2,
;   charthick=6.2, color=160
   plotsym, 8, 1.25, /fill
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
   
;   plotsym,8, 1.0*(talk/2d) ;, /fill
   plotsym,8, 1.0 ;, /fill
   oplot,   s_2SLAQ_QSO, xis_LS_2SLAQ_QSO, color= 64, thick=5*talk, linestyle=2
   oplot,   s_2SLAQ_QSO, xis_LS_2SLAQ_QSO, color= 64, psym=8
   errplot, s_2SLAQ_QSO, $
            (xis_LS_2SLAQ_QSO-err_2SLAQ_QSO), (xis_LS_2SLAQ_QSO+err_2SLAQ_QSO), $
            thick=4.0*talk, color=64, linestyle=2
;   errfill, s_2SLAQ_QSO, xis_LS_2SLAQ_QSO, err_2SLAQ_QSO, color=64
;   xyouts, 5.0, 150.0, '2SLAQ+2QZ QSOs',  charsize=2.2, charthick=4.2, color=64

;;   xyouts, 15.0, 4.0, '2SLAQ + 2QZ',  charsize=2.2, charthick=6.2, color=64 ;; if y_max=500
   xyouts, 15.0, 2.0, '2SLAQ + 2QZ',  charsize=2.2, charthick=6.2, color=64 ;; if y_max=500

;   xyouts, 5.0, 55.0, 'da Angela et al. (2008)',  charsize=2.2,
;   charthick=4.2, color=64
   plotsym,8, 1.25 ;, /fill
   legend, [''], psym=8, box=0, position=[10.,3.3], color=64, thick=6


endif
print



choice_DR5_overplot = 'n'
read, choice_DR5_overplot, PROMPT='Overplot SDSS DR5 UNI22s again??'
if choice_DR5_overplot eq 'y' then begin
   readcol, 'k_output_UNI22.dat', $
            s_log, s, xis_std, delta_xis, DD, DR, RR, xis_LS, xis_HAM, ratio 
   xis_q = xis_LS               ; just setting the xi_Q(s) to the xi_LS
   poisson = (1.+xis_q) * (sqrt(2./DD)) 
   plotsym,0, 1.25*(talk/2d), /fill                               ;for UNI22
   oplot, s, xis_q, psym=8, thick=4*talk, color=0        ;also psym=4 is nice.
;   oplot, s, xis_q, linestyle=0, thick=4*talk, color=0
;;   errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=0
   errplot, s, (xis_q-jack), (xis_q+jack), thick=4.0, color=0
endif
print






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots xi(s), log-linearly for values around zero... MIDDLE PANEL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

print 
print, 'ADDING PANEL FOR VALUES OF xi(s) near-zero, +/-0.05, linearly'
readcol, 'k_output_UNI22.dat', $
         s_log, s, xis_std, delta_xis, DD, DR, RR, xis_LS, xis_HAM, ratio, /silent
;        OP_20080508 has UNIFORM 0.30 < z < 2.20
print
print, 'SDSS Quasar xi(s) read-in, k_output_UNI22'
print

xis_q = xis_LS                       ; just setting the xi_Q(s) to the xi_LS
poisson = (1.+xis_q) * (sqrt(2./DD)) ;

;p = [0.24, 0.20, 0.58, 0.48] ;; for INSERT PANEL, pdfs
p = [0.28, 0.20, 0.58, 0.48] ;; for INSERT PANEL, eps

loadct, 0
;polyfill, [p[0],p[0],p[2],p[2],p[0]], $
;          [p[1],p[3],p[3],p[1],p[1]], $
;          COLOR=255, /NORMAL

loadct, 6
plot, s, xis_q, /xlog, $
;      position=[0.22,0.25, 0.98, 0.38], $  ; IF MIDDLE PANEL
       position=[0.19,0.15, 0.98, 0.28], $  ; IF LOWER  PANEL
;       position=p, $  ; IF INSERT PANEL
      xrange=[0.5, 300], yrange=[-0.04, 0.04], $ ; IF LOWER PANEL
;      xrange=[50, 300], yrange=[-0.04, 0.04], $ ; IF INSERT PANEL
      /noerase, $
      psym=4, $
      color=0, $
      xthick=4, ythick=4, thick=4, $
      xstyle=1, ystyle=1, $
      xtitle=' s / h!E-1!N Mpc', $
      /nodata, $
      xcharsize=2.6, ycharsize=1.2, charthick=4.2


zero_line = fltarr(3000)
s_300 = findgen(3000)/10.
oplot, s_300, zero_line, linestyle=2


plotsym,0, 1.2, /fill  ;for UNI22
oplot, s, xis_q, psym=8, color=0    ;color=128        ;128, green
;errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=0
errplot, s, (xis_q-jack), (xis_q+jack), thick=4.0, color=0
print


;plotsym,0, 0.75, /fill
plotsym,0, 0.5, /fill  ;for UNI22
;oplot, s, xis_q, psym=8, color=0    ;color=128        ;128, green
;errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=0
;errplot, s, (xis_q-jack), (xis_q+jack), thick=4.0, color=0
device, /close
set_plot, 'X'




end
