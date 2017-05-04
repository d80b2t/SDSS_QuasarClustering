;;+
;;
;; The ``3x4'' plot to show the (evolution of) wp(rp)  
;;  for each redshift subsample
;;
;;-


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;    xi(s),   the usual, log-log plot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

readcol, '../../OP/OP_20080508/K_wp_output_UNI22.dat', $
         sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
         DD_full, DR, Xi_sigma_HAM, Xi_sigma_LS, /silent
;        OP_20080508 has UNIFORM 0.30 < z < 2.20
;sigma, s, xis_std, delta_xis, DD, DR, RR, Xi_sigma_LS, Xi_sigma_HAM, ratio 
print, 'SDSS Quasar xi(s) read-in, K_wp_output_UNI22'
print

xis_q_full = Xi_sigma_LS                     ; just setting the xi_Q(s) to the xi_LS
poisson_full = (1.+xis_q_full)*(sqrt(2./DD_full)) ; Poisson errors


readcol, '../../jackknife/wp_sigma/K_wp_output_UNI22_jackknife_errors.dat', $
         i_bin, j_bin, COV_ii, jack, /silent
print, 'READ in jackknife/K_wp_output_UNI22_jackknife_errors.dat'
print
print

err_ratio = jack / poisson_full



readcol, "../../OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_0pnt00z0pnt30.dat", $
         sigma_0pnt00, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt00, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt00, /silent 
print, 'OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_0pnt00z0pnt30.dat read-in ', $
       n_elements(sigma_0pnt00)
readcol, "../../OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_0pnt30z0pnt68.dat", $
         sigma_0pnt30, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt30, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt30, /silent 
print, 'OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_0pnt30z0pnt68.dat read-in ', $
       n_elements(sigma_0pnt30)
readcol, "../../OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_0pnt68z0pnt92.dat", $
         sigma_0pnt68, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt68, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt68, /silent
print, 'OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_0pnt68z0pnt92.dat read-in ', $
       n_elements(sigma_0pnt68)
readcol, "../../OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_0pnt92z1pnt13.dat", $
         sigma_0pnt92, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt92, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt92, /silent
print, 'OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_0pnt92z1pnt13.dat read-in ', $
       n_elements(sigma_0pnt92)
print
;;--------------------------------------------------------------------------------------

readcol, "../../OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_1pnt13z1pnt32.dat", $
         sigma_1pnt13, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt13, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt13, /silent
print, 'OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_1pnt13z1pnt32.dat read-in ', $
       n_elements(sigma_1pnt13)
readcol, "../../OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_1pnt32z1pnt50.dat", $
         sigma_1pnt32, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt32, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt32, /silent
print, 'OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_1pnt32z1pnt50.dat read-in ', $
       n_elements(sigma_1pnt32)
readcol, "../../OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_1pnt50z1pnt66.dat", $
         sigma_1pnt50, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt50, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt50, /silent
print, 'OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_1pnt50z1pnt66.dat read-in ', $
       n_elements(sigma_1pnt50)
readcol, "../../OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_1pnt66z1pnt83.dat", $
         sigma_1pnt66, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt66, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt66, /silent
print, 'OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_1pnt66z1pnt83.dat read-in ', $
       n_elements(sigma_1pnt66)
print
;;--------------------------------------------------------------------------------------

readcol, "../../OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_1pnt83z2pnt02.dat", $
         sigma_1pnt83, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt83, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt83, /silent
print, 'OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_1pnt83z2pnt02.dat read-in ', $
       n_elements(sigma_1pnt83)
readcol, "../../OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_2pnt02z2pnt20.dat", $
         sigma_2pnt02, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_2pnt02, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_2pnt02, /silent
print, 'OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_2pnt02z2pnt20.dat read-in ', $
       n_elements(sigma_2pnt02)
readcol, "../../OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_2pnt20z2pnt90.dat", $
         sigma_2pnt20, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_2pnt20, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_2pnt20, /silent
print, 'OP/UNI22_evol_5logbins_wpsigma/K_wp_output_UNI22_2pnt20z2pnt90.dat read-in ', $
       n_elements(sigma_2pnt20)
;;--------------------------------------------------------------------------------------
print
print





plotsym,0, 0.75, /fill
x_range_min =   0.399   ; 0.14 'default'   ;; 0.399   for wp(rp)/rp
x_range_max = 300.     ;                  ;; 250.    for wp(rp)/rp
y_range_min =   0.10   ;                  ;; 0.00101 for wp(rp)/rp
y_range_max = 999.     ;                  ;; 999.    for wp(rp)/rp



loadct, 6                       ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='wp_sigma_DR5_quasars_3by4_for_evol_temp.eps', $
        xsize=8.6, ysize=8.5, $
        xoffset=0.1, yoffset=0.2, $
        /inches, /color, /encapsulated

!p.multi=[0,3,4]

plotsym, 0, 1.0, /fill

;;
;;  TOP ROW    TOP ROW    TOP ROW    TOP ROW    TOP ROW    TOP ROW
;;  TOP ROW    TOP ROW    TOP ROW    TOP ROW    TOP ROW    TOP ROW
;;  TOP ROW    TOP ROW    TOP ROW    TOP ROW    TOP ROW    TOP ROW

;;
;;  0.00 < z < 0.30
;;
plot, sigma, Xi_sigma_LS, $
      position=[0.14, 0.77, 0.42, 0.98], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $
      xstyle=1, ystyle=1, $
      thick=4.2, xthick=4.2, ythick=4.2, $
      charsize=3.2, charthick=4.2, $
      ytitle='w!Ip!N(!3r!Ip!N)', $
      xtickformat='(a1)', $
      ytickformat='(f6.1)', $
      color=0
xyouts, 10., 100., '<z>=0.25', charsize=1.2, charthick=4.2, color=250

poisson_0pnt00 = (1.+Xi_sigma_LS_0pnt00) * (sqrt(2./DD_0pnt00))
error_0pnt00 = poisson_0pnt00 * err_ratio

oplot,   sigma_0pnt00,  Xi_sigma_LS_0pnt00, psym=8,      color=240
errplot, sigma_0pnt00, $
         (Xi_sigma_LS_0pnt00-error_0pnt00), $
         (Xi_sigma_LS_0pnt00+error_0pnt00), $
         thick=2.0, color=240

;;
;;  0.30 < z < 0.68
;;
plot, sigma, Xi_sigma_LS, $
      position=[0.42, 0.77, 0.70, 0.98], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $
      xstyle=1, ystyle=1, $
      thick=4.2, xthick=4.2, ythick=4.2, $
      charsize=3.2, charthick=4.2, $
      xtickformat='(a1)', $
      ytickformat='(a1)', $
      color=0

poisson_0pnt30 = (1.+Xi_sigma_LS_0pnt30) * (sqrt(2./DD_0pnt30))
poisson_0pnt30 = poisson_0pnt30 * err_ratio
oplot,   sigma_0pnt30,  Xi_sigma_LS_0pnt30, psym=8,      color=216
errplot, sigma_0pnt30, $
         (Xi_sigma_LS_0pnt30-poisson_0pnt30), $
         (Xi_sigma_LS_0pnt30+poisson_0pnt30), $
         thick=2.0, color=216
xyouts, 10., 100., '<z>=0.49', charsize=1.2, charthick=4.2, color=216


;;
;; 0.68 < z < 0.92
;;
plot, sigma, Xi_sigma_LS, $
      position=[0.70, 0.77, 0.98, 0.98], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $
      xstyle=1, ystyle=1, $
      thick=4.2, xthick=4.2, ythick=4.2, $
      charsize=3.2, charthick=4.2, $
      xtickformat='(a1)', $
      ytickformat='(a1)', $
      color=0
xyouts, 10., 100., '<z>=0.80', charsize=1.2, charthick=4.2, color=192
poisson_0pnt68 = (1.+Xi_sigma_LS_0pnt68) * (sqrt(2./DD_0pnt68))
poisson_0pnt68 = poisson_0pnt68 * err_ratio
oplot,   sigma_0pnt68, Xi_sigma_LS_0pnt68, psym=8, color=192
errplot, sigma_0pnt68, $
         (Xi_sigma_LS_0pnt68-poisson_0pnt68), $
         (Xi_sigma_LS_0pnt68+poisson_0pnt68), $
         thick=2.0, color=192



;; 
;; "TOP MIDDLE" ROW
;;
;;   0.92 < z < 1.13 
;;
plot, sigma, Xi_sigma_LS, $
      position=[0.14, 0.56, 0.42, 0.77], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $
      xstyle=1, ystyle=1, $
      thick=4.2, xthick=4.2, ythick=4.2, $
      charsize=3.2, charthick=4.2, $
      ytitle='w!Ip!N(!3r!Ip!N)', $
      xtickformat='(a1)', $
      ytickformat='(f6.1)', $
      color=0
poisson_0pnt92 = (1.+Xi_sigma_LS_0pnt92) * (sqrt(2./DD_0pnt92))
poisson_0pnt92 = poisson_0pnt92 * err_ratio
oplot,   sigma_0pnt92,  Xi_sigma_LS_0pnt92, psym=8,      color=168
errplot, sigma_0pnt92, (Xi_sigma_LS_0pnt92-poisson_0pnt92), (Xi_sigma_LS_0pnt92+poisson_0pnt92), $
         thick=2.0, color=168
xyouts, 10., 100., '<z>=1.03', charsize=1.2, charthick=4.2, color=168


;;
;; 1.13 < z < 1.32 
;;
plot, sigma, xis_q_full, $
      position=[0.42, 0.56, 0.70, 0.77], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $
      xstyle=1, ystyle=1, $
      thick=4.2, xthick=4.2, ythick=4.2, $
      charsize=3.2, charthick=4.2, $
      xtickformat='(a1)', $
      ytickformat='(a1)', $
      color=0
poisson_1pnt13 = (1.+Xi_sigma_LS_1pnt13) * (sqrt(2./DD_1pnt13))
poisson_1pnt13 = poisson_1pnt13 * err_ratio
oplot,   sigma_1pnt13,  Xi_sigma_LS_1pnt13, psym=8,      color=144
errplot, sigma_1pnt13, $
         (Xi_sigma_LS_1pnt13-poisson_1pnt13), $
         (Xi_sigma_LS_1pnt13+poisson_1pnt13), $
         thick=2.0, color=144
xyouts, 10., 100., '<z>=1.23', charsize=1.2, charthick=4.2, color=144

;;
;; 1.32 < z < 1.50  
;;
plot, sigma, xis_q_full, $
      position=[0.70, 0.56, 0.98, 0.77], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $
      xstyle=1, ystyle=1, $
      thick=4.2, xthick=4.2, ythick=4.2, $
      charsize=3.2, charthick=4.2, $
      xtickformat='(a1)', $
      ytickformat='(a1)', $
      color=0
poisson_1pnt32 = (1.+Xi_sigma_LS_1pnt32) * (sqrt(2./DD_1pnt32))
poisson_1pnt32 = poisson_1pnt32 * err_ratio
oplot,   sigma_1pnt32,  Xi_sigma_LS_1pnt32, psym=8,      color=120
errplot, sigma_1pnt32, (Xi_sigma_LS_1pnt32-poisson_1pnt32), (Xi_sigma_LS_1pnt32+poisson_1pnt32), $
         thick=2.0, color=120
xyouts, 10., 100., '<z>=1.41', charsize=1.2, charthick=4.2, color=120






;;
;; ``BOTTOM MIDDLE'' PANELS
;;
;; 1.50  < z < 1.66
;;
plot, sigma, xis_q_full, $
      position=[0.14, 0.35, 0.42, 0.56], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $
      xstyle=1, ystyle=1, $
      thick=4.2, xthick=4.2, ythick=4.2, $
      charsize=3.2, charthick=4.2, $
      ytitle=' w!Ip!N(!3r!Ip!N)', $
      xtickformat='(a1)', $
      ytickformat='(f6.1)', $
      color=0
poisson_1pnt50 = (1.+Xi_sigma_LS_1pnt50) * (sqrt(2./DD_1pnt50))
poisson_1pnt50 = poisson_1pnt50 * err_ratio
oplot,   sigma_1pnt50,  Xi_sigma_LS_1pnt50, psym=8,      color=96
errplot, sigma_1pnt50, (Xi_sigma_LS_1pnt50-poisson_1pnt50), (Xi_sigma_LS_1pnt50+poisson_1pnt50), $
            thick=2.0, color=96
xyouts, 10., 100., '<z>=1.58', charsize=1.2, charthick=4.2, color=96

;;
;; 1.66  < z < 1.83
;;
plot, sigma, xis_q_full, $
      position=[0.42, 0.35, 0.70, 0.56], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $
      xstyle=1, ystyle=1, $
      thick=4.2, xthick=4.2, ythick=4.2, $
      charsize=3.2, charthick=4.2, $
      xtickformat='(a1)', $
      ytickformat='(a1)', $
      color=0
poisson_1pnt66 = (1.+Xi_sigma_LS_1pnt66) * (sqrt(2./DD_1pnt66))
poisson_1pnt66 = poisson_1pnt66 * err_ratio
oplot,   sigma_1pnt66,  Xi_sigma_LS_1pnt66, psym=8, color=72
errplot, sigma_1pnt66, (Xi_sigma_LS_1pnt66-poisson_1pnt66), (Xi_sigma_LS_1pnt66+poisson_1pnt66), $
            thick=2.0, color=72
xyouts, 10., 100., '<z>=1.74', charsize=1.2, charthick=4.2, color=72

;;
;; 1.83 < z < 2.02
;;
plot, sigma, xis_q_full, $
      position=[0.70, 0.35, 0.98, 0.56], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $
      xstyle=1, ystyle=1, $
      thick=4.2, xthick=4.2, ythick=4.2, $
      charsize=3.2, charthick=4.2, $
      xtitle='!3r!Ip!N / h!E-1!N Mpc', $
      ytickformat='(a1)', $
      color=0
poisson_1pnt83 = (1.+Xi_sigma_LS_1pnt83) * (sqrt(2./DD_1pnt83))
poisson_1pnt83 = poisson_1pnt83 * err_ratio
oplot,   sigma_1pnt83,  Xi_sigma_LS_1pnt83, psym=8, color=72
errplot, sigma_1pnt83, (Xi_sigma_LS_1pnt83-poisson_1pnt83), (Xi_sigma_LS_1pnt83+poisson_1pnt83), $
            thick=2.0, color=72
xyouts, 10., 100., '<z>=1.92', charsize=1.2, charthick=4.2, color=72



;; 
;; BOTTOM PANELS...
;;
;; 2.02 < z < 2.20
;;
plot, sigma, xis_q_full, $
      position=[0.14, 0.14, 0.42, 0.35], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $
      xstyle=1, ystyle=1, $
      thick=4.2, xthick=4.2, ythick=4.2, $
      charsize=3.2, charthick=4.2, $
      xtitle=' !3r!Ip!N / h!E-1!N Mpc', $
      ytitle='w!Ip!N(!3r!Ip!N)', $
      color=0
poisson_2pnt02 = (1.+Xi_sigma_LS_2pnt02) * (sqrt(2./DD_2pnt02))
poisson_2pnt02 = poisson_2pnt02 * err_ratio

oplot,   sigma_2pnt02,  Xi_sigma_LS_2pnt02, psym=8,      color=48
errplot, sigma_2pnt02, $
         (Xi_sigma_LS_2pnt02-poisson_2pnt02), (Xi_sigma_LS_2pnt02+poisson_2pnt02), $
         thick=2.0, color=48
xyouts, 10., 100., '<z>=2.13', charsize=1.2, charthick=4.2, color=48


;;
;; 2.20 < z < 2.90
;;
plot, sigma, Xi_sigma_LS, $
      position=[0.42, 0.14, 0.70, 0.35], $ 
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $ 
      xstyle=1, ystyle=1, $
      thick=4.2, $
      xthick=4.2, ythick=4.2, $
      charsize=3.2, charthick=4.2, $
      xtitle=' !3r!Ip!N / h!E-1!N Mpc', $
      ytickformat='(a1)', $
      color=0

poisson_2pnt20 = (1.+Xi_sigma_LS_2pnt20) * (sqrt(2./DD_2pnt20))
poisson_2pnt20 = poisson_2pnt20 * err_ratio

oplot,   sigma_2pnt20,  Xi_sigma_LS_2pnt20, psym=8,      color=0 
errplot, sigma_2pnt20, $
         (Xi_sigma_LS_2pnt20-poisson_2pnt20), (Xi_sigma_LS_2pnt02+poisson_2pnt20), $
         thick=2.0,                                            color=0
xyouts, 10., 100., '<z>=2.46', charsize=1.2, charthick=4.2,    color=0 


!p.multi=0



; OP_20080121 	has UNIFORM 0.30 < z < 0.68, color=240
; OP_20080122   has UNIFORM 2.25 < z < 2.90, color=24
; OP_20080122b 	has UNIFORM 0.68 < z < 0.92, color=216
; OP_20080123   has UNIFORM 0.92 < z < 1.13, color=192
; OP_20080124 	has UNIFORM 1.13 < z < 1.32, color=168
; OP_20080215	has UNIFORM 1.32 < z < 1.50, color=144
; OP_20080215b	has UNIFORM 1.50 < z < 1.66, color=120
; OP_20080215c	has UNIFORM 1.66 < z < 1.83, color=96
; OP_20080215d	has UNIFORM 1.83 < z < 2.02, color=72
; OP_20080215e	has UNIFORM 2.02 < z < 2.25, color=48


device, /close
set_plot, 'X'

close, /all



end
