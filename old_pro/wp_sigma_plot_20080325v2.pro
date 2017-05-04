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
device, filename='wp_sigma_DR5_quasars_temp.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0, /inches, /color
!p.multi=[0,1,2]
;!p.multi=0

x_range_min=0.25
x_range_max=300.
y_range_min=0.05
y_range_max=9000.

plot, sigma, wp_sigma_q, /xlog, /ylog, $
      position=[0.22, 0.32, 0.98, 0.98],$
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $    
      psym=4, $
      xstyle=1, ystyle=1, $
      ytitle=' w!Ip!N(!7r!3)', $
      ;xtitle=' sigma / h!E-1!N Mpc', $
      xcharsize=4.2, ycharsize=2.2, charthick=2.2, $
      xtickformat='(a1)', $
      ytickformat='(f6.1)', $
      /nodata, $
      color=0


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





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;   plots SDSS DR5 Quasasrs,   z>2.9   if you want
;;                                      From Shen et al., 2007
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_Shen07 = 'n'
read, choice_Shen07, PROMPT=' - Plot SDSS z>2.9 QSOs? (Shen07) y/n   '
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
  
   plotsym,8,1.0
   oplot,   rp_Shen07, wp_Shen07, color= 64, psym=8, linestyle=0
   errplot, rp_Shen07, (wp_Shen07-wp_err_Shen07),  (wp_Shen07+wp_err_Shen07), $
            thick=4.0, color=64, linestyle=0

   xyouts, 5.0, 1000., 'SDSS z>2.9 Quasars',  charsize=2.2, charthick=4.2, color=64
endif



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;
;;   plots SDSS DR5 Quasasrs,   0.30<z<2.90   if you want
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_SDSS_QSOs = 'n'
read, choice_SDSS_QSOs, PROMPT=' - Plot SDSS QSOs 0.30<z<2.90 (UNIFORMs)? y/n  '
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
endif

   plotsym,0,1.5,/fill
   oplot, sigma, wp_sigma_q, psym=8, color=0
   oplot, sigma, wp_sigma_q, linestyle=0, color=0
   errplot, sigma, (wp_sigma_q-poisson), (wp_sigma_q+poisson), thick=4.0, color=0




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;   plots SDSS DR5 Quasasrs,   0.70 < z < 1.40,   if you want
;;                                                 For e.g. DEEP2 comparison
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_0pnt70z1pnt40 = 'n' 
print
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








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots xi(s), divided by the given power-law      LOWER PANEL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
plot, sigma, wp_sigma_q_div_plfit, $
      /xlog, $
      position=[0.22,0.12, 0.98, 0.32], $
      xrange=[x_range_min, x_range_max], $
      yrange=[0.00, 2.00], $    
      xstyle=1, ystyle=1, $
      charthick=2.2, $
      xcharsize=2.2, $      
      xtitle=' !7r!3 / h!E-1!N Mpc', $
      ycharsize=1.6, $
      ytitle= 'w!Ip!N(!7r!3)/w!Ip,PL!N(!7r!3)', $
      psym=5, color=0
      

zero_line = fltarr(300)
for i=0L, n_elements(zero_line)-1 do zero_line(i) = 1.00
;oplot, sigma, zero_line, linestyle=0
;oplot, zero_line, linestyle=0
;plots, 0, 1, /data, linestyle=0, color=0
;plots, 300, 1, /data, linestyle=0, color=0

plotsym,0,1.5,/fill
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


device, /close
set_plot, 'X'

close, /all
end
