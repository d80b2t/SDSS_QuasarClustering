;+
; NAME:
;       wp_sigma_plot
;
; PURPOSE:
;       To plot the calculated correlation functions for SDSS DR5
;       quasars. This program is primarily for wp(sigma). 
;
; EXPLANATION:
;
; CALLING SEQUENCE:
;       .run wp_sigma_plot
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
;    xi(s),   the usual, log-log plot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;readcol, 'kde_output_temp.dat', s, DD, DR
;readcol, 'xis_quasars.dat', s_log, s, xis_std, xis_ham,  xis_LS
readcol, 'OP_20071122/Kde_wp_sigma_output_temp.dat', $
         sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
         bin_DD_sigma, bin_DR_sigma, $
         Xi_sigma_HAM, Xi_sigma_LS

wp_sigma_q= Xi_sigma_LS                        ; just setting the xi_Q(s) to the xi_LS
;poisson = (1.+xis_q) * (sqrt(2./DD))  ; Poisson errors, da Angela et al. (2005). 


set_plot, 'ps'
device, filename='wp_sigma_DR5_quasars.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0, /inches, /color
!p.multi=[0,1,2]


loadct, 6  ; black=0=255, red=63, green=127, blue=191
;N_ratio_DR = 26.1725
;xis = (N_ratio_DR * (DD /DR)) - 1.


plot, sigma, wp_sigma_q, /xlog, /ylog, position=[0.22, 0.38, 0.98, 0.98],$
      xrange=[0.1, 300], yrange=[0.005, 9000], $
      psym=4, $
      xstyle=1, ystyle=1, $
      charsize=2.2, charthick=3.2, $
      ytitle=' w!Sp!N(!7r!3)', $
      xtickformat='(a1)', ytickformat='(f6.2)'
oplot, sigma, wp_sigma_q, psym=4, color=128
;errplot, sigma, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=128





;loadct, 13
;readcol, 'dat/K_output_wp_jack_perl_full_newcor_v2.dat', $
;         sigma_ref, blah1, xi, delta_xi, bin_DD_2SLAQ, bin_DR_2SLAQ, $
;         xi_2SLAQ_HAM, xi_2SLAQ_LS
;plot, sigma_ref, xi_2SLAQ_LS, /xlog, /ylog, $
;      xrange=[0.01, 1000], yrange=[0.01, 5000], $
;      xtitle=' sigma / h^-1 Mpc', ytitle=' w_p(sigma) / h^-1 Mpc', color=128 
;oplot, sigma_check, Xi_sigma_check, color=64





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots 2SLAQ LRG xi(s)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

readcol, '../jackknife_perl/K_output_filez/K_output_jack_perl_full_newcor_v2.dat', $  
;readcol, '../jackknife_perl/K_output_filez/K_output_jack_perl_full_newcor_v2_ed.dat', $, 
         rp, rptwo, w, error, blah5, blah6, w_HAM, w_LS
readcol, '../jackknife_perl/K_output_filez/wp_variances_errors_LS_ed.dat', $
         jack

wp_2SLAQ = w_LS
jack_sq = sqrt(jack)

oplot, rp, wp_2SLAQ, psym=4, color= 64
;errfill, rp, wp_2SLAQ, jack_sq, color=64

   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots simple power-law fit from Connelly et al. DR3 Quasar paper,
;   in prep. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

;s_nought = 6.26
;gamma    = 1.72

;plfit_1 =  (s/s_nought)^(-1.0* gamma)
;oplot, s, plfit_1, color=0, thick=8.0
;xis_q_div_plfit = (xis_q / plfit_1) 
;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
; o-plot Quasar points over the 2SLAQ red errorbar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;oplot, s, xis_q, psym=4, color=128
;errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=128




xyouts, 3.0, 100.0, '2SLAQ LRGs',         charsize=2.2, charthick=4.2, color=64
xyouts, 3.0, 50.0,  'DR5 Quasars, z<2.5', charsize=2.2, charthick=4.2, color=128



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
; comparison Quasar xi(s) data from different `run'. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;readcol, 'OP_20071122/kde_output_temp_20071102.dat', s, DD, DR, RR, xis_std, xis_ham, xis_LS


;xis_q_comp = xis_LS                        ;just setting the xi_Q(s) to the xi_LS
;poisson = (1.+xis_q_comp) * (sqrt(2./DD))  ;Poisson errors










;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots xi(s), log-linearly for values around zero...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

;plot, s, xis_q, /xlog, position=[0.22,0.25, 0.98, 0.38], $
;      xrange=[0.1, 300], yrange=[-0.05, 0.05], $
;      psym=4, color=0, $
;      xstyle=1, ystyle=1, $
;      charsize=2.2, charthick=2.2, $
;;      xtitle=' s / h!E-1!N Mpc', $
;      xtickformat='(a1)', $
;      ytitle=' !7n(!3s)'
;oplot, s, xis_q, psym=4, color=128 
;errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=128




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots xi(s), divided by the given power-law
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;plot, s, xis_q_div_plfit, /xlog, position=[0.22,0.12, 0.98, 0.25], $
;plot, s, xis_q_div_plfit, /xlog, position=[0.22,0.12, 0.98, 0.25], $
;      xrange=[0.1, 300], yrange=[0.00, 2.00], $
;      psym=5, color=0, $
;      xstyle=1, ystyle=1, $
;      xcharsize=4.2, ycharsize=2.2, charthick=2.2, $
;      xtitle=' s / h!E-1!N Mpc', $
;      ytitle= '!7n(!3s) / !7n!IPL!N(!3s)'
;oplot, s, xis_q_div_plfit, color=190
;oplot, s, xis_q_div_plfit, psym=5, color=190









device, /close
set_plot, 'X'



end

