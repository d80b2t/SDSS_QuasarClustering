;+
; NAME:
;       xis_plot_pro
;
; PURPOSE:
;       To plot the calculated correlation functions for SDSS DR5
;       quasars. This program is primarily for xi(s). 
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
;    xi(s)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 



;readcol, 'kde_output_temp.dat', s, DD, DR
;readcol, 'xis_quasars.dat', s_log, s, xis_std, xis_ham,  xis_LS
readcol, 'OP_20071102/kde_output_temp_20071102.dat', s, DD, DR, RR, xis_std, xis_ham, xis_LS

set_plot, 'ps'
device, filename='xis_DR5_quasars.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0.5+(10-8.5), /inches, /color
!p.multi=[0,1,2]

loadct, 6  ; black=0=255, red=63, green=127, blue=191
;N_ratio_DR = 26.1725
;xis = (N_ratio_DR * (DD /DR)) - 1.
xis_q = xis_LS

poisson = (1.+xis_q) * (sqrt(2./DD)) 

plot, s, xis_q, /xlog, /ylog, position=[0.1, 0.2, 0.98, 0.95 ],$
      xrange=[0.03, 800], yrange=[0.005, 400], psym=4, $
      xstyle=1, ystyle=1, ytitle=' !7n(!3s)', xtickformat='(a1)'
errfill, s, xis_q, poisson, color=128
oplot, s, xis_q, psym=4, color=0
errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=0

xyouts, 6.0, 50.0, 'DR5 Quasars, z<2.5', charsize=2.2, color=128


;loadct, 13
;readcol, 'dat/K_output_wp_jack_perl_full_newcor_v2.dat', $
;         sigma_ref, blah1, xi, delta_xi, bin_DD_2SLAQ, bin_DR_2SLAQ, $
;         xi_2SLAQ_HAM, xi_2SLAQ_LS
;plot, sigma_ref, xi_2SLAQ_LS, /xlog, /ylog, $
;      xrange=[0.01, 1000], yrange=[0.01, 5000], $
;      xtitle=' sigma / h^-1 Mpc', ytitle=' w_p(sigma) / h^-1 Mpc', color=128 
;oplot, sigma_check, Xi_sigma_check, color=64



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots simple power-law fit from Connelly et al. DR3 Quasar paper,
;   in prep. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

s_nought = 6.26
gamma    = 1.72

;for s= 0.01, 100, 0.01 do plfit_1 = (s/s_nought)^(-1.0* gamma)

plfit_1 =  (s/s_nought)^(-1.0* gamma)

oplot, s, plfit_1, color=0 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots 2SLAQ LRG xi(s)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
readcol, "../jackknife_perl/k_output_files/k_output_jack_perl_full_newcor_v2_ed.dat", blah, r, xi, delta_xi, blah5, blah6, xi_LS, xi_HAM 

oplot, r, xi_LS, color= 64
xyouts, 10.0, 100.0, '2SLAQ LRGs', charsize=2.2, color=64






plot, s, xis_q, /xlog, position=[0.10,0.07, 0.98, 0.20], $
      xrange=[0.03, 800], yrange=[-0.05, 0.05], psym=4, color=0, $
      xstyle=1, ystyle=1, xtitle=' s / h!E-1!N Mpc', ytitle=' !7n(!3s)'
oplot, s, xis_q, psym=4, color=128 
errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=128

;plot, s, (xis_q/plfit_1), /xlog, position=[0.10,0.07, 0.98, 0.20], $
;      xrange=[0.03, 800], yrange=[0.00, +2.00], psym=4, color=0, $
;      xstyle=1, ystyle=1, xtitle=' s / h!E-1!N Mpc', ytitle=' !7n(!3s)/powerlaw'
;oplot, s, xis_q



device, /close
set_plot, 'X'



end

