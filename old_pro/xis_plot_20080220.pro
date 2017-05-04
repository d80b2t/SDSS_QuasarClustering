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
readcol, 'OP/OP_20080120/k_output_20080120.dat', s_log, s, xi_std, delta_xis, DD, DR, RR, xis_LS, xis_HAM, ratio
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
      xrange=[0.5, 300], yrange=[0.001, 999], $ ; bring down to 500 w/o V. PREL.
      psym=4, $
      xstyle=1, ystyle=1, $
      charsize=4.2, charthick=3.2, $
      ytitle=' !7n(!3s)', $
      xtickformat='(a1)', ytickformat='(f6.2)', color=0
oplot, s, xis_q, psym=4, color=128
oplot, s, xis_q, linestyle=0, color=128
errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=128

;xyouts, 5.0, 20.0, 'Uniform DR5 Quasars', charsize=2.2, charthick=5.2, color=128
;xyouts, 5.0,  8.0,  '0.3 < z < 2.9 ', charsize=2.2, charthick=5.2, color=128

xyouts, 1.0, 400, '!!!! V. PRELIMINARY RESULT !!!!', $
        charsize=2.2, charthick=6.2, color=0




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots 2SLAQ LRG xi(s)     if you want....
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;read, choice_2SLAQ_LRG, PROMPT=' --- Plot 2SLAQ LRGs? y/n   '
choice_2SLAQ_LRG = 'n'
if (choice_2SLAQ_LRG eq 'y') then begin
   readcol, "../jackknife_perl/k_output_files/k_output_jack_perl_full_newcor_v2_ed.dat", blah, s_2SLAQ_LRG, xis_2SLAQ_LRG, delta_xi, blah5, blah6, $
            xis_2SLAQ_LRG_LS, xis_2SLAQ_LRG_HAM 
   readcol, "../jackknife_perl/k_output_files/xis_variances_errors_LS_TRUE.dat", $
            s_jack, jackknife_2SLAQ_LRG
   print
   print, '2SLAQ LRG xi(s) read-in'
   print, '2SLAQ LRG Jackknife file'
   print
   
   xi_2SLAQ_LRG = xi_LS
   jack_sq = sqrt(jackknife_2SLAQ_LRG)
   oplot, s_2SLAQ_LRG, xis_2SLAQ_LRG, color= 64
   errfill, s_jack, xis_2SLAQ_LRG, jack_sq, color=64
   xyouts, 3.0, 100.0, '2SLAQ LRGs (Ross et al. 2007)', $
           charsize=2.2, charthick=4.2, color=64
   
endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots 2SLAQ QSO xi(s), if you want     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_2SLAQ_LRG = 'n'
read, choice_2SLAQ_LRG, PROMPT=' --- Plot 2SLAQ QSOs? y/n   '
if choice_2SLAQ_LRG eq 'y' then begin
   
   readcol, "xi_s_all_complete_final_newbin.dat", s_2SLAQ_QSO, $
            xis_LS_2SLAQ_QSO, err_2SLAQ_QSO
   print
   print, '2SLAQ+2QZ QSO xi(s) read-in'
   print
   
   oplot,   s_2SLAQ_QSO, xis_LS_2SLAQ_QSO, color= 64
   errplot, s_2SLAQ_QSO, $
            (xis_LS_2SLAQ_QSO-err_2SLAQ_QSO), (xis_LS_2SLAQ_QSO+err_2SLAQ_QSO), $
            thick=4.0, color=64
;   errfill, s_2SLAQ_QSO, xis_LS_2SLAQ_QSO, err_2SLAQ_QSO, color=64
   xyouts, 5.0, 150.0, '2SLAQ+2QZ QSOs',  charsize=2.2, charthick=4.2, color=64
   xyouts, 5.0, 55.0, 'da Angela et al. (2008)',  charsize=2.2, charthick=4.2, color=64

endif
   



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   0.30 < z < 0.68,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_0pnt30z0pnt68 = 'n'
read, choice_0pnt30z0pnt68, PROMPT=' --- Plot the 0.30<z<0.68 (UNIFORMs)?  y/n  '
if choice_0pnt30z0pnt68 eq 'y' then begin
   
   readcol, "OP/OP_20080121/k_output_20080121_0pnt30z0pnt068.dat", $
            log_s, s_0pnt30, xi_std, delta_xis, DD_0pnt30, DR, RR, $
            xis_LS_0pnt30, xis_HAM, ratio
   print
   print, 'OP/OP_20080121/k_output_20080121_0pnt30z0pnt068.dat read-in '
   print

   poisson_0pnt30 = (1.+xis_LS_0pnt30) * (sqrt(2./DD_0pnt30))
   
   oplot,   s_0pnt30, xis_LS_0pnt30, psym=4, color= 32
   oplot,   s_0pnt30, xis_LS_0pnt30, linestyle=1,color= 32
   errplot, s_0pnt30, $
            (xis_LS_0pnt30-poisson_0pnt30), (xis_LS_0pnt30-poisson_0pnt30), $
            thick=4.0, color=32
;   errfill, s_2SLAQ_QSO, xis_LS_2SLAQ_QSO, err_2SLAQ_QSO, color=64
;   xyouts, 5.0, 150.0, 'UNIs, 0.30<z<0.68', $
;           charsize=2.2, charthick=4.2, color=32

endif




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   2.25 < z < 2.90,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_2pnt25z2pnt90 = 'n' 
read, choice_2pnt25z2pnt90, PROMPT=' --- Plot the 2.25<z<2.90 (UNIFORMs)?  y/n  '
if choice_2pnt25z2pnt90 eq 'y' then begin
   
   readcol, '2pt/k_output_temp.dat', $
;   readcol, "OP/OP_20080121/k_output_20080121_0pnt30z0pnt068.dat", $
            s_log, s_2pnt25, xi_std, delta_xis, DD_2pnt25, DR, RR, $
            xis_LS_2pnt25, xis_HAM, ratio
   print
   print, '2pt/k_output_temp.dat readin'
;   print, 'OP/OP_20080121/k_output_20080121_0pnt30z0pnt068.dat read-in '
   print

   poisson_2pnt35 = (1.+xis_LS_2pnt25) * (sqrt(2./DD_2pnt25))
   
   oplot,   s_2pnt25, xis_LS_2pnt25, psym=4, color=224
   oplot,   s_2pnt25, xis_LS_2pnt25, linestyle=2,color=224
   errplot, s_pnt3, $
            (xis_LS_pnt3-poisson_pnt3), (xis_LS_pnt3-poisson_pnt3), $
            thick=4.0, color=224
;   errfill, s_2SLAQ_QSO, xis_LS_2SLAQ_QSO, err_2SLAQ_QSO, color=64
;   xyouts, 5.0, 300.0, 'UNIs, 2.24<z<2.90', $
;           charsize=2.2, charthick=4.2, color=224
endif




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   2.25 < z < 2.90,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_0pnt68z0pnt92 = 'n' 
read, choice_0pnt68z0pnt92, PROMPT=' --- Plot the 0.68<z<0.92 (UNIFORMs)?  y/n  '
if choice_0pnt68z0pnt92 eq 'y' then begin
   
   readcol, "OP/OP_20080122b/k_output_20080122_0pnt68z0pnt92.dat", $
            s_log, s_0pnt68, xi_std, delta_xis, DD_2pnt25, DR, RR, $
            xis_LS_2pnt25, xis_HAM, ratio
   print
   print, 'OP/OP_20080122b/k_output_20080122_0pnt68z0pnt92.dat read-in '
   print

   poisson_0pnt68 = (1.+xis_LS_2pnt25) * (sqrt(2./DD_2pnt25))
   
   oplot,   s_2pnt25, xis_LS_2pnt25, psym=4, color=224
   oplot,   s_2pnt25, xis_LS_2pnt25, linestyle=2,color=224
   errplot, s_pnt3, $
            (xis_LS_pnt3-poisson_pnt3), (xis_LS_pnt3-poisson_pnt3), $
            thick=4.0, color=64
;   errfill, s_2SLAQ_QSO, xis_LS_2SLAQ_QSO, err_2SLAQ_QSO, color=64
;   xyouts, 5.0, 300.0, 'UNIs, 2.24<z<2.90', $
;           charsize=2.2, charthick=4.2, color=224
endif











   


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







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
; xi(s) Legend(s)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;legend,['2SLAQ+2QZ','Uniform','Homogen.'], box=0, charsize=1.8, charthick=4.2, $
;       line=[1,0,2], $
;       position=[30.,10], $
;       color=[64,128,192]
;/usr/common/rsi/lib/general/LibAstro> aqua pro/legend.pro


legend,['2.29<z<2.90','Uniform','0.30<z<0.68'], $
       box=0, charsize=1.8, charthick=4.2, $
       line=[2,0,1], $
       position=[10,100], $
       color=[224,128,32]





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
;   plots simple power-law fit from Connelly et al. DR3 Quasar paper,
;   in prep. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

s_nought = 6.26
gamma    = 1.72

plfit_1 =  (s/s_nought)^(-1.0* gamma)
;oplot, s, plfit_1, color=0, thick=8.0
xis_q_div_plfit = (xis_q / plfit_1) 



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

