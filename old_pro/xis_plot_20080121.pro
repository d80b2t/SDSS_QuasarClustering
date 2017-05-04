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
;    xi(s),   the usual, log-log plot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;readcol, 'kde_output_temp.dat', s, DD, DR
;readcol, 'xis_quasars.dat', s_log, s, xis_std, xis_ham,  xis_LS
;readcol, 'OP_20071102/kde_output_temp_20071102.dat', s, DD, DR, RR, xis_std, xis_ham, xis_LS
readcol, '2pt/k_output_temp.dat', s_log, s, xi_std, delta_xis, DD, DR, RR, xis_LS, xis_HAM, ratio
print
print, 'SDSS Quasar xi(s) read-in'
print

xis_q = xis_LS                       ; just setting the xi_Q(s) to the xi_LS
poisson = (1.+xis_q) * (sqrt(2./DD)) ; Poisson errors, da Angela et al. (2005).
; N_ratio_DR = 26.1725
; xis = (N_ratio_DR * (DD /DR)) - 1.


set_plot, 'ps'
device, filename='xis_DR5_quasars_temp.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0, /inches, /color
!p.multi=[0,1,3]

loadct, 6  ; black=0=255, red=63, green=127, blue=191

plot, s, xis_q, /xlog, /ylog, position=[0.22, 0.38, 0.98, 0.98],$
;      xrange=[0.1, 300], yrange=[-0.05, 0.05], $
      xrange=[0.5, 300], yrange=[0.001, 500], $
      psym=4, $
      xstyle=1, ystyle=1, $
      charsize=4.2, charthick=3.2, $
      ytitle=' !7n(!3s)', $
      xtickformat='(a1)', ytickformat='(f6.2)', color=0
oplot, s, xis_q, psym=4, color=128
errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=128

xyouts, 3.0, 25.0,  'Uniform DR5 Quasars', charsize=2.2, charthick=4.2, color=128
xyouts, 3.0, 12.5,  '0.3 < z < 2.9 ', charsize=2.2, charthick=4.2, color=128

;loadct, 13
;readcol, 'dat/K_output_wp_jack_perl_full_newcor_v2.dat', $
;         sigma_ref, blah1, xi, delta_xi, bin_DD_2SLAQ, bin_DR_2SLAQ, $
;         xi_2SLAQ_HAM, xi_2SLAQ_LS
;plot, sigma_ref, xi_2SLAQ_LS, /xlog, /ylog, $
;      xrange=[0.01, 1000], yrange=[0.01, 5000], $
;      xtitle=' sigma / h^-1 Mpc', ytitle=' w_p(sigma) / h^-1 Mpc', color=128 
;oplot, sigma_check, Xi_sigma_check, color=64





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots 2SLAQ LRG xi(s)     (if you want....)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
readcol, "../jackknife_perl/k_output_files/k_output_jack_perl_full_newcor_v2_ed.dat", blah, s_2SLAQ_LRG, xis_2SLAQ_LRG, delta_xi, blah5, blah6, $
         xis_2SLAQ_LRG_LS, xis_2SLAQ_LRG_HAM 
readcol, "../jackknife_perl/k_output_files/xis_variances_errors_LS_TRUE.dat", $
         s_jack, jackknife_2SLAQ_LRG
print
print, '2SLAQ LRG xi(s) read-in'
print, '2SLAQ LRG Jackknife file'
print


;xi_2SLAQ_LRG = xi_LS
jack_sq = sqrt(jackknife_2SLAQ_LRG)

;oplot, s_2SLAQ_LRG, xis_2SLAQ_LRG, color= 64
;errfill, s_jack, xis_2SLAQ_LRG, jack_sq, color=64
;xyouts, 3.0, 100.0, '2SLAQ LRGs (Ross et al. 2007)', $
;        charsize=2.2, charthick=4.2, color=64


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots 2SLAQ QSO xi(s)     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
readcol, "xi_s_all_complete_final_newbin.dat", s_2SLAQ_QSO, xis_LS_2SLAQ_QSO, $
         err_2SLAQ_QSO
print
print, '2SLAQ+2QZ QSO xi(s) read-in'
print

;xi_2SLAQ_QSO = xi_LS
;jack_sq = sqrt(jackknife)

oplot,   s_2SLAQ_QSO, xi_LS_2SLAQ_QSO, color= 64
errplot, s, (xis_LS_2SLAQ_QSO-err_2SLAQ_QSO), $
         (xis_q+poisson), thick=4.0, color=128
;errfill, s_2SLAQ_QSO, xi_LS_2SLAQ_QSO, err_2SLAQ_QSO, color=64
xyouts, 3.0, 100.0, '2SLAQ+2QZ QSOs',  charsize=2.2, charthick=4.2, color=64
xyouts, 3.0, 50.0, '2SLAQ+2QZ QSOs',  charsize=2.2, charthick=4.2, color=64




   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots simple power-law fit from Connelly et al. DR3 Quasar paper,
;   in prep. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

s_nought = 6.26
gamma    = 1.72

plfit_1 =  (s/s_nought)^(-1.0* gamma)
;oplot, s, plfit_1, color=0, thick=8.0
xis_q_div_plfit = (xis_q / plfit_1) 




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
; overplot the SDSS DR5 Quasar points over the 2SLAQ red errorbar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;oplot, s, xis_q, psym=4, color=128
;errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=128



;xyouts, 3.0, 100.0, '2SLAQ LRGs',         charsize=2.2, charthick=4.2, color=64
;xyouts, 3.0, 50.0,  'DR5 Quasars, z<2.5', charsize=2.2, charthick=4.2, color=128


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
; comparison Quasar xi(s) data from different `run'. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;readcol, 'OP_20071102/kde_output_20071102.dat', s, DD, DR, RR, xis_std, xis_ham, xis_LS
;readcol, 'OP_20071122/kde_output_20071122.dat', s, DD, DR, RR, xis_std, xis_ham, xis_LS
;
;xis_q_comp = xis_LS                       ;just setting the xi_Q(s) to the xi_LS
;poisson = (1.+xis_q_comp) * (sqrt(2./DD)) ;Poisson errors












;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots xi(s), log-linearly for values around zero... MIDDLE PANEL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

plot, s, xis_q, /xlog, position=[0.22,0.25, 0.98, 0.38], $
;      xrange=[0.1, 300], yrange=[-0.05, 0.05], $
      xrange=[0.5, 300], yrange=[-0.05, 0.05], $
      psym=4, color=0, $
      xstyle=1, ystyle=1, $
      charsize=2.2, charthick=2.2, $
;      xtitle=' s / h!E-1!N Mpc', $
      xtickformat='(a1)', $
      ytitle=' !7n(!3s)'
oplot, s, xis_q, psym=4, color=128 
errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=128




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots xi(s), divided by the given power-law      LOWER PANEL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
plot, s, xis_q_div_plfit, /xlog, position=[0.22,0.12, 0.98, 0.25], $
;      xrange=[0.1, 300], yrange=[0.00, 2.00], $
      xrange=[0.5, 300], yrange=[0.00, 2.00], $
      psym=5, color=0, $
      xstyle=1, ystyle=1, $
      xcharsize=4.2, ycharsize=2.2, charthick=2.2, $
      xtitle=' s / h!E-1!N Mpc', $
      ytitle= '!7n(!3s) / !7n!IPL!N(!3s)'
oplot, s, xis_q_div_plfit, color=190
oplot, s, xis_q_div_plfit, psym=5, color=190
device, /close
set_plot, 'X'







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots the DD, DR, RR counts as a sanity check (from nbc_kde_v1_13.pro)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

readcol, '2pt/k_output_temp.dat', s_log, s, xi_std, delta_xis, DD, DR, RR, xis_LS, xis_HAM, ratio
print
print, 'Read-in SDSS Quasar xi(s), again, for DDs, DRs, RRs;
print

s_check = s
bin_DD_plot = DD 
bin_DR_plot = DR
bin_RR_plot = RR

loadct, 25
set_plot, 'ps'
!p.multi=0
device, filename='DDs_DRs_check_temp.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0.5+(10-8), /inches, /color
plot, s_check, bin_DD_plot, /xlog, /ylog, $
      xrange=[1.0, 20000.0], yrange=[0.1, 2e11], xstyle=1, ystyle=1., $
      xtitle='s / h^-1 Mpc', ytitle=' No. of pairs', $
      xcharsize=1.8, ycharsize=2.2, charthick=4, $
      position=[0.17,0.15,0.98,0.98]
xyouts, 150.0, 256., 'bin_DD',charsize=2.2,charthick=3

oplot, s_check, bin_DR_plot, color = 64
xyouts, 150.0, 64., 'bin_DR',charsize=2.2,charthick=3, color=64
oplot, s_check, bin_RR_plot, color = 128
xyouts, 150.0, 16., 'bin_RR',charsize=2.2,charthick=3, color=128
;oplot, s_check, bin_QG_plot, color = 128, thick=5.
;xyouts, 50.0, 16., 'bin_QG',charsize=2.2,charthick=3, color=128
;oplot, s_check, bin_QR_plot, color = 256, thick=5.
;xyouts, 50.0, 4., 'bin_QR',charsize=2.2,charthick=3, color=256
device, /close
set_plot, 'X'


close, /all

end

