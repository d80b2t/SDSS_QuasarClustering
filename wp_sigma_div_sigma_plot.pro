;+
; NAME:
;       wp_sigma_div_sigma_plot.pro
;
; PURPOSE:
;       To plot the calculated correlation functions for SDSS DR5
;       quasars. This program is primarily for wp(sigma). 
;
; CALLING SEQUENCE:
;       .run wp_sigma_div_sigma_plot.pro
;
; MODIFICATION HISTORY:
;       Version 1.00  NPR    20th November 2007
;-




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;    wp(sigma),   the usual, log-log plot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


loadct, 6  ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='wp_sigma_div_sigma_DR5_quasars_temp.eps', $
        xsize=8.5, ysize=8.0, /inches, /color, $
        /encapsulated, $
        xoffset=0.3, yoffset=0.2
!p.multi=[0,1,2]
;!p.multi=0

x_range_min=0.12
x_range_max=250.
;y_range_min=0.00101
y_range_min=0.0010
y_range_max=9999.

readcol, 'OP/OP_20080508/K_wp_output_UNI22.dat', $
         sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
         bin_DD_sigma, bin_DR_sigma, $
         Xi_sigma_HAM, Xi_sigma_LS

readcol, 'jackknife/wp_sigma/K_wp_output_UNI22_jackknife_errors.dat', $
         i_bin, j_bin, COV_ii, jack

wpsigma_div_sigma = Xi_sigma_LS / sigma
jack_div_sig = jack/sigma

plot, sigma, wpsigma_div_sigma, $
      /xlog, /ylog, $
      position=[0.25, 0.32, 0.98, 0.98],$  ;; for pdfs
;      position=[0.22, 0.12, 0.98, 0.98],$
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $    
      psym=4, $
      xstyle=1, ystyle=1, $
      xthick=4.2, ythick=4.2, thick=4.2, $
      ;xtitle=' !7r!3 / h!E-1!N Mpc', $
      ytitle=' w!Ip!N(!3r!Ip!N) / !3r!Ip!N ', $
      xcharsize=2.2, ycharsize=2.2, charthick=4.2, $
;      xtickformat='(i3)', $
      xtickformat='(a1)', $
      ytickformat='(f8.3)', $
;      ytickformat='(f7.2)', $
      /nodata, $
      color=0


choice_SDSS_QSOs = 'y'
;read, choice_SDSS_QSOs, PROMPT=' - Plot SDSS QSOs 0.30<z<2.20 (UNIFORMs)? y/n  '
if (choice_SDSS_QSOs eq 'y') then begin
   
   wp_sigma_q = Xi_sigma_LS     ; just setting the xi_Q(s) to the xi_LS
   DD = bin_DD_sigma
   poisson = (1.+wp_sigma_q) * (sqrt(2./DD)) 
   plotsym,0,1.25, /fill
   
   oplot, sigma, wpsigma_div_sigma, psym=8, color=0
   ;oplot, sigma, wpsigma_div_sigma, linestyle=0, color=0
   errplot, sigma, $
            (wpsigma_div_sigma-jack_div_sig), (wpsigma_div_sigma+jack_div_sig), $
            thick=4.0, color=0, linestyle=0

   legend, [''], psym=8, box=0, position=[5.5,4000.]
   xyouts, 8, 2000, 'SDSS DR5Q (uni)', size=2.2, charthick=6.2, color=0
;   xyouts, 8, 550, '0.3 < z < 2.2', size=2.2, charthick=6.2, color=0
  
   legend, [''], psym=8, box=0, position=[5.5,125.]
   xyouts, 8, 62.5, '!7p!3!Icut!N = 63 h!E-1!N Mpc', size=2.2, charthick=4.2, color=0
;   xyouts, 8, 500., 'x30!7q!3, !7p!3!Icut!N=63', size=2.2, charthick=4.2, color=0
;   xyouts, 8, 62.5, 'x30!7q!3, !7p!3!Icut!N=63', size=2.2, charthick=4.2, color=0

endif




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; 
;; wp(sigma)    SINGLE  POWER-LAW  FIT   from   wp(sigma)/sigma
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
choice_plfit = 'n'
read, choice_plfit, PROMPT=' --- Plot PL Fits 0.30<z<2.20 (UNIFORMs)? y/n  '
if (choice_plfit eq 'y') then begin
   s_set = (findgen(1300)/10.)

   ;s_nought = 80.0              ;5.85
   ;gamma    = 1.390             ; 1.575
   ;plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
   ;oplot, s_set, plfit_1, color=0, thick=4.0
   ;plfit_1 =  (sigma/s_nought)^(-1.0* gamma)
   ;wp_sigma_q_div_plfit = wp_sigma_q / plfit_1
   
   r_nought = 2.85              ;5.85
   gam_r    = 2.71             ; 1.575
   A_min    = 2.20
   plfit_1 = ((r_nought/s_set)^ gam_r) * A_min
   w = where(s_set ge 0.15) 
   ;oplot, s_set,    plfit_1,    color=0, thick=1.0, linestyle=1
   ;oplot, s_set[w], plfit_1[w], color=0, thick=1.0, linestyle=1

   r_nought = 5.45              ;5.85
   gam_r    = 1.90             ; 1.575
   A_min    = 3.38
   plfit_1 = ((r_nought/s_set)^ gam_r) * A_min
   w = where(s_set ge 2.0) 
   oplot, s_set,    plfit_1,    color=0, thick=1.0, linestyle=2
   ;oplot, s_set[w], plfit_1[w], color=0, thick=6.0, linestyle=2


   r_nought = 7.70              ;5.85
   gam_r    = 2.20             ; 1.575
   A_min    = 2.77
   plfit_1 = ((r_nought/s_set)^ gam_r) * A_min
   w = where(s_set ge 2.0) 
   ;oplot, s_set,    plfit_1,    color=0, thick=1.0, linestyle=2
   ;oplot, s_set[w], plfit_1[w], color=0, thick=6.0, linestyle=2


   r_nought = 8.75              ;5.85
   gam_r    = 2.40             ; 1.575
   A_min    = 2.51
   plfit_1 = ((r_nought/s_set)^ gam_r) * A_min
;   w = where(s_set ge 3.50) 
   w = where(s_set ge 4.00) 
   ;oplot, s_set,    plfit_1,    color=0, thick=1.0, linestyle=3
   oplot, s_set[w], plfit_1[w], color=0, thick=4.0, linestyle=0

;   s_set=findgen(25)
;   s_nought = 5.90
;   gamma    = 1.180
;   plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
;   oplot, s_set, plfit_1, color=0, thick=4.0, linestyle=1
   

   legend, [''], box=0, position=[3.0,240.], linestyle=2, thick=4
   legend, [''], box=0, position=[3.0,120.], linestyle=0, thick=4
   xyouts, 8,  140, 'r!I0!N=5.45 h!E-1!NMpc, !7c!3=1.90', $
           size=1.6, charthick=6.2, color=0
   xyouts, 8,  60, 'r!I0!N=8.75 h!E-1!NMpc, !7c!3=2.40', $
           size=1.6, charthick=6.2, color=0

   ;; wp_sigma_q_div_plfit = (wp_sigma_q / plfit_1) 
   ;; NOTE THESE POWER-LAW FITS ARE FROM THE xi(s) RESULTS AND NOT
   ;; THE wp(sigma) FITTING WITH THE GAMMA FUNCS. IN s0_gamma_from_xi_s_new
endif




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; 
;; wp(sigma) SDSS DR5 UNI22, pi_max cut comparisons...
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
choice_UNI22_comparisons = 'n'
read, choice_UNI22_comparisons, PROMPT=' - Plot the UNI22 pi_max comparisons?? y/n  '
if choice_UNI22_comparisons eq 'y' then begin

   readcol, 'jackknife/wp_sigma/K_wp_output_UNI22_jackknife_errors.dat', $
         i_bin, j_bin, COV_ii, jack

   readcol, 'OP/OP_20080120/K_wp_output_20080120_0pnt30z2pnt90.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS
;;   **** has x20 rnds and pi_cut=39 ****
   print, 'SDSS Quasar wp(sigma) read-in, K_wp_output_20080120_0pnt30z2pnt90'
   print
   
   wpsigma_div_sigma = Xi_sigma_LS / sigma
   jack_div_sig = jack/sigma

   plotsym, 0, 0.75, /fill
   oplot, sigma, wpsigma_div_sigma, psym=8, color=64
   oplot, sigma, wpsigma_div_sigma, linestyle=1, color=64, thick=6
   errplot, sigma, $
            (wpsigma_div_sigma-jack_div_sig), (wpsigma_div_sigma+jack_div_sig), $
            thick=4.0, color=64, linestyle=1
;   xyouts, 8, 176, 'x20!7q!3, !7p!3!Icut!N=40', size=2.2, charthick=4.2, color=64
   xyouts, 8, 176, '!7p!3!Icut!N = 40 h!E-1!N Mpc', size=2.2, charthick=4.2, color=64
   legend, [''], box=0, position=[3.,352.], color=64, linestyle=1, thick=6

   

   readcol, 'OP/OP_20080508/K_wp_output_UNI22_picut18.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS
;;   **** has x30 rnds and pi_cut=25 ****    
   print, 'SDSS Quasar wp(sigma) read-in, K_wp_output_UNI22_picut18.dat'
   print

   wpsigma_div_sigma = Xi_sigma_LS / sigma
   plotsym,0,0.75, /fill
   oplot, sigma, wpsigma_div_sigma, psym=8, color=128
   oplot, sigma, wpsigma_div_sigma, linestyle=2, color=128, thick=6
   errplot, sigma, $
            (wpsigma_div_sigma-jack_div_sig), (wpsigma_div_sigma+jack_div_sig), $
            thick=4.0, color=128, linestyle=2
;   xyouts, 8, 500, 'x30!7q!3, !7p!3!Icut!N=25', size=2.2, charthick=4.2, color=128
   xyouts, 8, 500, '!7p!3!Icut!N = 25 h!E-1!N Mpc', size=2.2, charthick=4.2, color=128
   legend, [''], box=0, position=[3.,1000.], color=128, linestyle=2, thick=6

   
   readcol, 'OP/OP_20080508/K_wp_output_UNI22_picut21.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS
;;   **** has x30 rnds and pi_cut=100 ****    
   print, 'SDSS Quasar wp(sigma) read-in, K_wp_output_UNI22_picut21.dat'
   print

   wpsigma_div_sigma = Xi_sigma_LS / sigma
   plotsym,0,0.75, /fill
   oplot, sigma, wpsigma_div_sigma, psym=8, color=192
   oplot, sigma, wpsigma_div_sigma, linestyle=3, color=192, thick=6
   errplot, sigma, $
            (wpsigma_div_sigma-jack_div_sig), (wpsigma_div_sigma+jack_div_sig), $
            thick=4.0, color=192, linestyle=3
 ;  xyouts, 8, 22, 'x30!7q!3, !7p!3!Icut!N=100', size=2.2, charthick=4.2, color=192
   xyouts, 8, 22, '!7p!3!Icut!N =100 h!E-1!N Mpc', size=2.2, charthick=4.2, color=192
   legend, [''], box=0, position=[3.,44.1], color=192, linestyle=3, thick=6
endif












;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;   plots SDSS DR5 Quasasrs,   z>2.9   if you want
;;                                      From Shen et al., 2007
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_Shen07 = 'n'
;read, choice_Shen07, PROMPT=' - Plot SDSS z>2.9 QSOs? (Shen07) y/n   '
if choice_Shen07 eq 'y' then begin
   
   readcol, 'Shen/Shen07_wp_rp.dat', $
            rp_Shen07, DD_Shen07, RR_Shen07, DR_Shen07, $
            wp_div_rp_Shen07, wp_div_rp_Shen07_err 
   print, 'SDSS z>2.9 wp(sigma) from Shen et al. (2007) read-in'
   print
 
   wp_Shen07     =  wp_div_rp_Shen07     * rp_Shen07
   wp_err_Shen07 =  wp_div_rp_Shen07_err * rp_Shen07 
   err           =  wp_div_rp_Shen07_err 

;  PLOTSYM, PSYM,[ PSIZE, /FILL, THICK=, COLOR=]
;  PSYM 0 - circle; 1 - downward arrow 2 - upward arrow; 3 - Five-pointed star
;     4 - triangle; 5 - upside down triangle;  6 - left pointing arrow
;     7 - right pointing arrow;  8 - square
  
   plotsym,0,1.0, thick=4.0
   ;plotsym,8,1.0
   
   oplot,   rp_Shen07, wp_div_rp_Shen07, color= 64, psym=8, linestyle=0
   errplot, rp_Shen07, (wp_div_rp_Shen07 - err),  (wp_div_rp_Shen07 + err), $
            thick=4.0, color=64, linestyle=0
   
   plotsym,0,1.2, thick=4.0
;   legend, [''], psym=8, box=0, position=[22.,350.], color=64, thick=4.0
;   xyouts, 8, 200, '       z > 2.9', size=2.2, charthick=6.2, color=64
   legend, [''], psym=8, box=0, position=[22.,140.], color=64, thick=4.0
   xyouts, 8, 80, '       z > 2.9', size=2.2, charthick=6.2, color=64  
   ;; when plotted with the Xray points/labels
endif


loadct, 1 ; for 100=light blue, 200 = dark blue
loadct, 6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;   plots SDSS DR5 Quasasrs with XRAY detections   0.3<z<2.2
;;                                      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_Xray = 'n'
;read, choice_Xray, PROMPT=' - Plot SDSS z>2.9 QSOs? (Xray) y/n   '
if choice_Xray eq 'y' then begin
   
   readcol, 'OP/UNI22_Xray/K_wp_output_UNI22_RASS_Xray_20080724.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS
   print, 'SDSS 0.3<z<2.2 wp(sigma) from the RASS-DR5Q detections read-in'
   print
   readcol, 'jackknife/wp_sigma/K_wp_output_UNI22_jackknife_errors.dat', $
         i_bin, j_bin, COV_ii, jack
   
   wp_div_rp_Xray = Xi_sigma_LS / sigma
   err = jack
   
   w = where(sigma lt 130)
   ;wp_div_rp_Xray[w] = wp_div_rp_Xray[w] /10.
   sigma = sigma[w]
   wp_div_rp_Xray = wp_div_rp_Xray[w]
   err = err[w]
   
   oplot,   sigma, wp_div_rp_Xray, color=200, psym=4, linestyle=0, thick=12.0
   errplot, sigma, (wp_div_rp_Xray - err),  (wp_div_rp_Xray + err), $
            thick=4.0, color=200, linestyle=0
   ; blue diamonds

   plotsym,0,1.2, thick=4.0
   legend, [''], psym=4, box=0, position=[5.5,1100.], color=138, thick=14.0
   xyouts, 8, 550, 'DR5Q-RASS (AC)', size=2.2, charthick=6.2, color=138


   readcol, 'OP/UNI22_Xray/K_wp_output_UNI22_RASS_Xray_20080903.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma
   print, 'SDSS 0.3<z<2.2 wp(sigma) from the RASS-DR5Q detections read-in'
   print
   readcol, 'jackknife/wp_sigma/K_wp_output_UNI22_jackknife_errors.dat', $
         i_bin, j_bin, COV_ii, jack
   
   wp_div_rp_Xray = Xi_sigma_LS / sigma
   err = jack
   
   w = where(sigma lt 130)
   ;wp_div_rp_Xray[w] = wp_div_rp_Xray[w] /10.
   sigma = sigma[w]
   wp_div_rp_Xray = wp_div_rp_Xray[w]
   err = err[w]
   
   oplot,   sigma, wp_div_rp_Xray, $
            color=48, psym=4, linestyle=0, thick=4.0, symsize=2.0
   errplot, sigma, (wp_div_rp_Xray - err),  (wp_div_rp_Xray + err), $
            thick=4.0, color=48, linestyle=0
   ; blue diamonds

   plotsym,0,1.2, thick=4.0
   legend, [''], psym=4, box=0, position=[5.5,350.], color=48, thick=4.0, symsize=2.0
   xyouts, 8, 150, 'DR5Q-RASS (XC)', size=2.2, charthick=6.2, color=48



endif



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;
;;   plots SDSS DR5 Quasasrs,   divided by E(B-V) reddening
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
loadct, 6
choice_UNI22_reddening = 'n'
;read, choice_UNI22_reddening,  PROMPT=' - Plot the UNI22 with E(B-V)?   y/n  '
if  choice_UNI22_reddening eq 'y' then begin

   readcol, 'jackknife/wp_sigma/K_wp_output_UNI22_jackknife_errors.dat', $
         i_bin, j_bin, COV_ii, jack
;   w = where(i_bin gt 1, N)
   jack2 = jack * (2.)  ;;since half the DDs went into E(B-V) measurements
  
   readcol, "OP/OP_UNI22_EBV/K_wp_output_UNI22_EBVle0pnt0217.dat", $
            sigma_EBVle0pnt02, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS_EBVle0pnt02
   print, 'OP/OP_UNI22_EBV/K_wp_output_UNI22_EBVle0pnt0217.dat read-in '
   print
   wpsigma_div_sigma =  (Xi_sigma_LS_EBVle0pnt02 / sigma_EBVle0pnt02)
   jack_div_sigma    =   jack2 / sigma_EBVle0pnt02
   
   plotsym, 4, 1.5
   oplot, sigma_EBVle0pnt02, wpsigma_div_sigma, psym=8, color=138
   errplot, sigma_EBVle0pnt02, $
            (wpsigma_div_sigma-jack_div_sig), (wpsigma_div_sigma+jack_div_sig), $
            thick=4.0, color=138, linestyle=0

   xyouts, 8, 500, 'E(B-V)!9l!30.02', size=2.2, charthick=6.2, color=138
   legend, [''], psym=8, box=0, position=[5.5,1000.], color=138

   readcol, "OP/OP_UNI22_EBV/K_wp_output_UNI22_EBVgt0pnt0217.dat", $
            sigma_EBVgt0pnt02, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS_EBVgt0pnt02
   print, 'OP/OP_UNI22_EBV/K_wp_output_UNI22_EBVgt0pnt0217.dat read-in '
   print
   wpsigma_div_sigma =  (Xi_sigma_LS_EBVgt0pnt02 / sigma_EBVgt0pnt02)
   jack_div_sigma    =   jack2 / sigma_EBVgt0pnt02
   
   plotsym, 4, 1.5, /fill
   oplot, sigma_EBVgt0pnt02, wpsigma_div_sigma, psym=8, color=48
   errplot, sigma_EBVgt0pnt02, $
            (wpsigma_div_sigma-jack_div_sig), (wpsigma_div_sigma+jack_div_sig), $
            thick=4.0, color=48, linestyle=0

   xyouts, 8, 125, 'E(B-V)>0.02', size=2.2, charthick=6.2, color=48
   legend, [''], psym=8, box=0, position=[5.5,250.], color=48

;;  red <= E(B-V)=0.2 

endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;
;;   plots SDSS DR5 Quasasrs,   with FIBRE CORRECTIONS!!!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
loadct, 6
choice_UNI22_wFibre = 'n'
;read, choice_UNI22_wFibre,  PROMPT=' - Plot the UNI22 w/Fibre Corrections?  y/n  '
if  choice_UNI22_wFibre eq 'y' then begin
  
   readcol, "OP/OP_UNI22_wFibre/K_wp_output_UNI22_wFibre.dat", $
            sigma_wFibre, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS_wFibre
   print, 'OP/OP_UNI22_wFibre/K_wp_output_UNI22_wFibre.dat read-in ', n_elements( sigma_wFibre)
   print
   readcol, 'jackknife/wp_sigma/K_wp_output_UNI22_jackknife_errors_for_wFibre.dat', $
         i_bin, j_bin, COV_ii, jack
   print, 'jackknife/wp_sigma/K_wp_output_UNI22_jackknife_errors_for_wFibre.dat read-in'
   print, n_elements(jack)
   print

   wpsigma_div_sigma =  (Xi_sigma_LS_wFibre / sigma_wFibre)
   jack_div_sigma    =   jack / sigma_wFibre

   lower = abs(wpsigma_div_sigma-jack_div_sigma)
   higher =abs(wpsigma_div_sigma+jack_div_sigma)
   
   plotsym, 4, 1.5, /fill
   oplot, sigma_wFibre, wpsigma_div_sigma, psym=8, color=138
   errplot, sigma_wFibre, $
            (wpsigma_div_sigma-jack_div_sigma),  (wpsigma_div_sigma+jack_div_sig), $
;            lower, higher, $
            thick=4.0, color=138, linestyle=1
   errplot, sigma_wFibre, $
            lower, higher, $
            thick=4.0, color=138, linestyle=1


   xyouts, 8, 500, 'w/ Fibre Corr.', size=2.2, charthick=6.2, color=138
   legend, [''], psym=8, box=0, position=[5.5,1000.], color=138
endif







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;   plots SDSS DR5 Quasasrs,   0.70 < z < 1.40,   if you want
;;                                                 For e.g. DEEP2 comparison
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_0pnt70z1pnt40 = 'n' 
;read, choice_0pnt70z1pnt40, PROMPT=' - Plot the 0.70<z<1.40 (UNIFORMs)?  y/n  '
if choice_0pnt70z1pnt40 eq 'y' then begin
   
   readcol, "OP/OP_20080307/K_wp_output_20080307_0pnt70z1pnt40.dat", $
            sigma0pnt70, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS0pnt70
   print
   print, 'OP/OP_20080307/K_wp_output_20080307_0pnt70z1pnt40.dat read-in '
   print

   poisson_0pnt70 = (1.+Xi_LS_0pnt70) * (sqrt(2./DD_0pnt70))
   
   oplot,   sigma_0pnt70, Xi_LS_0pnt70, psym=4, color=240
   oplot,   sigma_0pnt70, Xi_LS_0pnt70, linestyle=2,color=240
   errplot, sigma_0pnt70, $
            (Xi_LS_0pnt70-poisson_0pnt70), (Xi_LS_0pnt70+poisson_0pnt70), $
            thick=4.0, color=240
   xyouts, 5.0, 150.0, 'Uniform  0.70<z<1.40', $
           charsize=2.2, charthick=4.2, color=240
   xyouts, 1.0, 400, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0
choice_plfit = 'n'
   read, choice_plfit, PROMPT=' --- Plot PL Fit 0.70<z<1.40 (UNIFORMs)? y/n  '
   if (choice_plfit eq 'y') then begin
      s_set=findgen(100)
;;      s_nought = 
;;      gamma    = 
;      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
;      oplot, s_set, plfit_1, thick=4.0, color=240
;      xis_q_div_plfit = (xis_q / plfit_1) 
;      s_set=findgen(25)
;;      s_nought = 
;;      gamma    = 
;      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
;      oplot, s_set, plfit_1, thick=4.0, linestyle=1, color=240
;      xis_q_div_plfit = (xis_q / plfit_1) 
   endif
endif



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;   plots 2SLAQ LRGs
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_2SLAQ_LRGs = 'n' 
;read, choice_2SLAQ_LRGs, PROMPT=' - Plot the  2SLAQ LRGs?  y/n  '
if choice_2SLAQ_LRGs eq 'y' then begin
   
;   readcol, "../jackknife_perl/K_output_filez/K_output_jack_perl_full_newcor_v2.dat", $
   readcol, "../jackknife_perl/K_output_filez/K_output_jack_perl_full_newcor_v2_ed.dat", $
            sigma_2SLAQ_LRGs, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS_2SLAQ_LRGs
   readcol, "../jackknife_perl/K_output_filez/wp_variances_errors_LS_ed.dat", $
            column1, column2, jack_2SLAQ_LRGs
   print
   print, 'READ-IN ../jackknife_perl/K_output_filez/K_output_jack_perl_full_newcor_v2.dat   '
   print
   
   poisson_2SLAQ_LRGs = (1.+Xi_sigma_LS_2SLAQ_LRGs) * $
                        (sqrt(2./bin_DD_sigma))
   
   oplot,   sigma_2SLAQ_LRGs, Xi_sigma_LS_2SLAQ_LRGs, psym=4, color=240
   oplot,   sigma_2SLAQ_LRGs, Xi_sigma_LS_2SLAQ_LRGs, linestyle=2,color=240
   errplot, sigma_2SLAQ_LRGs, $
            (Xi_sigma_LS_2SLAQ_LRGs-jack_2SLAQ_LRGs),$
            (Xi_sigma_LS_2SLAQ_LRGs+jack_2SLAQ_LRGs), $
             linestyle=1, thick=4.0, color=240
   errplot, sigma_2SLAQ_LRGs, $
            (Xi_sigma_LS_2SLAQ_LRGs-poisson_2SLAQ_LRGs), $
            (Xi_sigma_LS_2SLAQ_LRGs+poisson_2SLAQ_LRGs), $
             linestyle=2, thick=4.0, color=240
   xyouts, 5.0, 150.0, '2SLAQ LRGs <z>=0.55', $
           charsize=2.2, charthick=4.2, color=240
endif







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots xi(s), divided by the given power-law      LOWER PANEL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

readcol, 'OP/OP_20080508/K_wp_output_UNI22.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS

readcol, 'jackknife/wp_sigma/K_wp_output_UNI22_jackknife_errors.dat', $
         i_bin, j_bin, COV_ii, jack

Xi_sigma_LS_div_sigma  =  Xi_sigma_LS/sigma
jack_div_sig = jack/sigma

r_nought = 8.75                 ;5.85
gam_r    = 2.40                 ; 1.575
A_min    = 2.50
plfit_1 = ((r_nought/sigma)^ gam_r) * A_min

wp_sigma_q_div_plfit =  Xi_sigma_LS_div_sigma / plfit_1
           err_plus  =  (Xi_sigma_LS_div_sigma+jack_div_sig) / plfit_1
           err_minus  =  (Xi_sigma_LS_div_sigma-jack_div_sig) / plfit_1

plotsym,0,0.75
plot, sigma, wp_sigma_q_div_plfit, $
      /xlog, $
      position=[0.25,0.12, 0.98, 0.32], $
      xrange=[x_range_min, x_range_max], $
      yrange=[0.00, 2.00], $    
      xstyle=1, ystyle=1, $
      xthick=4.2, ythick=4.2, thick=4.2, $
      charthick=4.2, $
      xcharsize=2.2, ycharsize=1.4, $      
;      xtitle=' !7r!3 / h!E-1!N Mpc', $
      xtitle=' !3r!Ip!N / h!E-1!N Mpc', $
;      ytitle= 'w!Ip!N(!7r!3)/w!Ip,PL!N(!7r!3)', $
      ytitle= 'w!Ip!N(!3r!Ip!N)/w!Ip,PL!N(!3r!Ip!N)', $
      psym=8, color=0
      

zero_line = fltarr(3000)
s_set = findgen(3000)/10d
for i=0L, n_elements(zero_line)-1 do zero_line(i) = 1.00
w=where(s_set gt 4.0 and s_set lt 130) 
oplot, s_set[w], zero_line[w], linestyle=2


plotsym,0,0.75,/fill
w = where(sigma ge 1.5 and sigma le 150., N)
oplot, sigma[w], wp_sigma_q_div_plfit[w],  color=0
;oplot, sigma[w], wp_sigma_q_div_plfit[w], psym=8, color=0
oplot, sigma, wp_sigma_q_div_plfit, psym=8, color=0

errplot, sigma, err_plus,  err_minus, thick=4.0, color=0, linestyle=0
print
print
print


over_plot_ratio = 'y'
if over_plot_ratio eq 'y' then begin

   readcol, 'jackknife/wp_sigma/K_wp_output_UNI22_jackknife_errors.dat', $
;   readcol, 'jackknife/wp_sigma/K_wp_output_UNI22_jackknife_errors_for_wFibre.dat', $
            i_bin, j_bin, COV_ii, jack   

   if choice_UNI22_comparisons eq 'y' then begin
      readcol, 'OP/OP_20080120/K_wp_output_20080120_0pnt30z2pnt90.dat', $
               sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
               bin_DD_sigma, bin_DR_sigma, $
               Xi_sigma_HAM, Xi_sigma_LS
      Xi_sigma_LS_div_sigma  =  Xi_sigma_LS/sigma
      jack_div_sig = (jack)/sigma
      plfit_1 = ((r_nought/sigma)^ gam_r) * A_min
      wp_sigma_q_div_plfit =  Xi_sigma_LS_div_sigma / plfit_1
      err_plus  =  (Xi_sigma_LS_div_sigma+jack_div_sig) / plfit_1
      err_minus  =  (Xi_sigma_LS_div_sigma-jack_div_sig) / plfit_1
      
                                ;plotsym, 4, 1.2, /fill
      plotsym, 0, 0.75, /fill
      oplot, sigma, wp_sigma_q_div_plfit, psym=8, color=64
      errplot, sigma, (err_plus),  (err_minus), thick=4.0, color=64, linestyle=1

      
;   readcol, "OP/OP_UNI22_wFibre/K_wp_output_UNI22_wFibre.dat", $
      readcol, "OP/OP_20080508/K_wp_output_UNI22_picut18.dat", $
               sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
               bin_DD_sigma, bin_DR_sigma, $
               Xi_sigma_HAM, Xi_sigma_LS
      Xi_sigma_LS_div_sigma  =  Xi_sigma_LS/sigma
      jack_div_sig = (jack)/sigma
      plfit_1 = ((r_nought/sigma)^ gam_r) * A_min
      wp_sigma_q_div_plfit =  Xi_sigma_LS_div_sigma / plfit_1
      err_plus  =  (Xi_sigma_LS_div_sigma+jack_div_sig) / plfit_1
      err_minus  =  (Xi_sigma_LS_div_sigma-jack_div_sig) / plfit_1
      
                                ;plotsym, 4, 1.2, /fill
      plotsym, 0, 0.75, /fill
      oplot, sigma, wp_sigma_q_div_plfit, psym=8, color=128
      errplot, sigma, (err_plus),  (err_minus), thick=4.0, color=128, linestyle=1
      
      
; readcol, "OP/OP_UNI22_EBV/K_wp_output_UNI22_EBVgt0pnt0217.dat", $
      readcol, "OP/OP_20080508/K_wp_output_UNI22_picut21.dat", $
               sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
               bin_DD_sigma, bin_DR_sigma, $
               Xi_sigma_HAM, Xi_sigma_LS
      Xi_sigma_LS_div_sigma  =  Xi_sigma_LS/sigma
      jack_div_sig = (jack*2.)/sigma
      plfit_1 = ((r_nought/sigma)^ gam_r) * A_min
      wp_sigma_q_div_plfit =  Xi_sigma_LS_div_sigma / plfit_1
      err_plus  =  (Xi_sigma_LS_div_sigma+jack_div_sig) / plfit_1
      err_minus  =  (Xi_sigma_LS_div_sigma-jack_div_sig) / plfit_1
      
                                ;plotsym, 4, 1.5, /fill
      plotsym, 0, 0.75, /fill
      oplot, sigma, wp_sigma_q_div_plfit, psym=8, color=192
      errplot, sigma, (err_plus),  (err_minus), thick=4.0, color=192, linestyle=1
      endif
endif




!p.multi=0
device, /close
set_plot, 'X'




r_nought = 5.45                 ;5.85
gam_r    = 1.90                 ; 1.575
A_min    = 3.38

w = where(sigma gt 0.1) 
Xi_sigma_LS_div_sigma = Xi_sigma_LS_div_sigma[w]
sigma=sigma[w]
jack_div_sig =jack_div_sig[w]
plfit_1 = ((r_nought/sigma)^ gam_r) * A_min

top = (Xi_sigma_LS_div_sigma - plfit_1)^2
summer = top/(jack_div_sig^2)
chi_sq = total(summer)

print, Xi_sigma_LS_div_sigma
print, plfit_1
print, top
print, summer
print
print, chi_sq














close, /all

end
