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

readcol, 'OP/OP_20080120/K_wp_output_20080120_0pnt30z2pnt90.dat', $
         sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
         bin_DD_sigma, bin_DR_sigma, $
         Xi_sigma_HAM, Xi_sigma_LS
;        OP_20080120 has UNIFORM 0.30 < z < 2.90
print
print, 'SDSS Quasar wp(sigma) read-in, K_wp_output_20080120_0pnt30z2pnt90'
print

wp_sigma_q = Xi_sigma_LS           ; just setting the xi_Q(s) to the xi_LS
DD = bin_DD_sigma
poisson = (1.+wp_sigma_q) * (sqrt(2./DD)) ; Poisson errors, da Angela et al. (2005).


loadct, 6  ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='wp_sigma_DR5_quasars_temp.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0, /inches, /color
!p.multi=[0,1,2]
;!p.multi=0

plot, sigma, wp_sigma_q, /xlog, /ylog, $
      position=[0.22, 0.32, 0.98, 0.98],$
      xrange=[0.1, 300], yrange=[0.05, 9000], $ ; bring down to 500 w/o V. PREL.
      psym=4, $
      xstyle=1, ystyle=1, $
      ytitle=' w!Ip!N(!7r!3)', $
      ;xtitle=' sigma / h!E-1!N Mpc', $
      xcharsize=4.2, ycharsize=2.2, charthick=2.2, $
      xtickformat='(a1)', $
      ytickformat='(f6.1)', $
      /nodata, $
      color=0


choice_SDSS_QSOs = 'n'
read, choice_SDSS_QSOs, PROMPT=' - Plot SDSS QSOs 0.30<z<2.90 (UNIFORMs)? y/n  '
if (choice_SDSS_QSOs eq 'y') then begin
   oplot, sigma, wp_sigma_q, psym=4, color=0
   oplot, sigma, wp_sigma_q, linestyle=0, color=0
   errplot, sigma, (wp_sigma_q-poisson), (wp_sigma_q+poisson), thick=4.0, color=0
   
   xyouts, 5.0,200.0, 'Uniform DR5 Quasars', charsize=2.2, charthick=5.2, color=0
   xyouts, 5.0, 80.0,  '0.3 < z < 2.9 ', charsize=2.2, charthick=5.2, color=0
   xyouts, 1.0, 4000, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0

   choice_plfit = 'n'
   read, choice_plfit, PROMPT=' --- Plot PL Fit 0.30<z<2.90 (UNIFORMs)? y/n  '
   if (choice_plfit eq 'y') then begin
      s_set=findgen(100)
      s_nought = 80.0   ;5.85
      gamma    = 1.390  ; 1.575
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, color=0, thick=4.0
      wp_sigma_q_div_plfit = (wp_sigma_q / plfit_1) 
      ;s_set=findgen(25)
      ;s_nought = 5.90
      ;gamma    = 1.180
      ;plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      ;oplot, s_set, plfit_1, color=0, thick=4.0, linestyle=1
      ;wp_sigma_q_div_plfit = (wp_sigma_q / plfit_1) 
      ; NOTE THESE POWER-LAW FITS ARE FROM THE xi(s) RESULTS AND NOT
      ; THE wp(sigma) FITTING WITH THE GAMMA FUNCS. IN s0_gamma_from_xi_s_new
   endif
endif












;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;   plots SDSS DR5 Quasasrs,   0.70 < z < 1.40,   if you want
;;                                                 For e.g. DEEP2 comparison
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_0pnt70z1pnt40 = 'n' 
read, choice_0pnt70z1pnt40, PROMPT=' - Plot the 0.70<z<1.40 (UNIFORMs)?  y/n  '
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
;      s_nought = 
;      gamma    = 
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, color=240
      xis_q_div_plfit = (xis_q / plfit_1) 
      s_set=findgen(25)
;      s_nought = 
;      gamma    = 
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, linestyle=1, color=240
      xis_q_div_plfit = (xis_q / plfit_1) 
   endif
endif








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots xi(s), divided by the given power-law      LOWER PANEL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
plot, sigma, wp_sigma_q_div_plfit, /xlog, position=[0.22,0.12, 0.98, 0.32], $
      xrange=[0.1, 300], yrange=[0.00, 2.00], $ ; bring down to 500 w/o V. PREL.
      psym=5, color=0, $
      xstyle=1, ystyle=1, $
      xcharsize=2.2, ycharsize=1.6, charthick=2.2, $
      xtitle=' !7r!3 / h!E-1!N Mpc', $
      ytitle= 'w!Ip!N(!7r!3) / w!Ip,PL(!7r!3)'
oplot, sigma, wp_sigma_q_div_plfit, color=190
oplot, sigma, wp_sigma_q_div_plfit, psym=5, color=190



device, /close
set_plot, 'X'

close, /all
end
