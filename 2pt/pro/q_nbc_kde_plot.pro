;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;                            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;           xi(s)            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;                            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



readcol, '../omega_rs/dat/k_output_jack_perl_full_newcor_v2_ed.dat',  $
        lg_s, s, xi, delta_xi, bin_DD, bind_DR, xi_LS, xi_HAM, bin_RR

readcol, '../omega_rs/dat/xis_variances_errors_LS_TRUE.dat', s_j, jack

jack = sqrt(jack)

;loadct, 5 ;STD GAMMA-II
loadct, 13 ;RAINBOW

set_plot, 'ps'
device, filename='xis_2SLAQ_LRG_QSOs_temp.ps', $
        xsize=8, ysize=8, xoffset=0, $
        yoffset=0.5+(10-8), /inches, /color
plot, s, xi_LS, /xlog, /ylog, $
      xrange=[0.08, 210], yrange=[0.01, 500.], xstyle=1, ystyle=1, color=0, $
      xtitle=' s / h!E-1!N Mpc', ytitle=' !7n(!3s)', $
      charsize=2.2, charthick=4.0, thick=4.0, $
      title='2SLAQ LRG !7n(!3s)'
;      title='2SLAQ LRG - QSO/SDSS DR5 '
errplot, s, (xi_LS-jack), (xi_LS+jack), thick=4.0 ;, color=128
xyouts, 0.15, 0.7, '2SLAQ LRG !7n!3!ILS!N!3(!3s)',charsize=2.2, charthick=4

oplot,   s,  xi, thick=2.8, color=42
xyouts, 0.15, 0.35, '2SLAQ LRG !7n!3(!3s)',charsize=2.2,charthick=4,color=42
oplot, s, xi_HAM, color=85
xyouts, 0.15, 0.175, '2SLAQ LRG !7n!3!IHam!N!3(!3s)',charsize=2.2, charthick=4, color=85


;readcol, 'temp.dat', xi
;readcol, 'k_2SLAQ_QSO_DR5_output_temp.dat', xi
;readcol, 'k_2SLAQ_QSO_output_temp.dat', xi
;readcol, 'k_2SLAQ_QSO_output_temp.dat', k, s, bin_DD, bin_DR, bin_QG, binQR, xi, xi_Q
;readcol, 'k_DR5_QSO_output_temp.dat', k, s, bin_DD, bin_DR, bin_QG, binQR, xi, xi_Q
readcol, 'k_DR5_output_temp.dat', k, s, bin_DD, bin_DR, bin_QG, binQR, xi, delta_xi, xi_Q
;
oplot,   s,  xi_Q, thick=2.8, color=172

;xyouts, 0.15, 0.02, '1507 2SLAQ+DR5 QSOs',charsize=2.2,charthick=4,color=172
xyouts, 0.15, 0.02, '800 2SLAQ QSOs !7n!3(!3s)',charsize=2.2,charthick=4,color=172
;xyouts, 0.15, 0.02, '710 DR5 Quasars !7n!3(!3s)',charsize=2.2,charthick=4,color=172

;oplot,   s,  xi_Q, thick=2.8, color=214
;xyouts, 0.15, 0.04, '2SLAQ LRG !7n!3(!3s)',charsize=2.2,charthick=4,color=214







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;                            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;             w(theta)       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;                            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;readcol, 'w_theta_files/w_theta_2SLAQ_FtF_errors_wp.dat', arcmin_wp, w_theta_2SLAQ_wp, delta_wp
;print
;print, 'READ-IN w_theta_files/w_theta_2SLAQ_FtF_errors_wp.dat'
;print
;readcol, 'w_theta_files/w_theta_2SLAQ_FtF_errors_wz_nocor.dat', $
;         arcmin_wz, w_theta_2SLAQ_wz_nocor, delta_wz_nocor
readcol, 'w_theta_files/w_theta_2SLAQ_Sam8_v3.dat', $ 
         degs_wz, arcmin_wz, blah2, w_theta_2SLAQ_wz_nocor, blah3, blah4, $
         delta_wz_nocor 
print
print, 'READ-IN w_theta_files/w_theta_2SLAQ_Sam8_v3.dat'
print

readcol, 'w_theta_2SLAQ_LRG_check.dat', k_theta, deg_2SLAQ_LRG, $
         arcmin_2SLAQ_LRG, bin_DD_theta, bin_DR_thetea, w_theta_2SLAQ_LRG
print
print, 'READ-IN w_theta_2SLAQ_LRG_check_temp.dat'
print




;readcol, 'w_theta_DR5_20070911.dat', k_theta, degs, arcmin, $
;readcol, 'w_theta_DR5_temp.dat', w_theta_QG
;readcol, 'w_theta_DR5_temp.dat', k_theta, degs, arcmin, $
readcol, 'w_theta_files/w_theta_DR5_quasars_bright.dat', $
         k_theta, degs, arcmin, $
         bin_QG_theta, bin_QR_theta, w_theta_QG_bri, delta_w_theta_QG_bri
print
print, 'READ-IN  w_theta_DR5_bright.dat'
print


readcol, 'w_theta_files/w_theta_DR5_quasars_faint.dat', $
         k_theta, degs, arcmin, $
         bin_QG_theta, bin_QR_theta, w_theta_QG_fai, delta_w_theta_QG_fai
print
print, 'READ-IN  w_theta_DR5_faint.dat'
print


readcol, 'w_theta_files/w_theta_DR5_quasars_brighthalf.dat', $
         k_theta, degs, arcmin, $
         bin_QG_theta, bin_QR_theta, w_theta_QG_brih, delta_w_theta_QG_brih
print
print, 'READ-IN  w_theta_DR5_brighthalf.dat'
print

readcol, 'w_theta_files/w_theta_DR5_quasars_fainthalf.dat', $
         k_theta, degs, arcmin, $
         bin_QG_theta, bin_QR_theta, w_theta_QG_faih, delta_w_theta_QG_faih
print
print, 'READ-IN  w_theta_DR5_fainthalf.dat'
print



;readcol, 'w_theta_2SLAQ_LRG_QSO_6246_5bins_withcor.dat', $
;readcol, 'w_theta_2SLAQ_LRG_QSO_6246_10bins.dat', $
;readcol, 'w_theta_DR5_temp.dat', $
readcol, 'w_theta_DR3_nbckde_temp_v2.dat', $
         k_theta, degs, arcmin, $
         bin_2QG_theta, bin_2QR_theta, w_theta_2QG, delta_w_theta_2QG
print
print, 'READ-IN  w_theta_2SLAQ_LRG_QSO_6246.dat'
print



read, sample, PROMPT='1) DR5 bright/faint    2) DR5 bright/faint halfs    3) 2SLAQ QSOs   4) FtFs '




tcks=replicate(' ', 10)

loadct, 3
set_plot, 'ps'
;device, filename='w_theta_NBC_KDE_temp.ps', xsize=8, ysize=8, xoffset=0, $
device, filename='w_theta_DR5_quasars_temp.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0.5+(10-8), /inches, /color

!P.MULTI = [0, 1, 2] 

plot, arcmin_wz, w_theta_2SLAQ_wz_nocor, /xlog, /ylog, $
      xrange=[0.01, 500], yrange=[0.001, 50], $
      xstyle=1, ystyle=1, color=0, $
      ytitle='w(!7h)!3', ytickformat='(f7.3)', $
      charsize=2.2, charthick=2.2, thick=2.2, $
      xtickname=tcks, $
      title='2SLAQ LRG-SDSS nbc-kde w(!7h)!3', $
      position=[0.25,0.35,0.9,0.9]

;oplot,   arcmin_wp,  w_theta_2SLAQ_wp, color=128, thick=2.8
;errplot, arcmin_wp, (w_theta_2SLAQ_wp-delta_wp), $
;                    (w_theta_2SLAQ_wp+delta_wp),color=128

oplot,   arcmin_wz,  w_theta_2SLAQ_wz_nocor, color=192, thick=2.8
;errplot, arcmin_wz, (w_theta_2SLAQ_wz_nocor-delta_wz_nocor),$
 ;                   (w_theta_2SLAQ_wz_nocor+delta_wz_nocor),color=192

oplot, (arcmin_2SLAQ_LRG), w_theta_2SLAQ_LRG, color=0, thick=2.2
;oplot, (10^((float(k_theta)-25.)/5.)*60.), w_theta_2SLAQ_LRG, color=0, thick=2.2
;errplot, arcmin_2SLAQ_LRG, (w_theta_2SLAQ_LRG-delta_w_2SLAQ), $
;                           (w_theta_2SLAQ_LRG+delta_w_2SLAQ),color=192a



if sample eq 1 then begin
   loadct, 6          ; prism   ;loadct, 13 ; rainbow  ;loadct, 5 ; std gamma-II
   oplot,   arcmin,  w_theta_QG_bri, color=32, thick=5. ,  psym=4
   errplot, arcmin, (w_theta_QG_bri-delta_w_theta_QG_bri),$
                    (w_theta_QG_bri+delta_w_theta_QG_bri),color=32
   xyouts, 10.0,5.0, 'bright 938',charsize=2.2,color=32,charthick=4
   
   
   oplot,   arcmin,  w_theta_QG_fai, color=96, thick=5.,  psym=4
   errplot, arcmin, (w_theta_QG_fai-delta_w_theta_QG_fai),$
                    (w_theta_QG_fai+delta_w_theta_QG_fai),color=96
   xyouts, 10.0,2.5, 'faint 1384',charsize=2.2,color=96,charthick=4
endif

if sample eq 2 then begin
   oplot,   arcmin,  w_theta_QG_brih, color=160, thick=5.,  psym=4
   errplot, arcmin, (w_theta_QG_brih-delta_w_theta_QG_brih),$
                    (w_theta_QG_brih+delta_w_theta_QG_brih),color=160
   xyouts, 10.0,1.25, 'bright half',charsize=2.2,color=160,charthick=4
   

   oplot,   arcmin,  w_theta_QG_faih, color=224, thick=5.,  psym=4
   errplot, arcmin, (w_theta_QG_faih-delta_w_theta_QG_faih),$
                    (w_theta_QG_faih+delta_w_theta_QG_faih),color=224
   xyouts, 10.0, 0.625, 'faint half',charsize=2.2,color=224,charthick=4
endif


if sample eq 3 then begin
   oplot,   arcmin,  w_theta_2QG, color=160, thick=5.,  psym=4
   errplot, arcmin, (w_theta_2QG-delta_w_theta_2QG),$
                    (w_theta_2QG+delta_w_theta_2QG),color=160
;   xyouts, 1.0, 2.5, '6242 2SLAQ QSOs',charsize=2.2,color=160,charthick=4
   xyouts, 1.0, 2.5, '9851 nbc kde',charsize=2.2,color=160,charthick=4
endif


loadct, 3
xyouts, 0.15,20.0, 'VERY PRELIMINARY!!',charsize=2.2,color=0,charthick=4
;xyouts, 0.15,160.0, '2SLAQ LRG w!Irz_nocor!N(!7h)!3 new',charsize=2.2,color=0,charthick=4
;xyouts, 0.15,80.0, '2SLAQ LRG w!Ip!N(!7h)!3',charsize=2.2,color=128,charthick=4
xyouts, 0.15,10.0, '2SLAQ LRG w!Irz_nocor!N(!7h)!3',charsize=2.2,color=192,charthick=4

;loadct, 1
;xyouts, 0.15,40.0, '9729 Quasars w(!7h)!3', charsize=2.2,color=128,charthick=4
;xyouts, 0.15,20.0, '1507 Quasars w(!7h)!3', charsize=2.2,color=128,charthick=4
;xyouts, 0.15,20.0, '800 2SLAQ QSOs w(!7h)!3', charsize=2.2,color=128,charthick=4
;xyouts, 0.15,20.0, '710 DR5 Quasars w(!7h)!3', charsize=2.2,color=128,charthick=4


plot, arcmin_wz, w_theta_2SLAQ_wz_nocor, $
      xrange=[0.01, 500], yrange=[-1., 1.], /xlog, $
      xstyle=1, ystyle=1, color=0, $
      ytitle='w(!7h)!3', ytickformat='(f7.3)', $
      charsize=2.2, charthick=2.2, thick=2.2, $
      position=[0.25,0.12,0.9,0.3], xtitle='!7h!3 / arcmin' 


oplot,   arcmin_wz,  w_theta_2SLAQ_wz_nocor, color=192, thick=2.8
;errplot, arcmin_wz, (w_theta_2SLAQ_wz_nocor-delta_wz_nocor),$
 ;                   (w_theta_2SLAQ_wz_nocor+delta_wz_nocor),color=192

oplot, arcmin_2SLAQ_LRG, w_theta_2SLAQ_LRG, color=0, thick=2.2
;errplot, arcmin_2SLAQ_LRG, (w_theta_2SLAQ_LRG-delta_w_2SLAQ),$
;                           (w_theta_2SLAQ_LRG+delta_w_2SLAQ),color=192


;loadct, 1
;loadct, 6 ; prism   ;loadct, 13 ; rainbow  ;loadct, 5 ; std gamma-II

if sample eq 1 then begin
   oplot,   arcmin,  w_theta_QG_bri, color=32, thick=5. ,  psym=4
   errplot, arcmin, (w_theta_QG_bri-delta_w_theta_QG_bri),$
            (w_theta_QG_bri+delta_w_theta_QG_bri),color=32
   
   oplot,   arcmin,  w_theta_QG_fai, color=96, thick=5.,  psym=4
   errplot, arcmin, (w_theta_QG_fai-delta_w_theta_QG_fai),$
            (w_theta_QG_fai+delta_w_theta_QG_fai),color=96
endif

if sample eq 2 then begin
   oplot,   arcmin,  w_theta_QG_brih, color=160, thick=5.,  psym=4
   errplot, arcmin, (w_theta_QG_brih-delta_w_theta_QG_brih),$
            (w_theta_QG_brih+delta_w_theta_QG_brih),color=160
   
   oplot,   arcmin,  w_theta_QG_faih, color=224, thick=5.,  psym=4
   errplot, arcmin, (w_theta_QG_faih-delta_w_theta_QG_faih),$
            (w_theta_QG_faih+delta_w_theta_QG_faih),color=224
endif


if sample eq 3 then begin
   oplot,   arcmin,  w_theta_2QG, color=160, thick=5.,  psym=4
   errplot, arcmin, (w_theta_2QG-delta_w_theta_2QG),$
                    (w_theta_2QG+delta_w_theta_2QG),color=160
endif




if sample eq 4 then begin

   readcol, readcol, 'w_theta_DR5_120to145.dat', $
            k_theta, degs, arcmin, $
            bin_QG_theta_a, bin_2QR_theta_a, w_theta_2QG_a, delta_w_theta_2QG_a
   
   readcol, readcol, 'w_theta_DR5_145to175.dat', $
            k_theta, degs, arcmin, $
            bin_2QG_theta_b, bin_2QR_theta_b, w_theta_2QG_b, delta_w_theta_2QG_b
   
   !P.MULTI = [0, 1, 2] 
   
   plot, arcmin, w_theta_2QG_a, /xlog, /ylog, $
         xrange=[0.01, 500], yrange=[0.001, 50], $
         xstyle=1, ystyle=1, color=0, $
         ytitle='w(!7h)!3', ytickformat='(f7.3)', $
         charsize=2.2, charthick=2.2, thick=2.2, $
         xtickname=tcks, $
         title='2SLAQ LRG-SDSS nbc-kde w(!7h)!3', $
         position=[0.25,0.35,0.9,0.9]
   
   oplot,   arcmin,  w_theta_2QG_b, color=160, thick=5.,  psym=4
   
   plot, arcmin_wz, w_theta_2SLAQ_wz_nocor, $
         xrange=[0.01, 500], yrange=[-1., 1.], /xlog, $
         xstyle=1, ystyle=1, color=0, $
         ytitle='w(!7h)!3', ytickformat='(f7.3)', $
         charsize=2.2, charthick=2.2, thick=2.2, $
         position=[0.25,0.12,0.9,0.3], xtitle='!7h!3 / arcmin' 
   
   oplot,   arcmin,  w_theta_2QG_b, color=160, thick=5.
;  oplot,   arcmin,  w_theta_2QG_c, color=160, thick=5.
;  oplot,   arcmin,  w_theta_2QG_d, color=160, thick=5.
;  oplot,   arcmin,  w_theta_2QG_e, color=160, thick=5.
   
   !P.MULTI = [0] 

endif







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;                            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;     w(theta)   lin         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;                            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


loadct, 3
set_plot, 'ps'
device, filename='w_theta_DR5_quasars_lin_temp.ps', xsize=8, ysize=8, xoffset=0, $
        yoffset=0.5+(10-8), /inches, /color

plot, arcmin_wz, w_theta_2SLAQ_wz_nocor, $
      xrange=[0.01, 500], yrange=[-0.1, 0.1], /xlog, xstyle=1, ystyle=1, color=0, $
      ytitle='w(!7h)!3', ytickformat='(f7.3)', charsize=2.2, charthick=2.2, thick=2.2, $
      title='2SLAQ LRG-SDSS nbc-kde w(!7h)!3', $
      position=[0.25,0.25,0.9,0.9], xtitle='!7h!3 / arcmin' 

oplot,   arcmin_wz,  w_theta_2SLAQ_wz_nocor, color=192, thick=2.8
errplot, arcmin_wz, (w_theta_2SLAQ_wz_nocor-delta_wz_nocor),$
                  (w_theta_2SLAQ_wz_nocor+delta_wz_nocor),color=192

oplot, arcmin_2SLAQ_LRG, w_theta_2SLAQ_LRG, color=0, thick=2.2
;errplot, arcmin_2SLAQ_LRG, (w_theta_2SLAQ_LRG-delta_w_2SLAQ),$
;                           (w_theta_2SLAQ_LRG+delta_w_2SLAQ),color=192

loadct, 1
oplot,   arcmin,  w_theta_QG_bri, color=128, thick=5., psym=4
errplot, arcmin, (w_theta_QG_bri-(delta_w_theta_QG_bri*3.)), $
                 (w_theta_QG_bri+(delta_w_theta_QG_bri*3.0)),color=128


loadct, 3
xyouts, 0.15,160.0, 'VERY PRELIMINARY!!',charsize=2.2,color=0,charthick=4
;xyouts, 0.15,160.0, '2SLAQ LRG w!Irz_nocor!N(!7h)!3 new',charsize=2.2,color=0,charthick=4
xyouts, 0.15,80.0, '2SLAQ LRG w!Ip!N(!7h)!3',charsize=2.2,color=128,charthick=4
xyouts, 0.15,40.0, '2SLAQ LRG w!Irz_nocor!N(!7h)!3',charsize=2.2,color=192,charthick=4
loadct, 1
xyouts, 0.15,20.0, '9729 Quasars w(!7h)!3', charsize=2.2,color=128,charthick=4
;xyouts, 0.15,20.0, '1507 Quasars w(!7h)!3', charsize=2.2,color=128,charthick=4
;xyouts, 0.15,20.0, '800 2SLAQ QSOs w(!7h)!3', charsize=2.2,color=128,charthick=4
;xyouts, 0.15,20.0, '710 DR5 Quasars w(!7h)!3', charsize=2.2,color=128,charthick=4



device, /close
close, /all






end
