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
readcol, 'OP/OP_20080120/k_output_20080120_0pnt30z2pnt90.dat', $
         s_log, s, xis_std, delta_xis, DD, DR, RR, xis_LS, xis_HAM, ratio 
;        OP_20080120 has UNIFORM 0.30 < z < 2.90
print
print, 'SDSS Quasar xi(s) read-in, k_output_20080120_0pnt30z2pnt90'
print

xis_q = xis_LS                       ; just setting the xi_Q(s) to the xi_LS
poisson = (1.+xis_q) * (sqrt(2./DD)) ; Poisson errors, da Angela et al. (2005).


loadct, 6  ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='xis_DR5_quasars_temp.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0, /inches, /color
!p.multi=[0,1,3]

plot, s, xis_q, /xlog, /ylog, position=[0.22, 0.38, 0.98, 0.98],$
      xrange=[0.5, 300], yrange=[0.001, 999], $ ; bring down to 500 w/o V. PREL.
      psym=4, $
      xstyle=1, ystyle=1, $
      charsize=4.2, charthick=3.2, $
      ytitle=' !7n(!3s)', $
      xtickformat='(a1)', ytickformat='(f6.2)', $
      /nodata, $
      color=0


choice_SDSS_QSOs = 'n'
read, choice_SDSS_QSOs, PROMPT=' - Plot SDSS QSOs 0.30<z<2.90 (UNIFORMs)? y/n  '
if (choice_SDSS_QSOs eq 'y') then begin
   oplot, s, xis_q, psym=4, thick=4, color=0
   oplot, s, xis_q, linestyle=0, thick=4, color=0
   errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=0
   
   xyouts, 5.0,20.0, 'Uniform DR5 Quasars', charsize=2.2, charthick=5.2, color=0
   xyouts, 5.0, 8.0,  '0.3 < z < 2.9 ', charsize=2.2, charthick=5.2, color=0
   xyouts, 1.0, 400, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0

   choice_plfit = 'n'
   read, choice_plfit, PROMPT=' --- Plot PL Fit 0.30<z<2.90 (UNIFORMs)? y/n  '
   if (choice_plfit eq 'y') then begin
      s_set=findgen(100)
      s_nought = 5.85
      gamma    = 1.575
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, color=0, thick=4.0
      xis_q_div_plfit = (xis_q / plfit_1) 
      s_set=findgen(25)
      s_nought = 5.90
      gamma    = 1.180
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, color=0, thick=4.0, linestyle=1
      xis_q_div_plfit = (xis_q / plfit_1) 
   endif
endif
print



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasar xi(s) temp.dat file if you want....
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_temp = 'n'
read, choice_temp, PROMPT=' - Plot the current k_output_temp.dat file?  y/n   '
if choice_temp eq 'y' then begin
   
readcol, '2pt/k_output_temp.dat', $
;   readcol, 'OP/OP_20080306/k_output_20080306_0pnt30z2pnt90_PRI_N', $   
                                ;the 1st attempt at PRIMARY...
            s_log, s, xis_std, delta_xis, DD, DR, RR, xis_LS, xis_HAM, ratio 
   print
   print, 'SDSS Quasar xi(s) read-in, 2pt/k_output_temp.dat'
   print

   xis_q_temp = xis_std         ; just setting the xi_Q(s) to the xis_std
   xis_q_temp = xis_LS          ; just setting the xi_Q(s) to the   xi_LS

   poisson_temp = (1.+xis_q) * (sqrt(2./DD)) ; Poisson errors    
;   choice_SDSS_QSOs = 'n'
;   read, choice_SDSS_QSOs, PROMPT=' - Plot SDSS QSOs temp file? y/n   '
;   if (choice_SDSS_QSOs eq 'y') then begin
      oplot, s, xis_q_temp, psym=4, color=48
      oplot, s, xis_q_temp, linestyle=0, color=48
      errplot, s, (xis_q_temp-poisson_temp), (xis_q_temp+poisson_temp), $
               thick=4.0, color=48
      
      xyouts, 5.0,20.0, 'DR5 Quasars temp', charsize=2.2, charthick=5.2, color=48
;   xyouts, 5.0, 8.0,  '0.3 < z < 2.9 ', charsize=2.2, charthick=5.2, color=48
      xyouts, 1.0, 400, '!!!! V. PRELIMINARY RESULT !!!!', $
              charsize=2.2, charthick=6.2, color=48
;   endif
endif
print
   



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   0.30 < z < 0.68,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_0pnt30z0pnt68 = 'n'
read, choice_0pnt30z0pnt68, PROMPT=' - Plot the 0.30<z<0.68 (UNIFORMs)?  y/n  '
if choice_0pnt30z0pnt68 eq 'y' then begin
   
   readcol, "OP/OP_20080121/k_output_20080121_0pnt30z0pnt68.dat", $
            log_s, s_0pnt30, xis_std, delta_xis, DD_0pnt30, DR, RR, $
            xis_LS_0pnt30, xis_HAM, ratio
   print
   print, 'OP/OP_20080121/k_output_20080121_0pnt30z0pnt68.dat read-in '
   print
   
   poisson_0pnt30 = (1.+xis_LS_0pnt30) * (sqrt(2./DD_0pnt30))
   
   oplot,   s_0pnt30, xis_LS_0pnt30, psym=4, color=24
   oplot,   s_0pnt30, xis_LS_0pnt30, linestyle=1,color=24
   errplot, s_0pnt30, $
            (xis_LS_0pnt30-poisson_0pnt30), (xis_LS_0pnt30+poisson_0pnt30), $
            thick=4.0, color=24
   xyouts, 5.0, 150.0, 'Uniform  0.30<z<0.68', $
           charsize=2.2, charthick=4.2, color=24
   xyouts, 1.0, 400, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0
   
   choice_plfit = 'n'
   read, choice_plfit, PROMPT=' --- Plot PL Fit 0.30<z<0.68 (UNIFORMs)? y/n  '
   if (choice_plfit eq 'y') then begin
      s_set=findgen(100)
      s_nought = 6.05
      gamma    = 1.670
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, color=24
      xis_q_div_plfit = (xis_q / plfit_1) 
      s_set=findgen(25)
      s_nought = 6.10
      gamma    = 1.635
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, linestyle=1, color=24
      xis_q_div_plfit = (xis_q / plfit_1) 
   endif
endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   0.68 < z < 0.92,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_0pnt68z0pnt92 = 'n'
read, choice_0pnt68z0pnt92, PROMPT=' - Plot the 0.68<z<0.92 (UNIFORMs)?  y/n  '
if choice_0pnt68z0pnt92 eq 'y' then begin
   
   readcol, "OP/OP_20080122b/k_output_20080122_0pnt68z0pnt92.dat", $
            log_s, s_0pnt68, xis_std, delta_xis, DD_0pnt68, DR, RR, $
            xis_LS_0pnt68, xis_HAM, ratio
   print
   print, 'OP/OP_20080122b/k_output_20080122_0pnt68z0pnt92.dat read-in '
   print
   
   poisson_0pnt68 = (1.+xis_LS_0pnt68) * (sqrt(2./DD_0pnt68))
   
   oplot,   s_0pnt68, xis_LS_0pnt68, psym=4, color=48
   ;oplot,   s_0pnt68, xis_LS_0pnt68, linestyle=1,color=48
   errplot, s_0pnt68, $
            (xis_LS_0pnt68-poisson_0pnt68), (xis_LS_0pnt68+poisson_0pnt68), $
            thick=4.0, color=48
   xyouts, 5.0, 150.0, 'Uniform  0.68<z<0.92', $
           charsize=2.2, charthick=4.2, color=48
   xyouts, 1.0, 400, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0

   choice_plfit = 'n'
   read, choice_plfit, PROMPT=' --- Plot PL Fit 0.68<z<0.92 (UNIFORMs)? y/n  '
   if (choice_plfit eq 'y') then begin
      s_set=findgen(25)
      s_nought = 7.05
      gamma    = 1.975
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, linestyle=1, color=48
      xis_q_div_plfit = (xis_q / plfit_1) 
      s_set=findgen(100)
      s_nought = 6.60
      gamma    = 2.245
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, color=48
      xis_q_div_plfit = (xis_q / plfit_1) 
   endif

endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   0.92 < z < 1.13,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_0pnt92z1pnt13 = 'n' 
read, choice_0pnt92z1pnt13, PROMPT=' - Plot the 0.92<z<1.13 (UNIFORMs)?  y/n  '
if choice_0pnt92z1pnt13 eq 'y' then begin
   
   readcol, "OP/OP_20080123/k_output_20080123_0pnt92z1pnt13.dat", $
            s_log, s_0pnt92, xis_std, delta_xis, DD_0pnt92, DR, RR, $
            xis_LS_0pnt92, xis_HAM, ratio
   print
   print, 'OP/OP_20080123/k_output_20080123_0pnt92z1pnt13.dat read-in '
   print
   
   poisson_0pnt92 = (1.+xis_LS_0pnt92) * (sqrt(2./DD_0pnt92))
   
   oplot,   s_0pnt92, xis_LS_0pnt92, psym=4, color=72
   oplot,   s_0pnt92, xis_LS_0pnt92, linestyle=2,color=72
   errplot, s_0pnt92, $
            (xis_LS_0pnt92-poisson_0pnt92), (xis_LS_0pnt92+poisson_0pnt92), $
            thick=4.0, color=72
   xyouts, 5.0, 150.0, 'Uniform  0.68<z<0.92', $
           charsize=2.2, charthick=4.2, color=72
   xyouts, 1.0, 400, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0
   
   choice_plfit = 'n'
   read, choice_plfit, PROMPT=' --- Plot PL Fit 0.92<z<1.13 (UNIFORMs)? y/n  '
   if (choice_plfit eq 'y') then begin
      s_set=findgen(100)
;      s_nought = 
;      gamma    = 
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, color=72
      xis_q_div_plfit = (xis_q / plfit_1) 
      s_set=findgen(25)
;      s_nought = 
;      gamma    = 
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, linestyle=1, color=72
      xis_q_div_plfit = (xis_q / plfit_1) 
   endif

endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   1.13 < z < 1.32,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_1pnt13z1pnt32 = 'n' 
read, choice_1pnt13z1pnt32, PROMPT=' - Plot the 1.13<z<1.32 (UNIFORMs)?  y/n  '
if choice_1pnt13z1pnt32 eq 'y' then begin
   
   readcol, "OP/OP_20080124/k_output_20080124_1pnt13z1pnt32.dat", $
            s_log, s_1pnt13, xis_std, delta_xis, DD_1pnt13, DR, RR, $
            xis_LS_1pnt13, xis_HAM, ratio
   print
   print, 'OP/OP_20080124/k_output_20080124_1pnt13z1pnt32.dat read-in '
   print

   poisson_1pnt13 = (1.+xis_LS_1pnt13) * (sqrt(2./DD_1pnt13))
   
   oplot,   s_1pnt13, xis_LS_1pnt13, psym=4, color=96
   oplot,   s_1pnt13, xis_LS_1pnt13, linestyle=2,color=96
   errplot, s_1pnt13, $
            (xis_LS_1pnt13-poisson_1pnt13), (xis_LS_1pnt13+poisson_1pnt13), $
            thick=4.0, color=96
 xyouts, 5.0, 150.0, 'Uniform  1.13<z<1.32', $
           charsize=2.2, charthick=4.2, color=96
 xyouts, 1.0, 400, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0

 choice_plfit = 'n'
   read, choice_plfit, PROMPT=' --- Plot PL Fit 1.13<z<1.32 (UNIFORMs)? y/n  '
   if (choice_plfit eq 'y') then begin
      s_set=findgen(100)
;      s_nought = 
;      gamma    = 
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, color=96
      xis_q_div_plfit = (xis_q / plfit_1) 
      s_set=findgen(25)
;      s_nought = 
;      gamma    = 
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, linestyle=1, color=96
      xis_q_div_plfit = (xis_q / plfit_1) 
   endif

endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   1.32 < z < 1.50,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_1pnt32z1pnt50 = 'n' 
read, choice_1pnt32z1pnt50, PROMPT=' - Plot the 1.32<z<1.50 (UNIFORMs)?  y/n  '
if choice_1pnt32z1pnt50 eq 'y' then begin
   
   readcol, "OP/OP_20080215/k_output_20080215_1pnt32z1pnt50.dat", $
            s_log, s_1pnt32, xis_std, delta_xis, DD_1pnt32, DR, RR, $
            xis_LS_1pnt32, xis_HAM, ratio
   print
   print, 'OP/OP_20080215/k_output_20080215_1pnt32z1pnt50.dat read-in '
   print

   poisson_1pnt32 = (1.+xis_LS_1pnt32) * (sqrt(2./DD_1pnt32))
   
   oplot,   s_1pnt32, xis_LS_1pnt32, psym=4, color=120
   oplot,   s_1pnt32, xis_LS_1pnt32, linestyle=2,color=120
   errplot, s_1pnt32, $
            (xis_LS_1pnt32-poisson_1pnt32), (xis_LS_1pnt32+poisson_1pnt32), $
            thick=4.0, color=120
 xyouts, 5.0, 150.0, 'Uniform  1.32<z<1.50', $
           charsize=2.2, charthick=4.2, color=120
 xyouts, 1.0, 400, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0

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
read, choice_1pnt50z1pnt66, PROMPT=' - Plot the 1.50<z<1.66 (UNIFORMs)?  y/n  '
if choice_1pnt50z1pnt66 eq 'y' then begin
   
   readcol, "OP/OP_20080215b/k_output_20080215_1pnt50z1pnt66.dat", $
            s_log, s_1pnt50, xis_std, delta_xis, DD_1pnt50, DR, RR, $
            xis_LS_1pnt50, xis_HAM, ratio
   print
   print, 'OP/OP_20080215b/k_output_20080215_1pnt50z1pnt66.dat read-in '
   print

   poisson_1pnt50 = (1.+xis_LS_1pnt50) * (sqrt(2./DD_1pnt50))
   
   oplot,   s_1pnt50, xis_LS_1pnt50, psym=4, color=144
   oplot,   s_1pnt50, xis_LS_1pnt50, linestyle=2,color=144
   errplot, s_1pnt50, $
            (xis_LS_1pnt50-poisson_1pnt50), (xis_LS_1pnt50+poisson_1pnt50), $
            thick=4.0, color=144
 xyouts, 5.0, 150.0, 'Uniform  0.68<z<0.92', $
           charsize=2.2, charthick=4.2, color=144
 xyouts, 1.0, 400, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0

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
read, choice_1pnt66z1pnt83, PROMPT=' - Plot the 1.66<z<1.83 (UNIFORMs)?  y/n  '
if choice_1pnt66z1pnt83 eq 'y' then begin
   
   readcol, "OP/OP_20080215c/k_output_20080215_1pnt66z1pnt83.dat", $
            s_log, s_1pnt66, xis_std, delta_xis, DD_1pnt66, DR, RR, $
            xis_LS_1pnt66, xis_HAM, ratio
   print
   print, 'OP/OP_20080215c/k_output_20080215_1pnt66z1pnt83.dat read-in '
   print

   poisson_1pnt66 = (1.+xis_LS_1pnt66) * (sqrt(2./DD_1pnt66))
   
   oplot,   s_1pnt66, xis_LS_1pnt66, psym=4, color=168
   oplot,   s_1pnt66, xis_LS_1pnt66, linestyle=2,color=168
   errplot, s_1pnt66, $
            (xis_LS_1pnt66-poisson_1pnt66), (xis_LS_1pnt66+poisson_1pnt66), $
            thick=4.0, color=168
 xyouts, 5.0, 150.0, 'Uniform  0.68<z<0.92', $
           charsize=2.2, charthick=4.2, color=168
 xyouts, 1.0, 400, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0

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
read, choice_1pnt83z2pnt02, PROMPT=' - Plot the 1.83<z<2.02 (UNIFORMs)?  y/n  '
if choice_1pnt83z2pnt02 eq 'y' then begin
   
   readcol, "OP/OP_20080215d/k_output_20080215_1pnt83z2pnt02.dat", $
            s_log, s_1pnt83, xis_std, delta_xis, DD_1pnt83, DR, RR, $
            xis_LS_1pnt83, xis_HAM, ratio
   print
   print, 'OP/OP_20080215d/k_output_20080215_1pnt83z2pnt02.dat read-in '
   print

   poisson_1pnt83 = (1.+xis_LS_1pnt83) * (sqrt(2./DD_1pnt83))
   
   oplot,   s_1pnt83, xis_LS_1pnt83, psym=4, color=192
   oplot,   s_1pnt83, xis_LS_1pnt83, linestyle=2,color=192
   errplot, s_1pnt83, $
            (xis_LS_1pnt83-poisson_1pnt83), (xis_LS_1pnt83+poisson_1pnt83), $
            thick=4.0, color=192
 xyouts, 5.0, 150.0, 'Uniform  1.83<z<2.02', $
           charsize=2.2, charthick=4.2, color=192
 xyouts, 1.0, 400, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0
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
read, choice_2pnt02z2pnt25, PROMPT=' - Plot the 2.02<z<2.25 (UNIFORMs)?  y/n  '
if choice_2pnt02z2pnt25 eq 'y' then begin
   
   readcol, "OP/OP_20080215e/k_output_20080215_2pnt02z2pnt25.dat", $
            s_log, s_2pnt02, xis_std, delta_xis, DD_2pnt02, DR, RR, $
            xis_LS_2pnt02, xis_HAM, ratio
   print
   print, 'OP/OP_20080215e/k_output_20080215_2pnt02z2pnt25.dat read-in '
   print
   
   poisson_2pnt02 = (1.+xis_LS_2pnt02) * (sqrt(2./DD_2pnt02))
   
   oplot,   s_2pnt02, xis_LS_2pnt02, psym=4, color=216
   oplot,   s_2pnt02, xis_LS_2pnt02, linestyle=2,color=216
   errplot, s_2pnt02, $
            (xis_LS_2pnt02-poisson_2pnt02), (xis_LS_2pnt02+poisson_2pnt02), $
            thick=4.0, color=216
   xyouts, 5.0, 150.0, 'Uniform  2.02<z<2.25', $
           charsize=2.2, charthick=4.2, color=216
   xyouts, 1.0, 400, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0

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
;      s_nought = 
;      gamma    = 
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, linestyle=1, color=216
      xis_q_div_plfit = (xis_q / plfit_1) 
   endif
endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   2.25 < z < 2.90,   if you want
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_2pnt25z2pnt90 = 'n' 
read, choice_2pnt25z2pnt90, PROMPT=' - Plot the 2.25<z<2.90 (UNIFORMs)?  y/n  '
if choice_2pnt25z2pnt90 eq 'y' then begin
   
   readcol, "OP/OP_20080122/k_output_20080122_2pnt25z2pnt90.dat", $
            s_log, s_2pnt25, xis_std, delta_xis, DD_2pnt25, DR, RR, $
            xis_LS_2pnt25, xis_HAM, ratio
   print
   print, 'OP/OP_20080122/k_output_20080122_2pnt25z2pnt90.dat read-in '
   print

   poisson_2pnt25 = (1.+xis_LS_2pnt25) * (sqrt(2./DD_2pnt25))
   
   oplot,   s_2pnt25, xis_LS_2pnt25, psym=4, color=240
   oplot,   s_2pnt25, xis_LS_2pnt25, linestyle=2,color=240
   errplot, s_2pnt25, $
            (xis_LS_2pnt25-poisson_2pnt25), (xis_LS_2pnt25+poisson_2pnt25), $
            thick=4.0, color=240
   xyouts, 5.0, 150.0, 'Uniform  2.25<z<2.90', $
           charsize=2.2, charthick=4.2, color=240
   xyouts, 1.0, 400, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0
choice_plfit = 'n'
   read, choice_plfit, PROMPT=' --- Plot PL Fit 2.25<z<2.90 (UNIFORMs)? y/n  '
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
print


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots SDSS DR5 Quasasrs,   0.70 < z < 1.40,  
;                              e.g. cf. Coil et al. (2008, DEEP2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_0pnt70z1pnt40 = 'n' 
print
read, choice_0pnt70z1pnt40, PROMPT=' - Plot the 0.70<z<1.40 (UNIFORMs)?  y/n  '
if choice_0pnt70z1pnt40 eq 'y' then begin
   
   readcol, "OP/OP_20080307/k_output_20080307_0pnt70z1pnt40.dat", $
            s_log, s_0pnt70, xis_std, delta_xis, DD_0pnt70, DR, RR, $
            xis_LS_0pnt70, xis_HAM, ratio
   print
   print, 'OP/OP_20080307/k_output_20080307_0pnt70z1pnt40.dat read-in '
   print

   poisson_0pnt70 = (1.+xis_LS_0pnt70) * (sqrt(2./DD_0pnt70))
   
   oplot,   s_0pnt70, xis_LS_0pnt70, psym=4, color=120
   oplot,   s_0pnt70, xis_LS_0pnt70, linestyle=2,color=120
   errplot, s_0pnt70, $
            (xis_LS_0pnt70-poisson_0pnt70), (xis_LS_0pnt70+poisson_0pnt70), $
            thick=4.0, color=120
   xyouts, 5.0, 150.0, 'Uniform  0.70<z<1.40', $
           charsize=2.2, charthick=4.2, color=120
   xyouts, 1.0, 400, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0
choice_plfit = 'n'
   read, choice_plfit, PROMPT=' --- Plot PL Fit 0.70<z<1.40 (UNIFORMs)? y/n  '
   if (choice_plfit eq 'y') then begin

     ; xis_q_div_plfit = (xis_q / plfit_1) 
      s_set=findgen(25)
      s_nought = 5.60
      gamma    = 0.800
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, linestyle=1, color=120

      s_set=findgen(100)
      s_nought = 6.75
      gamma    = 1.73
      plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
      oplot, s_set, plfit_1, thick=4.0, color=120

      xis_q_div_plfit = (xis_q / plfit_1) 
   endif
endif
print








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   Overplots SDSS DR5 Quasasrs,   0.30 < z < 2.90  best-fits lines, IYW...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_plfit = 'n'
read, choice_plfit, PROMPT=' --- OPlot PL Fit 0.30<z<2.90 (UNIFORMs)? y/n  '
if (choice_plfit eq 'y') then begin
   s_set=findgen(100)
   s_nought = 5.85
   gamma    = 1.575
   plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
   oplot, s_set, plfit_1, thick=4.0, color=0, linestyle=1
   xis_q_div_plfit = (xis_q / plfit_1) 
;   s_set=findgen(25)
;   s_nought = 5.90
;   gamma    = 1.180
;   plfit_1 =  (s_set/s_nought)^(-1.0* gamma)
;   oplot, s_set, plfit_1, color=0, thick=4.0, linestyle=1
;   xis_q_div_plfit = (xis_q / plfit_1) 
endif
print


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots 2SLAQ LRG xi(s)     if you want....
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
;read, choice_2SLAQ_LRG, PROMPT=' - Plot 2SLAQ LRGs? y/n   '
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
print



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots 2QZ xi(s), if you want     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_2QZ = 'n'
read, choice_2QZ, PROMPT=' - Plot 2QZ?  y/n   '
if choice_2QZ eq 'y' then begin
   
   readcol, '2QZ/Croom05/all_xir98.out', s_2QZ, xis_LS_2QZ, err_2QZ
   print
   print, '2QZ xi(s) read-in'
   print
   
   oplot,   s_2QZ, xis_LS_2QZ, color= 164
   errplot, s_2QZ, $
            (xis_LS_2QZ-err_2QZ), (xis_LS_2QZ+err_2QZ), $
            thick=4.0, color=164
;   errfill, s_2QZ, xis_LS_2QZ, err_2QZ, color=64
   xyouts, 5.0, 150.0, '2QZ  0.3<z<2.2',  charsize=2.2, charthick=4.2, color=164
   xyouts, 5.0, 55.0, 'Croom et al. (2005)',  charsize=2.2, charthick=4.2, color=164

endif
print



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots 2SLAQ QSO xi(s), if you want     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
choice_2SLAQ_QSOs = 'n'
read, choice_2SLAQ_QSOs, PROMPT=' - Plot 2SLAQ QSOs? (Jaca) y/n   '
if choice_2SLAQ_QSOs eq 'y' then begin
   
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
; overplot the SDSS DR5 Quasar points over the 2SLAQ red errorbar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
choice_2SLAQ_overplot = 'n' 
read, choice_2SLAQ_overplot, PROMPT='- oplot SDSS QSOs, 2SLAQ LRG errorbar? y/n  '
if choice_2SLAQ_overplot eq 'y' then begin
   oplot, s, xis_q, psym=4, color=128
   errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=128
   xyouts, 3.0, 100.0, '2SLAQ LRGs',    charsize=2.2, charthick=4.2, color=64
   xyouts, 3.0, 50.0,  'DR5 Quasars',   charsize=2.2, charthick=4.2, color=128
endif 



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


;legend,['2.29<z<2.90','Uniform','0.30<z<0.68'], $
;       box=0, charsize=1.8, charthick=4.2, $
;       line=[2,0,1], $
;       position=[10,100], $
;       color=[224,128,32]




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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots simple power-law fit 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  

s_nought = 5.85  ;6.26
gamma    = 1.575 ;1.72

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
;    xi(s),   Mega Large Scales....
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
choice_SDSS_QSOs = 'n'
print
read, choice_SDSS_QSOs, PROMPT=' - Plot SDSS 0.3<z<2.9 UNIs, LARGE SCALES?  y/n '
if (choice_SDSS_QSOs eq 'y') then begin
   
   readcol, 'OP/OP_20080120/k_output_20080120_0pnt30z2pnt90.dat', $
            s_log, s, xis_std, delta_xis, DD, DR, RR, xis_LS, xis_HAM, ratio 
;        OP_20080120 has UNIFORM 0.30 < z < 2.90
   print, 'SDSS Quasar xi(s) read-in, k_output_20080120_0pnt30z2pnt90'
   print
   
   xis_q = xis_LS                       ; just setting the xi_Q(s) to the xi_LS
   poisson = (1.+xis_q) * (sqrt(2./DD)) ; Poisson errors
   
   loadct, 6                    ; black=0=255, red=63, green=127, blue=191
   set_plot, 'ps'
   device, filename='xis_DR5_quasars_LARGE_scales_temp.ps', $
           xsize=8, ysize=4, /inches, /color
   !p.multi=0
   
   plot, s, xis_q, $
         position=[0.22, 0.38, 0.98, 0.98],$
         xrange=[0.0, 3000], yrange=[-0.1, 0.7], $ 
         psym=4, $
         xstyle=1, ystyle=1, $
         charsize=2.2, charthick=3.2, $
         xtitle=' s / h!E-1!N Mpc', $
         ytitle=' !7n(!3s)', $
         ;xtickformat='(f1)', 
         ytickformat='(f4.1)', $
         /nodata, $
         color=0
   
   zero_line = fltarr(3000)
   oplot, s, zero_line, linestyle=0

   plotsym,8,0.6,/fill
   oplot, s, xis_q, psym=8, color=0
   oplot, s, xis_q, linestyle=0, color=0
   errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=0
   
   xyouts, 5.0,20.0, 'Uniform DR5 Quasars', charsize=2.2, charthick=5.2, color=0
   xyouts, 5.0, 8.0,  '0.3 < z < 2.9 ', charsize=2.2, charthick=5.2, color=0
   xyouts, 1.0, 400, '!!!! V. PRELIMINARY RESULT !!!!', $
           charsize=2.2, charthick=6.2, color=0
endif









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   plots the DD, DR, RR counts as a sanity check (from nbc_kde_v1_13.pro)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;readcol, 'OP/OP_20080120/k_output_20080120_0pnt30z2pnt90.dat', $
readcol, '2pt/k_output_temp.dat', $
         s_log, s, xis_std, delta_xis, DD, DR, RR, xis_LS, xis_HAM, ratio
print
print, 'Read-in SDSS Quasar xi(s), again, for DDs, DRs, RRs;'
print
s_check = s

bin_DD_plot = DD / (44348d/32648d)
bin_DR_plot = DR / sqrt( (44348d/32648d)*(1000000d/652938d)  )
bin_RR_plot = RR / (1000000d/652938d)

loadct, 6  ; black, red, mauve, green, red, black
set_plot, 'ps'
!p.multi=0
device, filename='DDs_DRs_check_temp.ps', xsize=8, ysize=8, /inches, /color
plot, s_check, bin_DD_plot, /xlog, /ylog, $
;      xrange=[1.0, 20000.0], yrange=[0.1, 2e11], xstyle=1, ystyle=1., $
      xrange=[0.5, 500.0], yrange=[0.5, 2e7], xstyle=1, ystyle=1., $
      xtitle='s / h^-1 Mpc', ytitle=' No. of pairs', $
      xcharsize=1.8, ycharsize=2.2, charthick=4, $
      position=[0.17,0.15,0.98,0.98], color=0 ;, /nodata
xyouts, 25.0, 64., 'bin_DD (temp)',charsize=2.2,charthick=3, color=0

oplot, s_check, bin_DR_plot, color = 48
xyouts, 25.0, 16., 'bin_DR (temp)',charsize=2.2,charthick=3, color=48
oplot, s_check, bin_RR_plot, color = 96
xyouts, 25.0, 4., 'bin_RR (temp)',charsize=2.2,charthick=3, color=96
;;oplot, s_check, bin_QG_plot, color = 128, thick=5.
;;xyouts, 50.0, 16., 'bin_QG',charsize=2.2,charthick=3, color=128
;;oplot, s_check, bin_QR_plot, color = 256, thick=5.
;;xyouts, 50.0, 4., 'bin_QR',charsize=2.2,charthick=3, color=256

N_data = sqrt(total(DD)) 
N_randoms = sqrt(total(RR)) 
N_data = 44348d
N_randoms = 1000000d

print
print, 'N_data,  ', N_data
print, 'N_randoms', N_randoms
print

readcol, 'OP/OP_20080120/k_output_20080120_0pnt30z2pnt90.dat', $
         s_log, s, xis_std, delta_xis, DD, DR, RR, xis_LS, xis_HAM, ratio 
s_check = s
;DD = DD * (N_data / 32648d)
;DR = DR * sqrt ((N_data / 32648d) * (N_randoms / 652938d))
;RR = RR * (N_randoms / (652938d))

;DR = DR * 
;RR = RR * 
;;;  for cf. against 2QZ

bin_DD_plot = DD 
bin_DR_plot = DR
bin_RR_plot = RR


oplot, s_check, bin_DD_plot, color = 144, linestyle=1, thick=3
xyouts, 1500, 256., 'bin_DD_uni',charsize=2.2, charthick=3, color=144
oplot, s_check, bin_DR_plot, color = 192, linestyle=1, thick=3
xyouts, 1500, 64., 'bin_DR_uni',charsize=2.2,charthick=3, color=192
oplot, s_check, bin_RR_plot, color = 240, linestyle=1, thick=3
xyouts, 1500, 16., 'bin_RR_uni',charsize=2.2,charthick=3, color=240

;bin_RR_plot = bin_RR_plot * 1.35
;oplot, s_check, bin_RR_plot, color = 240, linestyle=1, thick=3
;xyouts, 1500, 16., 'bin_RR_uni',charsize=2.2,charthick=3, color=240



readcol, '2QZ/Croom05/all_xir98.out', s_2QZ, xis_LS_2QZ, err_2QZ, DD
print
print, 'Read-in SDSS Quasar xi(s), again, for DDs, DRs, RRs;'
print
s_check = s_2QZ

DR = DD / (1.+xis_LS_2QZ) *20.
RR =  (20.*(20.*DD - 2.*DR) ) /(xis_LS_2QZ -1.)


bin_DD_plot = DD 
bin_DR_plot = DR
bin_RR_plot = RR
loadct, 25     ; purple, blue, sky blue, green, yellow, red
oplot, s_check, bin_DD_plot, color = 44, linestyle=2, thick=3
xyouts, .75, 1048576., 'DD_2QZ',charsize=2.2, charthick=3, color=44
oplot, s_check, bin_DR_plot, color = 92, linestyle=2, thick=3
xyouts, .75, 262144., 'DR_2QZ',charsize=2.2,charthick=3, color=92
oplot, s_check, bin_RR_plot, color = 140, linestyle=2, thick=3
xyouts, .75, 65536., 'RR_2QZ',charsize=2.2,charthick=3, color=140


device, /close
set_plot, 'X'

close, /all


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;   NOTES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;
;OP_20080120 has UNIFORM 0.30 < z < 2.90, color=0
;
; OP_20080121 	has UNIFORM 0.30 < z < 0.68, color=24
; OP_20080122   has UNIFORM 2.25 < z < 2.90, color=240
; OP_20080122b 	has UNIFORM 0.68 < z < 0.92, color=48
; OP_20080123   has UNIFORM 0.92 < z < 1.13, color=72
; OP_20080124 	has UNIFORM 1.13 < z < 1.32, color=96
; OP_20080215	has UNIFORM 1.32 < z < 1.50, color=120
; OP_20080215b	has UNIFORM 1.50 < z < 1.66, color=144
; OP_20080215c	has UNIFORM 1.66 < z < 1.83, color=168
; OP_20080215d	has UNIFORM 1.83 < z < 2.02, color=192
; OP_20080215e	has UNIFORM 2.02 < z < 2.25, color=216


end
