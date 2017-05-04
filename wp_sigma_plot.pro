;+
; NAME:
;       wp_sigma_plot_pro
;
; PURPOSE:
;       To plot the calculated correlation functions for SDSS DR5
;       quasars. This program is primarily for wp(sigma). 
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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;    wp(sigma),   the usual, log-log plot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


loadct, 6  ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='wp_sigma_DR5_quasars_temp.ps', $
        xsize=8.3, ysize=6.5, /inches, /color, $
        xoffset=0.1, yoffset=0.2
!p.multi=[0,1,2]
;!p.multi=0

x_range_min=0.12
x_range_max=250.
y_range_min=0.11
y_range_max=9000.

readcol, 'OP/OP_20080508/K_wp_output_UNI22.dat', $
         sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
         bin_DD_sigma, bin_DR_sigma, $
         Xi_sigma_HAM, Xi_sigma_LS

readcol, 'jackknife/K_wp_output_UNI22_jackknife_errors.dat', $
         i_bin, j_bin, COV_ii, jack

plot, sigma, Xi_sigma_LS, /xlog, /ylog, $
      position=[0.22, 0.32, 0.98, 0.98],$
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $    
      psym=4, $
      xstyle=1, ystyle=1, $
      xthick=4.2, ythick=4.2, thick=2.2, $
      ytitle=' w!Ip!N(!7r!3)', $
      ;xtitle=' sigma / h!E-1!N Mpc', $
      xcharsize=2.2, ycharsize=2.2, charthick=4.2, $
      xtickformat='(a1)', $
      ytickformat='(f6.1)', $
      /nodata, $
      color=0




choice_SDSS_QSOs = 'y'
;read, choice_SDSS_QSOs, PROMPT=' - Plot SDSS QSOs 0.30<z<2.20 (UNIFORMs)? y/n  '
if (choice_SDSS_QSOs eq 'y') then begin
   
   readcol, 'OP/OP_20080508/K_wp_output_UNI22.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS
;        OP_20080120 has UNIFORM 0.30 < z < 2.90
   print
   print, 'SDSS Quasar wp(sigma) read-in, K_wp_output_20080120_0pnt30z2pnt90'
   print
   
   wp_sigma_q = Xi_sigma_LS     ; just setting the xi_Q(s) to the xi_LS
   DD = bin_DD_sigma
   poisson = (1.+wp_sigma_q) * (sqrt(2./DD)) 
   plotsym,0,1.25, /fill
   oplot, sigma, wp_sigma_q, psym=8, color=0
   oplot, sigma, wp_sigma_q, linestyle=0, color=0
   errplot, sigma, (wp_sigma_q-jack),  (wp_sigma_q+jack), $
            thick=4.0, color=0, linestyle=0

   xyouts, 8, 2000, 'SDSS DR5Q (uni)', size=2.2, charthick=6.2, color=0
   xyouts, 8, 750, '0.3 < z < 2.2', size=2.2, charthick=6.2, color=0
   legend, [''], psym=8, box=0, position=[5.5,4000.]
;   xyouts, 8, 250., 'x30!7q!3, !7p!3!Icut!N=63', size=2.2, charthick=4.2, color=0
endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; 
;; wp(sigma)    SINGLE  POWER-LAW  FIT   from   wp(sigma)/sigma
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
choice_plfit = 'y'
;read, choice_plfit, PROMPT=' --- Plot PL Fit 0.30<z<2.90 (UNIFORMs)? y/n  '
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
   plfit_1 = (r_nought^gam_r) * (s_set^(1.- gam_r)) * A_min
   w = where(s_set ge 0.15) 
   ;oplot, s_set,    plfit_1,    color=0, thick=1.0, linestyle=1
   ;oplot, s_set[w], plfit_1[w], color=0, thick=1.0, linestyle=2

   r_nought = 2.85              ;5.85
   gam_r    = 2.71             ; 1.575
   A_min    = 2.20
   plfit_1 = (r_nought^gam_r) * (s_set^(1.- gam_r)) * A_min
   w = where(s_set ge 1.0) 
   ;oplot, s_set,    plfit_1,    color=0, thick=1.0, linestyle=1
   oplot, s_set[w], plfit_1[w], color=0, thick=1.0, linestyle=2


   r_nought = 6.70              ;5.85
   gam_r    = 1.81             ; 1.575
   A_min    = 3.67
   plfit_1 = (r_nought^gam_r) * (s_set^(1.- gam_r)) * A_min
   w = where(s_set ge 2.0) 
   ;oplot, s_set,    plfit_1,    color=0, thick=1.0, linestyle=2
   oplot, s_set[w], plfit_1[w], color=0, thick=1.0, linestyle=2

   r_nought = 8.30              ;5.85
   gam_r    = 2.22             ; 1.575
   A_min    = 2.74
   plfit_1 = (r_nought^gam_r) * (s_set^(1.- gam_r)) * A_min
   w = where(s_set ge 3.50) 
   ;oplot, s_set,    plfit_1,    color=0, thick=1.0, linestyle=2
   oplot, s_set[w], plfit_1[w], color=0, thick=4.0, linestyle=0

;   s_set=findgen(25)
;   s_nought = 5.90
;   gamma    = 1.180
;   plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
;   oplot, s_set, plfit_1, color=0, thick=4.0, linestyle=1
   
   ;; wp_sigma_q_div_plfit = (wp_sigma_q / plfit_1) 
   ;; NOTE THESE POWER-LAW FITS ARE FROM THE xi(s) RESULTS AND NOT
   ;; THE wp(sigma) FITTING WITH THE GAMMA FUNCS. IN s0_gamma_from_xi_s_new
endif





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; 
;; wp(sigma) SDSS DR5 UNI22, comparisons...
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
choice_UNI22_comparisons = 'n'
;read, choice_UNI22_comparisons, PROMPT=' - Plot the UNI22 pi_max comparisons?? y/n  '
if choice_UNI22_comparisons eq 'y' then begin
   
   readcol, 'OP/OP_20080120/K_wp_output_20080120_0pnt30z2pnt90.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS
;        OP_20080120 has UNIFORM 0.30 < z < 2.90
   print, 'SDSS Quasar wp(sigma) read-in, K_wp_output_20080120_0pnt30z2pnt90'
   print
   
   wp_sigma_q = Xi_sigma_LS     ; just setting the xi_Q(s) to the xi_LS
   DD = bin_DD_sigma
   poisson = (1.+wp_sigma_q) * (sqrt(2./DD)) 
   plotsym,0,0.75, /fill
   oplot, sigma, wp_sigma_q, psym=8, color=64
   oplot, sigma, wp_sigma_q, linestyle=1, color=64
   errplot, sigma, (wp_sigma_q-poisson),  (wp_sigma_q+poisson), $
            thick=4.0, color=64, linestyle=1
   xyouts, 0.5, 0.33, 'x20!7q!3, !7p!3!Icut!N=39', size=2.2, charthick=4.2, color=64
 
   

   readcol, '2pt/K_wp_output_UNI22_picut18.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS
;        OP_20080120 has UNIFORM 0.30 < z < 2.90
   print, 'SDSS Quasar wp(sigma) read-in, K_wp_output_UNI22_picut18.dat'
   print
   wp_sigma_q = Xi_sigma_LS     ; just setting the xi_Q(s) to the xi_LS
   DD = bin_DD_sigma
   poisson = (1.+wp_sigma_q) * (sqrt(2./DD)) 
   plotsym,0,0.75, /fill
   oplot, sigma, wp_sigma_q, psym=8, color=128
   oplot, sigma, wp_sigma_q, linestyle=2, color=128
   errplot, sigma, (wp_sigma_q-poisson),  (wp_sigma_q+poisson), $
            thick=4.0, color=128, linestyle=2
   xyouts, 0.5, 0.11, 'x30!7q!3, !7p!3!Icut!N=25', $
           size=2.2, charthick=4.2, color=128


 readcol, '2pt/K_wp_output_UNI22_picut21.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS
;        OP_20080120 has UNIFORM 0.30 < z < 2.90
   print, 'SDSS Quasar wp(sigma) read-in, K_wp_output_UNI22_picut21.dat'
   print
   wp_sigma_q = Xi_sigma_LS     ; just setting the xi_Q(s) to the xi_LS
   DD = bin_DD_sigma
   poisson = (1.+wp_sigma_q) * (sqrt(2./DD)) 
   plotsym,0,0.75, /fill
   oplot, sigma, wp_sigma_q, psym=8, color=192
   oplot, sigma, wp_sigma_q, linestyle=3, color=192
   errplot, sigma, (wp_sigma_q-poisson),  (wp_sigma_q+poisson), $
            thick=4.0, color=192, linestyle=3
   xyouts, 0.5, 1.0, 'x30!7q!3, !7p!3!Icut!N=100', $
           size=2.2, charthick=4.2, color=192
endif


choice_wpsigma_UNI22_NvsS = 'n'
;read, choice_wpsigma_UNI22_NvsS, PROMPT=' - Plot the UNI22 N vs. S comparisons?? y/n  '
if choice_wpsigma_UNI22_NvsS eq 'y' then begin
   
   readcol, 'OP/OP_20080508/K_wp_output_UNI22_N.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS
   print, 'READ-IN OP_20080508/K_wp_output_UNI22_N.dat'
   print
   
   wp_sigma_q = Xi_sigma_LS     ; just setting the xi_Q(s) to the xi_LS
   DD = bin_DD_sigma
   poisson = (1.+wp_sigma_q) * (sqrt(2./DD)) 
   plotsym,0,0.75, /fill
   oplot, sigma, wp_sigma_q, psym=8, color=64
   oplot, sigma, wp_sigma_q, linestyle=1, color=64
   errplot, sigma, (wp_sigma_q-poisson),  (wp_sigma_q+poisson), $
            thick=4.0, color=64, linestyle=1
   xyouts, 0.5, 0.33, 'NGC', size=2.2, charthick=4.2, color=64

   readcol, 'OP/OP_20080508/K_wp_output_UNI22_S.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS
   print, 'READ-IN OP_20080508/K_wp_output_UNI22_S.dat'
   print
   
   wp_sigma_q = Xi_sigma_LS     ; just setting the xi_Q(s) to the xi_LS
   DD = bin_DD_sigma
   poisson = (1.+wp_sigma_q) * (sqrt(2./DD)) 
   plotsym,0,0.75, /fill
   oplot, sigma, wp_sigma_q, psym=8, color=192
   oplot, sigma, wp_sigma_q, linestyle=1, color=192
   errplot, sigma, (wp_sigma_q-poisson),  (wp_sigma_q+poisson), $
            thick=4.0, color=192, linestyle=1
   xyouts, 0.5, 0.33, 'NGC', size=2.2, charthick=4.2, color=192



endif






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   0.30 < z < 0.68,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
choice_0pnt30z0pnt68 = 'n'
;read, choice_0pnt30z0pnt68, PROMPT=' - Plot the 0.30<z<0.68 (UNIFORMs)?  y/n  '
if choice_0pnt30z0pnt68 eq 'y' then begin
   readcol, 'OP/OP_20080121/K_wp_output_20080121_0pnt30z0pnt68.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS
   print
   print, 'SDSS Quasar wp(sigma) read-in, K_wp_output_20080120_0pnt30z2pnt90'
   print
   
   wp_sigma_q = Xi_sigma_LS     ; just setting the xi_Q(s) to the xi_LS
   DD = bin_DD_sigma
   poisson = (1.+wp_sigma_q) * (sqrt(2./DD)) 
   plotsym,0,0.75, /fill
   oplot, sigma, wp_sigma_q, psym=8, color=0
   oplot, sigma, wp_sigma_q, linestyle=0, color=0
   errplot, sigma, (wp_sigma_q-poisson),  (wp_sigma_q+poisson), $
            thick=4.0, color=0, linestyle=0
   xyouts, 10, 4000, 'x20!7q!3, !7p!3_cut=39??', size=2.2, charthick=4.2, color=0
   

   readcol, 'OP/OP_20080121/K_wp_output_UNI22_0pnt30z0pnt68.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS
   print
   print, 'SDSS Quasar wp(sigma) read-in, K_wp_output_20080120_0pnt30z2pnt90'
   print
   
   wp_sigma_q = Xi_sigma_LS     ; just setting the xi_Q(s) to the xi_LS
   DD = bin_DD_sigma
   poisson = (1.+wp_sigma_q) * (sqrt(2./DD)) 
   plotsym,0,0.75, /fill
   oplot, sigma, wp_sigma_q, psym=8, color=100
   oplot, sigma, wp_sigma_q, linestyle=1, color=100
   errplot, sigma, (wp_sigma_q-poisson),  (wp_sigma_q+poisson), $
            thick=4.0, color=100, linestyle=0
   xyouts, 10, 1000, 'x30!7q!3, !7p!3_cut=63', size=2.2, charthick=4.2, color=100
   
   
   
   readcol, 'OP/OP_20080121/K_wp_output_0pnt30z0pnt68_rho20picut20.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS
;        OP_20080120 has UNIFORM 0.30 < z < 2.90
   print
   print, 'SDSS Quasar wp(sigma) read-in, K_wp_output_20080120_0pnt30z2pnt90'
   print

   wp_sigma_q = Xi_sigma_LS     ; just setting the xi_Q(s) to the xi_LS
   DD = bin_DD_sigma
   poisson = (1.+wp_sigma_q) * (sqrt(2./DD)) 
   plotsym,8,0.75, /fill
   oplot, sigma, wp_sigma_q, psym=8, color=200
   oplot, sigma, wp_sigma_q, linestyle=2, color=200
   errplot, sigma, (wp_sigma_q-poisson),  (wp_sigma_q+poisson), $
            thick=4.0, color=200, linestyle=0
   xyouts, 10, 250, 'x20!7q!3, !7p!3_cut=63', size=2.2, charthick=4.2, color=200
  

   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;   plots SDSS DR5 Quasasrs,    0.30<z<0.68  pi_cut=19
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
   
   readcol, 'OP/OP_20080121/K_wp_output_0pnt30z0pnt68_rho20picut19.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS
   print
   print, 'SDSS Quasar wp(sigma) read-in, K_wp_output_20080120_0pnt30z2pnt90'
   print
   
   wp_sigma_q = Xi_sigma_LS     ; just setting the xi_Q(s) to the xi_LS
   poisson = (1.+wp_sigma_q) * (sqrt(2./DD)) 
   plotsym,8,0.75, /fill
   oplot, sigma, wp_sigma_q, psym=8, color=50
   oplot, sigma, wp_sigma_q, linestyle=3, color=50
   errplot, sigma, (wp_sigma_q-poisson),  (wp_sigma_q+poisson), $
            thick=4.0, color=50, linestyle=3
   xyouts, 10, 62.5, 'x20!7q!3, !7p!3_cut=40', size=2.2, charthick=4.2, color=50
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

;  PLOTSYM, PSYM,[ PSIZE, /FILL, THICK=, COLOR=]
;  PSYM 0 - circle; 1 - downward arrow 2 - upward arrow; 3 - Five-pointed star
;     4 - triangle; 5 - upside down triangle;  6 - left pointing arrow
;     7 - right pointing arrow;  8 - square
  
   plotsym,0,1.0
   ;plotsym,8,1.0
   oplot,   rp_Shen07, wp_Shen07, color= 64, psym=8, linestyle=0
   errplot, rp_Shen07, (wp_Shen07-wp_err_Shen07),  (wp_Shen07+wp_err_Shen07), $
            thick=4.0, color=64, linestyle=0

   
;   xyouts, 5.0, 1000., 'SDSS z>2.9 Quasars',  charsize=2.2, charthick=4.2, color=64
;   xyouts, 8, 2000, 'SDSS DR5Q (uni)', size=2.2, charthick=6.2, color=64
   xyouts, 8, 250, '       z > 2.9', size=2.2, charthick=6.2, color=64
   legend, [''], psym=8, box=0, position=[22.,500.], color=64
endif



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;
;;   plots SDSS DR5 Quasasrs,   0.30<z<2.90   if you want
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_SDSS_QSOs = 'n'
;read, choice_SDSS_QSOs, PROMPT=' - Plot 0.30<z<2.90 pl-fits from xi(s)? y/n  '
if (choice_SDSS_QSOs eq 'y') then begin

  
;   xyouts, 2.0,1000.0, 'Uniform DR5 Quasars', charsize=2.2, charthick=5.2, color=0
;   xyouts, 2.0, 600.0,  '0.3 < z < 2.9 ', charsize=2.2, charthick=5.2, color=0
   xyouts, 0.5,  0.5, 'Uniform DR5 Quasars', charsize=2.2, charthick=5.2, color=0
   xyouts, 0.5, 0.25,  '0.3 < z < 2.9 ', charsize=2.2, charthick=5.2, color=0
   xyouts, 0.5, 4000, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0

   choice_plfit = 'n'
   read, choice_plfit, PROMPT=' --- Plot PL Fit 0.30<z<2.90 (UNIFORMs)? y/n  '
   if (choice_plfit eq 'y') then begin
      s_set=findgen(100)
      s_nought = 80.0   ;5.85
      gamma    = 1.390  ; 1.575
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, color=0, thick=4.0
      plfit_1 =  (sigma/s_nought)^(-1.0* gamma)
      wp_sigma_q_div_plfit = wp_sigma_q / plfit_1
      ;s_set=findgen(25)
      ;s_nought = 5.90
      ;gamma    = 1.180
      ;plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      ;oplot, s_set, plfit_1, color=0, thick=4.0, linestyle=1
      ;wp_sigma_q_div_plfit = (wp_sigma_q / plfit_1) 
      ; NOTE THESE POWER-LAW FITS ARE FROM THE xi(s) RESULTS AND NOT
      ; THE wp(sigma) FITTING WITH THE GAMMA FUNCS. IN s0_gamma_from_xi_s_new
   endif

   plotsym,0,1.5,/fill
   oplot, sigma, wp_sigma_q, psym=8, color=0
   oplot, sigma, wp_sigma_q, linestyle=0, color=0
   errplot, sigma, (wp_sigma_q-poisson), (wp_sigma_q+poisson), thick=4.0, color=0
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
   
   oplot,   s_0pnt70, xis_LS_0pnt70, psym=4, color=240
   oplot,   s_0pnt70, xis_LS_0pnt70, linestyle=2,color=240
   errplot, s_0pnt70, $
            (xis_LS_0pnt70-poisson_0pnt70), (xis_LS_0pnt70+poisson_0pnt70), $
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

s_set=findgen(100)
s_nought = 80.0                 ;5.85
gamma    = 1.390                ; 1.575
plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
;oplot, s_set, plfit_1, color=0, thick=4.0
plfit_1 =  (sigma/s_nought)^(-1.0* gamma)
wp_sigma_q_div_plfit = wp_sigma_q / plfit_1

plotsym,0,0.75
plot, sigma, wp_sigma_q_div_plfit, $
      /xlog, $
      position=[0.22,0.12, 0.98, 0.32], $
      xrange=[x_range_min, x_range_max], $
      yrange=[0.00, 2.00], $    
      xstyle=1, ystyle=1, $
      xthick=4.2, ythick=4.2, thick=4.2, $
      charthick=4.2, $
      xcharsize=2.2, ycharsize=1.4, $      
      xtitle=' !7r!3 / h!E-1!N Mpc', $
      ytitle= 'w!Ip!N(!7r!3)/w!Ip,PL!N(!7r!3)', $
      psym=8, color=0
      

zero_line = fltarr(300)
for i=0L, n_elements(zero_line)-1 do zero_line(i) = 1.00
;oplot, sigma, zero_line, linestyle=0
;oplot, zero_line, linestyle=0
;plots, 0, 1, /data, linestyle=0, color=0
;plots, 300, 1, /data, linestyle=0, color=0

plotsym,0,0.75,/fill
w = where(sigma ge 1.0 and sigma le 100., N)
;for i=0L, n_elements(sigma)-1 do begin
;   if sigma[i] ge 1.0 and sigma[i] le 100. then begin
;      ;oplot, sigma, wp_sigma_q_div_plfit,         color=190
;      ;oplot, sigma, wp_sigma_q_div_plfit, psym=8, color=190
;      oplot, sigma[i], wp_sigma_q_div_plfit[i],         color=0
;      oplot, sigma[i], wp_sigma_q_div_plfit[i], psym=8, color=0
;   endif
;endfor
oplot, sigma[w], wp_sigma_q_div_plfit[w], color=0
oplot, sigma[w], wp_sigma_q_div_plfit[w], psym=8, color=0
!p.multi=0
device, /close
set_plot, 'X'


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



close, /all

end
