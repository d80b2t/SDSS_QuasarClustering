;+
;
;
;
;-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;    xi(s),   the usual, log-log plot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

readcol, 'OP/OP_20080508/k_output_UNI22.dat', s_log, s, xis_std, delta_xis, DD, DR, RR, xis_LS, xis_HAM, ratio 
;        OP_20080508 has UNIFORM 0.30 < z < 2.20
print
print, 'SDSS Quasar xi(s) read-in, k_output_UNI22'
print

xis_q_full = xis_LS                     ; just setting the xi_Q(s) to the xi_LS
poisson = (1.+xis_q_full)*(sqrt(2./DD)) ; Poisson errors
print
print



readcol, "OP/OP_20080121/k_output_UNI22_0pnt30z0pnt68.dat", $
         log_s, s_0pnt30, xis_std, delta_xis, DD_0pnt30, DR, RR, $
         xis_LS_0pnt30, xis_HAM, ratio
print, 'OP/OP_20080121/k_output_20080121_0pnt30z0pnt68.dat read-in '
readcol, "OP/OP_20080122b/k_output_20080122_0pnt68z0pnt92.dat", $
         log_s, s_0pnt68, xis_std, delta_xis, DD_0pnt68, DR, RR, $
         xis_LS_0pnt68, xis_HAM, ratio
print, 'OP/OP_20080122b/k_output_20080122_0pnt68z0pnt92.dat read-in '
readcol, "OP/OP_20080123/k_output_20080123_0pnt92z1pnt13.dat", $
         s_log, s_0pnt92, xis_std, delta_xis, DD_0pnt92, DR, RR, $
         xis_LS_0pnt92, xis_HAM, ratio
print, 'OP/OP_20080123/k_output_20080123_0pnt92z1pnt13.dat read-in '
print

readcol, "OP/OP_20080124/k_output_20080124_1pnt13z1pnt32.dat", $
            s_log, s_1pnt13, xis_std, delta_xis, DD_1pnt13, DR, RR, $
            xis_LS_1pnt13, xis_HAM, ratio
print, 'OP/OP_20080124/k_output_20080124_1pnt13z1pnt32.dat read-in '
readcol, "OP/OP_20080215/k_output_20080215_1pnt32z1pnt50.dat", $
         s_log, s_1pnt32, xis_std, delta_xis, DD_1pnt32, DR, RR, $
         xis_LS_1pnt32, xis_HAM, ratio
print, 'OP/OP_20080215/k_output_20080215_1pnt32z1pnt50.dat read-in '
readcol, "OP/OP_20080215b/k_output_20080215_1pnt50z1pnt66.dat", $
            s_log, s_1pnt50, xis_std, delta_xis, DD_1pnt50, DR, RR, $
            xis_LS_1pnt50, xis_HAM, ratio
print, 'OP/OP_20080215b/k_output_20080215_1pnt50z1pnt66.dat read-in '
print


readcol, "OP/OP_20080215c/k_output_20080215_1pnt66z1pnt83.dat", $
         s_log, s_1pnt66, xis_std, delta_xis, DD_1pnt66, DR, RR, $
         xis_LS_1pnt66, xis_HAM, ratio
print, 'OP/OP_20080215c/k_output_20080215_1pnt66z1pnt83.dat read-in '
readcol, "OP/OP_20080215d/k_output_20080215_1pnt83z2pnt02.dat", $
         s_log, s_1pnt83, xis_std, delta_xis, DD_1pnt83, DR, RR, $
         xis_LS_1pnt83, xis_HAM, ratio
print, 'OP/OP_20080215d/k_output_20080215_1pnt83z2pnt02.dat read-in '
readcol, "OP/OP_20080215e/k_output_20080215_2pnt02z2pnt25.dat", $
         s_log, s_2pnt02, xis_std, delta_xis, DD_2pnt02, DR, RR, $
         xis_LS_2pnt02, xis_HAM, ratio
print, 'OP/OP_20080215e/k_output_20080215_2pnt02z2pnt25.dat read-in '
print



plotsym,0, 0.75, /fill



loadct, 6                       ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='xis_DR5_quasars_3by3_for_evol_temp.ps', xsize=7.5, ysize=6.0, /inches, /color
!p.multi=[0,3,3]

plot, s, xis_q_full, $
      position=[0.14, 0.14, 0.42, 0.42], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[0.5, 300], yrange=[0.001, 99.], $ ; bring down to 500 w/o V. PREL.
      xstyle=1, ystyle=1, $
      charsize=2.2, charthick=4.2, $
      ytitle=' !7n(!3s)', $
      xtitle=' s / h!E-1!N Mpc', $
      ytickformat='(f6.2)', $
      color=0
poisson_1pnt66 = (1.+xis_LS_1pnt66) * (sqrt(2./DD_1pnt66))
oplot,   s_1pnt66,  xis_LS_1pnt66, psym=8,      color=96
errplot, s_1pnt66, (xis_LS_1pnt66-poisson_1pnt66), (xis_LS_1pnt66+poisson_1pnt66), $
            thick=4.0, color=96
xyouts, 10., 10., '<z>=1.74', charsize=1.2, charthick=4.2, color=96
;oplot, s, xis_q_full, psym=8, thick=4, color=0
;oplot, s, xis_q_full, linestyle=0, thick=4, color=0
;errplot, s, (xis_q_full-poisson), (xis_q_full+poisson), thick=4.0, color=0

;xyouts, 15.0, 128.0, 'SDSS DR5Q (uni)', charsize=2.2, charthick=6.2, color=0
;;   xyouts, 5.0,20.0, 'SDSS DR5 ', charsize=2.2, charthick=6.2, color=0
;   xyouts, 15.0, 45.3,  '0.3 < z < 2.2 ', charsize=2.2, charthick=6.2, color=0
;;   xyouts, 1.0, 1400, '!!!! V. PRELIMINARY RESULT !!!!', $
;           charsize=2.2, charthick=6.2, color=0

plot, s, xis_q_full, $
      position=[0.42, 0.14, 0.70, 0.42], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[0.5, 300], yrange=[0.001, 99], $ ; bring down to 500 w/o V. PREL.
      xstyle=1, ystyle=1, $
      charsize=2.2, charthick=4.2, $
      xtitle=' s / h!E-1!N Mpc', $
      ytickformat='(a1)', $
      color=0
poisson_1pnt83 = (1.+xis_LS_1pnt83) * (sqrt(2./DD_1pnt83))
oplot,   s_1pnt83,  xis_LS_1pnt83, psym=8, color=72
errplot, s_1pnt83, (xis_LS_1pnt83-poisson_1pnt83), (xis_LS_1pnt83+poisson_1pnt83), $
            thick=4.0, color=72
xyouts, 10., 10., '<z>=1.92', charsize=1.2, charthick=4.2, color=72
plot, s, xis_q_full, $
      position=[0.70, 0.14, 0.98, 0.42], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[0.5, 300], yrange=[0.001, 99.], $ ; bring down to 500 w/o V. PREL.
      xstyle=1, ystyle=1, $
      charsize=2.2, charthick=4.2, $
      xtitle=' s / h!E-1!N Mpc', $
      ytickformat='(a1)', $
      color=0
poisson_2pnt02 = (1.+xis_LS_2pnt02) * (sqrt(2./DD_2pnt02))
oplot,   s_2pnt02,  xis_LS_2pnt02, psym=8,      color=48
errplot, s_2pnt02, (xis_LS_2pnt02-poisson_2pnt02), (xis_LS_2pnt02+poisson_2pnt02), $
            thick=4.0, color=48
xyouts, 10., 10., '<z>=2.13', charsize=1.2, charthick=4.2, color=48



;; 
;; MIDDLE ROW
;;
plot, s, xis_q_full, $
      position=[0.14, 0.42, 0.42, 0.70], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[0.5, 300], yrange=[0.001, 99.], $ ; bring down to 500 w/o V. PREL.
      xstyle=1, ystyle=1, $
      charsize=2.2, charthick=4.2, $
      ytitle=' !7n(!3s)', $
      xtickformat='(a1)', $
      ytickformat='(f6.2)', $
      color=0
poisson_1pnt13 = (1.+xis_LS_1pnt13) * (sqrt(2./DD_1pnt13))
oplot,   s_1pnt13,  xis_LS_1pnt13, psym=8,      color=168
errplot, s_1pnt13, (xis_LS_1pnt13-poisson_1pnt13), (xis_LS_1pnt13+poisson_1pnt13), $
         thick=4.0, color=168
xyouts, 10., 10., '<z>=1.23', charsize=1.2, charthick=4.2, color=168

plot, s, xis_q_full, $
      position=[0.42, 0.42, 0.70, 0.70], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[0.5, 300], yrange=[0.001, 99.], $ ; bring down to 500 w/o V. PREL.
      xstyle=1, ystyle=1, $
      charsize=2.2, charthick=4.2, $
      xtickformat='(a1)', $
      ytickformat='(a1)', $
      color=0
poisson_1pnt32 = (1.+xis_LS_1pnt32) * (sqrt(2./DD_1pnt32))
oplot,   s_1pnt32,  xis_LS_1pnt32, psym=8,      color=144
errplot, s_1pnt32, (xis_LS_1pnt32-poisson_1pnt32), (xis_LS_1pnt32+poisson_1pnt32), $
         thick=4.0, color=144
xyouts, 10., 10., '<z>=1.41', charsize=1.2, charthick=4.2, color=144

plot, s, xis_q_full, $
      position=[0.70, 0.42, 0.98, 0.70], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[0.5, 300], yrange=[0.001, 99.], $ ; bring down to 500 w/o V. PREL.
      xstyle=1, ystyle=1, $
      charsize=2.2, charthick=4.2, $
      xtickformat='(a1)', $
      ytickformat='(a1)', $
      color=0
poisson_1pnt50 = (1.+xis_LS_1pnt50) * (sqrt(2./DD_1pnt50))
oplot,   s_1pnt50,  xis_LS_1pnt50, psym=8,      color=120
errplot, s_1pnt50, (xis_LS_1pnt50-poisson_1pnt50), (xis_LS_1pnt50+poisson_1pnt50), $
         thick=4.0, color=120
xyouts, 10., 10., '<z>=1.58', charsize=1.2, charthick=4.2, color=120



;; 
;; TOP ROW
;;
plot, s, xis_q_full, $
      position=[0.14, 0.70, 0.42, 0.98], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[0.5, 300], yrange=[0.001, 99.], $ ; bring down to 500 w/o V. PREL.
      xstyle=1, ystyle=1, $
      charsize=2.2, charthick=4.2, $
      ytitle=' !7n(!3s)', $
      xtickformat='(a1)', $
      ytickformat='(f6.2)', $
      color=0
poisson_0pnt30 = (1.+xis_LS_0pnt30) * (sqrt(2./DD_0pnt30))
oplot,   s_0pnt30,  xis_LS_0pnt30, psym=8,      color=240
errplot, s_0pnt30, (xis_LS_0pnt30-poisson_0pnt30), (xis_LS_0pnt30+poisson_0pnt30), $
         thick=4.0, color=240
xyouts, 10., 10., '<z>=0.49', charsize=1.2, charthick=4.2, color=240

plot, s, xis_q_full, $
      position=[0.42, 0.70, 0.70, 0.98], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[0.5, 300], yrange=[0.001, 99.], $ ; bring down to 500 w/o V. PREL.
      xstyle=1, ystyle=1, $
      charsize=2.2, charthick=4.2, $
      xtickformat='(a1)', $
      ytickformat='(a1)', $
      color=0
poisson_0pnt68 = (1.+xis_LS_0pnt68) * (sqrt(2./DD_0pnt68))
oplot,   s_0pnt68,  xis_LS_0pnt68, psym=8,      color=216
errplot, s_0pnt68, (xis_LS_0pnt68-poisson_0pnt68), (xis_LS_0pnt68+poisson_0pnt68), $
         thick=4.0, color=216
xyouts, 10., 10., '<z>=0.80', charsize=1.2, charthick=4.2, color=216

plot, s, xis_q_full, $
      position=[0.70, 0.70, 0.98, 0.98], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[0.5, 300], yrange=[0.001, 99.], $ ; bring down to 500 w/o V. PREL.
      xstyle=1, ystyle=1, $
      charsize=2.2, charthick=4.2, $
      xtickformat='(a1)', $
      ytickformat='(a1)', $
      color=0

poisson_0pnt92 = (1.+xis_LS_0pnt92) * (sqrt(2./DD_0pnt92))
oplot,   s_0pnt92, xis_LS_0pnt92, psym=8, color=192
errplot, s_0pnt92, (xis_LS_0pnt92-poisson_0pnt92), (xis_LS_0pnt92+poisson_0pnt92), $
            thick=4.0, color=192
xyouts, 10., 10., '<z>=1.03', charsize=1.2, charthick=4.2, color=192




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

!p.multi=0
device, /close
set_plot, 'X'

close, /all



end
