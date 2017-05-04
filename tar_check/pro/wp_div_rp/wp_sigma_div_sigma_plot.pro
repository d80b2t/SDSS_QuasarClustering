;;+
;; NAME:
;;       wp_sigma_div_sigma_plot.pro
;;
;; PURPOSE:
;;       To plot the calculated correlation functions for SDSS DR5
;;       quasars. This program is primarily for wp(sigma). 
;;
;; CALLING SEQUENCE:
;;       .run wp_sigma_div_sigma_plot.pro
;;
;; MODIFICATION HISTORY:
;;       Version 1.00  NPR    20th November 2007
;;-

print
print

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;
;;    wp(rp) / rp    log-log  plot
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


loadct, 6  
;; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='wp_sigma_div_sigma_DR5_quasars_temp.eps', $
        xsize=8.5, ysize=8.0, /inches, /color, $
        /encapsulated, $
        xoffset=0.3, yoffset=0.2
!p.multi=[0,1,2]


x_range_min=0.12
x_range_max=250.
;y_range_min=0.00101
y_range_min=0.0010
y_range_max=9999.

readcol, 'K_wp_output_UNI22.dat', $
         sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
         bin_DD_sigma, bin_DR_sigma, $
         Xi_sigma_HAM, Xi_sigma_LS

readcol, 'K_wp_output_UNI22_jackknife_errors.dat', $
         i_bin, j_bin, COV_ii, jack

wpsigma_div_sigma = Xi_sigma_LS / sigma
jack_div_sig = jack/sigma

plot, sigma, wpsigma_div_sigma, $
      /xlog, /ylog, $
      position=[0.25, 0.32, 0.98, 0.98],$  
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

print
print
choice_SDSS_QSOs = 'y'
;read, choice_SDSS_QSOs, PROMPT=' - Plot SDSS QSOs 0.30<z<2.20 (UNIFORMs)? y/n  '
if (choice_SDSS_QSOs eq 'y') then begin
   
   wp_sigma_q = Xi_sigma_LS     ;; just setting the xi_Q(s) to the xi_LS
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
   xyouts, 8, 550, '0.3 < z < 2.2', size=2.2, charthick=6.2, color=0
  
;   legend, [''], psym=8, box=0, position=[5.5,125.]
;   xyouts, 8, 62.5, '!7p!3!Icut!N = 63 h!E-1!N Mpc', size=2.2, charthick=4.2, color=0
;   xyouts, 8, 500., 'x30!7q!3, !7p!3!Icut!N=63', size=2.2, charthick=4.2, color=0
;   xyouts, 8, 62.5, 'x30!7q!3, !7p!3!Icut!N=63', size=2.2, charthick=4.2, color=0

endif
print
print





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; 
;; wp(sigma) SDSS DR5 UNI22, pi_max cut comparisons...
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
choice_UNI22_comparisons = 'n'
read, choice_UNI22_comparisons, PROMPT=' - Plot the UNI22 pi_max comparisons?? y/n  '
if choice_UNI22_comparisons eq 'y' then begin

   readcol, 'K_wp_output_UNI22_jackknife_errors.dat', $
         i_bin, j_bin, COV_ii, jack

   readcol, 'K_wp_output_UNI22_20rnds_picut39.dat.dat', $
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

   

   readcol, 'K_wp_output_UNI22_30rnds_picut25.dat', $
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

   
   readcol, 'K_wp_output_UNI22_30rnds_picut100.dat', $
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
print
print







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;; 
;; wp(sigma) SDSS DR5 UNI22,   Fibre collisions comparisons
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
choice_UNI22_fibre = 'y'
read, choice_UNI22_fibre, PROMPT=' - Plot the UNI22 Fibre Collisions ??   y/n  '
if choice_UNI22_fibre eq 'y' then begin

   readcol, 'K_wp_output_UNI22_jackknife_errors_for_wFibre.dat', $
            i_bin, j_bin, COV_ii, jack

;;
;;   ****   Fibre collison v1   ****
;;   
   readcol, 'K_wp_output_UNI22_wFibre.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS

   print, 'SDSS Quasar wp(sigma)  read-in  K_wp_output_UNI22_wFibre'
   print
   
   wpsigma_div_sigma = Xi_sigma_LS / sigma
   jack_div_sig = delta_Xi_sigma/sigma
;   w = where (sigma lt 10, N)
;   jack_div_sig[w] =    jack_div_sig[w] * 5.0
   w = where (sigma ge 10, N)
   jack_div_sig[w] =    jack_div_sig[w] * 45.0
   jack_div_sig = jack/sigma

   ;; GREEN 
   plotsym, 0, 0.75, /fill
   oplot, sigma, wpsigma_div_sigma, psym=8, color=128
   oplot, sigma, wpsigma_div_sigma, linestyle=4, color=128, thick=6
   errplot, sigma, $
            (wpsigma_div_sigma-jack_div_sig), (wpsigma_div_sigma+jack_div_sig), $
            thick=4.0, color=128, linestyle=4
   xyouts, 8, 128., ' w/Fib corr (1)', size=2.2, charthick=4.2, color=128
   legend, [''], box=0, position=[3.,256.], color=128, linestyle=4, thick=6

   
;;
;;   ****   Fibre collison v2   ****
;;   
   readcol, 'K_wp_output_UNI22_jackknife_errors_for_wFibre_v2.dat', $
            i_bin, j_bin, COV_ii, jack

   readcol, 'K_wp_output_UNI22_wFibre_v2.dat', $
            sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
            bin_DD_sigma, bin_DR_sigma, $
            Xi_sigma_HAM, Xi_sigma_LS

   print, 'SDSS Quasar wp(sigma)  read-in  K_wp_output_UNI22_wFibre_v2  '
   print
   
   wpsigma_div_sigma = Xi_sigma_LS / sigma
   jack_div_sig = delta_Xi_sigma/sigma
   jack_div_sig = jack/sigma

   ;; RED
   plotsym, 0, 0.75, /fill
   oplot, sigma, wpsigma_div_sigma, psym=8, color=64
   oplot, sigma, wpsigma_div_sigma, linestyle=1, color=64, thick=6
   errplot, sigma, $
            (wpsigma_div_sigma-jack_div_sig), (wpsigma_div_sigma+jack_div_sig), $
            thick=4.0, color=64, linestyle=1
   xyouts, 8, 32., ' w/Fib corr (2)', size=2.2, charthick=4.2, color=64
   legend, [''], box=0, position=[3.,64.], color=64, linestyle=1, thick=6

endif
   




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;
;;   plots xi(s), divided by the given power-law      LOWER PANEL
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

readcol, 'K_wp_output_UNI22.dat', $
         sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
         bin_DD_sigma, bin_DR_sigma, $
         Xi_sigma_HAM, Xi_sigma_LS

readcol, 'K_wp_output_UNI22_jackknife_errors.dat', $
         i_bin, j_bin, COV_ii, jack

Xi_sigma_LS_div_sigma  =  Xi_sigma_LS/sigma
jack_div_sig = jack/sigma

r_nought = 8.75      
gam_r    = 2.40      
A_min    = 2.50
plfit_1 = ((r_nought/sigma)^ gam_r) * A_min

wp_sigma_q_div_plfit =  Xi_sigma_LS_div_sigma / plfit_1
err_plus             =  (Xi_sigma_LS_div_sigma+jack_div_sig) / plfit_1
err_minus            =  (Xi_sigma_LS_div_sigma-jack_div_sig) / plfit_1


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


!p.multi=0
device, /close
set_plot, 'X'


close, /all

end
