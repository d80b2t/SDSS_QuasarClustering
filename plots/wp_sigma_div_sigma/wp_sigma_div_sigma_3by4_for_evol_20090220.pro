;;+
;;
;;  The ``3x4'' plot to show the (evolution of) wp(rp) / rp 
;;  for each redshift subsample
;;
;;-


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;
;;    wp(sigma)/sigma,   the usual, log-log plot
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

readcol, '../../OP/OP_20080508/K_wp_output_UNI22.dat', $
         sigma_full, lg_sigma, Xi_sigma, delta_Xi_sigma, $
         DD_full, DR, Xi_sigma_HAM, Xi_sigma_LS_full, /silent
;sigma, s, xis_std, delta_xis, DD, DR, RR, Xi_sigma_LS, Xi_sigma_HAM, ratio 
print, 'SDSS Quasar xi(s) read-in, K_wp_output_UNI22'
print


wpsigma_div_sigma = Xi_sigma_LS_full / sigma_full

;; Poisson errors     
poisson = (1.+Xi_sigma_LS_full)*(sqrt(2./DD_full)) 


readcol, '../../jackknife/wp_sigma/K_wp_output_UNI22_jackknife_errors.dat', $
         i_bin, j_bin, COV_ii, jack, /silent
print, 'READ in jackknife/wp_sigma/K_wp_output_UNI22_jackknife_errors.dat', n_elements(jack)
print
print

err_ratio = jack / poisson

plot_error2 = 'n'
;read, plot_error2, PROMPT='Plot the geometric mean errors?  '


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; I N P U T    F I L E S
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 0.00 < z < 0.30 
readcol, "../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt00z0pnt30.dat", $
         sigma_0pnt00, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt00, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt00, /silent 
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt00z0pnt30.dat read-in ', $
       n_elements(sigma_0pnt00)
readcol, "../../OP/UNI22_evol_wpsigma/rv2/K_wp_output_UNI22_0pnt00z0pnt30_rv2.dat", $
;readcol, "../../OP/OP_UNI22_noDDv2/K_wp_output_UNI22_0pnt00z0pnt30_noDD_v2.dat", $
         sigma_0pnt00v2, lg_sigma, Xi_sigma, delta_0pnt00_v2, DD_0pnt00v2, DR, $
         Xi_sigma_HAMv2, Xi_sigma_LS_0pnt00v2, /silent 
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt00z0pnt30_noDD_v2.dat (', $
       n_elements(sigma_0pnt00v2), ')'

;; 0.30 < z < 0.68 
readcol, "../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt30z0pnt68.dat", $
         sigma_0pnt30, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt30, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt30, /silent 
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt30z0pnt68.dat read-in ', $
       n_elements(sigma_0pnt30)
readcol, "../../OP/UNI22_evol_wpsigma/rv2/K_wp_output_UNI22_0pnt30z0pnt68_rv2.dat", $
;readcol, "../../OP/OP_UNI22_noDDv2/K_wp_output_UNI22_0pnt30z0pnt68_noDD_v2.dat", $
         sigma_0pnt30v2, lg_sigma, Xi_sigma, delta_0pnt30_v2, DD_0pnt30v2, DR, $
         Xi_sigma_HAMv2, Xi_sigma_LS_0pnt30v2, /silent 
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt30z0pnt68_noDD_v2.dat (', $
       n_elements(sigma_0pnt00v2), ')'

;; 0.68 < z < 0.92
readcol, "../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt68z0pnt92.dat", $
         sigma_0pnt68, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt68, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt68, /silent
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt68z0pnt92.dat read-in ', $
       n_elements(sigma_0pnt68)
readcol, "../../OP/UNI22_evol_wpsigma/rv2/K_wp_output_UNI22_0pnt68z0pnt92_rv2.dat", $
;readcol, "../../OP/OP_UNI22_noDDv2/K_wp_output_UNI22_0pnt68z0pnt92_noDD_v2.dat", $
         sigma_0pnt68v2, lg_sigma, Xi_sigma, delta_0pnt68_v2, DD_0pnt68v2, DR, $
         Xi_sigma_HAMv2, Xi_sigma_LS_0pnt68v2, /silent 
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt68z0pnt92_noDD_v2.dat (', $
       n_elements(sigma_0pnt68v2), ')'
;;--------------------------------------------------------------------------------------------

;; 0.92 < z < 1.13 
readcol, "../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt92z1pnt13.dat", $
         sigma_0pnt92, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt92, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt92, /silent
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt92z1pnt13.dat read-in ', $
       n_elements(sigma_0pnt92)
readcol, "../../OP/UNI22_evol_wpsigma/rv2/K_wp_output_UNI22_0pnt92z1pnt13_rv2.dat", $
;readcol, "../../OP/OP_UNI22_noDDv2/K_wp_output_UNI22_0pnt92z1pnt13_noDD_v2.dat", $
         sigma_0pnt92v2, lg_sigma, Xi_sigma, delta_0pnt92_v2, DD_0pnt92v2, DR, $
         Xi_sigma_HAMv2, Xi_sigma_LS_0pnt92v2, /silent 
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt92z0pnt92_noDD_v2.dat (', $
       n_elements(sigma_0pnt92v2), ')'
print

;; 1.13 < z < 1.32
readcol, "../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt13z1pnt32.dat", $
         sigma_1pnt13, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt13, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt13, /silent
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt13z1pnt32.dat read-in ', $
       n_elements(sigma_1pnt13)
readcol, "../../OP/UNI22_evol_wpsigma/rv2/K_wp_output_UNI22_1pnt13z1pnt32_rv2.dat", $
;readcol, "../../OP/OP_UNI22_noDDv2/K_wp_output_UNI22_1pnt13z1pnt32_noDD_v2.dat", $
         sigma_1pnt13v2, lg_sigma, Xi_sigma, delta_1pnt13_v2, DD_1pnt13v2, DR, $
         Xi_sigma_HAMv2, Xi_sigma_LS_1pnt13v2, /silent 
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt13z1pnt32_noDD_v2.dat (', $
       n_elements(sigma_1pnt13v2), ')'

;; 1.32 < z < 1.50
readcol, "../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt32z1pnt50.dat", $
         sigma_1pnt32, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt32, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt32, /silent
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt32z1pnt50.dat read-in ', $
       n_elements(sigma_1pnt32)
readcol, "../../OP/UNI22_evol_wpsigma/rv2/K_wp_output_UNI22_1pnt32z1pnt50_rv2.dat", $
;readcol, "../../OP/OP_UNI22_noDDv2/K_wp_output_UNI22_1pnt32z1pnt50_noDD_v2.dat", $
         sigma_1pnt32v2, lg_sigma, Xi_sigma, delta_1pnt32_v2, DD_1pnt32v2, DR, $
         Xi_sigma_HAMv2, Xi_sigma_LS_1pnt32v2, /silent 
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt32z1pnt50_noDD_v2.dat (', $
       n_elements(sigma_1pnt32v2), ')'
;;--------------------------------------------------------------------------------------------


;; 1.50 < z < 1.66
readcol, "../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt50z1pnt66.dat", $
         sigma_1pnt50, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt50, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt50, /silent
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt50z1pnt66.dat read-in ', $
       n_elements(sigma_1pnt50)
readcol, "../../OP/UNI22_evol_wpsigma/rv2/K_wp_output_UNI22_1pnt50z1pnt66_rv2.dat", $
;readcol, "../../OP/OP_UNI22_noDDv2/K_wp_output_UNI22_1pnt50z1pnt66_noDD_v2.dat", $
         sigma_1pnt50v2, lg_sigma, Xi_sigma, delta_1pnt50_v2, DD_1pnt50v2, DR, $
         Xi_sigma_HAMv2, Xi_sigma_LS_1pnt50v2, /silent 
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt50z1pnt66_noDD_v2.dat (', $
       n_elements(sigma_1pnt50v2), ')'
print

;; 1.66 < z < 1.83
readcol, "../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt66z1pnt83.dat", $
         sigma_1pnt66, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt66, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt66, /silent
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt66z1pnt83.dat read-in ', $
       n_elements(sigma_1pnt66)
readcol, "../../OP/UNI22_evol_wpsigma/rv2/K_wp_output_UNI22_1pnt66z1pnt83_rv2.dat", $
;readcol, "../../OP/OP_UNI22_noDDv2/K_wp_output_UNI22_1pnt66z1pnt83_noDD_v2.dat", $
         sigma_1pnt66v2, lg_sigma, Xi_sigma, delta_1pnt66_v2, DD_1pnt66v2, DR, $
         Xi_sigma_HAMv2, Xi_sigma_LS_1pnt66v2, /silent 
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt66z1pnt83_noDD_v2.dat (', $
       n_elements(sigma_1pnt50v2), ')'

;; 1.83 < z < 2.02
readcol, "../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt83z2pnt02.dat", $
         sigma_1pnt83, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt83, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt83, /silent
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt83z2pnt02.dat read-in ', $
       n_elements(sigma_1pnt83)
readcol, "../../OP/UNI22_evol_wpsigma/rv2/K_wp_output_UNI22_1pnt83z2pnt02_rv2.dat", $
;readcol, "../../OP/OP_UNI22_noDDv2/K_wp_output_UNI22_1pnt83z2pnt02_noDD_v2.dat", $
         sigma_1pnt83v2, lg_sigma, Xi_sigma, delta_1pnt83_v2, DD_1pnt83v2, DR, $
         Xi_sigma_HAMv2, Xi_sigma_LS_1pnt83v2, /silent 
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt83z2pnt02_noDD_v2.dat (', $
       n_elements(sigma_1pnt50v2), ')'

;;--------------------------------------------------------------------------------------------
;; 2.2 < z < 2.20
readcol, "../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_2pnt02z2pnt20.dat", $
         sigma_2pnt02, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_2pnt02, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_2pnt02, /silent
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_2pnt02z2pnt20.dat read-in ', $
       n_elements(sigma_2pnt02)
readcol, "../../OP/UNI22_evol_wpsigma/rv2/K_wp_output_UNI22_2pnt02z2pnt20_rv2.dat", $
;readcol, "../../OP/OP_UNI22_noDDv2/K_wp_output_UNI22_2pnt02z2pnt20_noDD_v2.dat", $
         sigma_2pnt02v2, lg_sigma, Xi_sigma, delta_2pnt02_v2, DD_2pnt02v2, DR, $
         Xi_sigma_HAMv2, Xi_sigma_LS_2pnt02v2, /silent 
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_2pnt02z2pnt20_noDD_v2.dat (', $
       n_elements(sigma_2pnt02v2), ')'

;; 2.20 < z < 2.90
readcol, "../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_2pnt20z2pnt90.dat", $
         sigma_2pnt20, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_2pnt20, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_2pnt20, /silent
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_2pnt20z2pnt90.dat read-in ', $
       n_elements(sigma_2pnt20)
readcol, "../../OP/UNI22_evol_wpsigma/rv2/K_wp_output_UNI22_2pnt20z2pnt90_rv2.dat", $
;readcol, "../../OP/OP_UNI22_noDDv2/K_wp_output_UNI22_2pnt20z2pnt90_noDD_v2.dat", $
         sigma_2pnt20v2, lg_sigma, Xi_sigma, delta_2pnt20_v2, DD_2pnt20v2, DR, $
         Xi_sigma_HAMv2, Xi_sigma_LS_2pnt20v2, /silent 
print, 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_2pnt20z2pnt90_noDD_v2.dat (', $
       n_elements(sigma_2pnt20v2), ')'
print
;;--------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------



plotsym,0, 0.75, /fill
;x_range_min=0.199
x_range_min=0.399
x_range_max=250.
y_range_min=0.00101
y_range_max=999.


loadct, 6                       ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='wp_sigma_div_sigma_DR5_quasars_3by4_for_evol_temp.eps', $
        xsize=8.6, ysize=8.5, $
        /encapsulated, $
        xoffset=0.1, yoffset=0.2, /inches, /color

!p.multi=[0,3,4]

plotsym, 0, 1.0, /fill


;;  TOP ROW    TOP ROW    TOP ROW    TOP ROW    TOP ROW    TOP ROW
;;  TOP ROW    TOP ROW    TOP ROW    TOP ROW    TOP ROW    TOP ROW
;;  TOP ROW    TOP ROW    TOP ROW    TOP ROW    TOP ROW    TOP ROW
;;
;;  0.00 < z < 0.30
;;
plot, sigma_full, wpsigma_div_sigma, $
      position=[0.14, 0.77, 0.42, 0.98], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $ 
      xstyle=1, ystyle=1, $
      thick=2.2, $
      xthick=2.2, ythick=2.2, $
      charsize=2.7, charthick=4.2, $
      xtickformat='(a1)', $
      ytitle=' w!Ip!N(!3r!Ip!N)/!3r!Ip!3 ', $
      ytickformat='(f6.2)', $
      color=0
xyouts, 10., 100., '<z>=0.25', charsize=1.2, charthick=4.2,    color=0 ;240

wpsigma_div_sigma_0pnt00   = Xi_sigma_LS_0pnt00   / sigma_0pnt00
wpsigma_div_sigma_0pnt00v2 = Xi_sigma_LS_0pnt00v2 / sigma_0pnt00v2

poisson_0pnt00             = (1.+Xi_sigma_LS_0pnt00) * (sqrt(2./DD_0pnt00))

error_0pnt00               = poisson_0pnt00 * err_ratio
error_0pnt00_div_sigma     = error_0pnt00 / sigma_0pnt00

error2_0pnt00              = findgen(n_elements( poisson_0pnt00))
;; When checking the jackknife:poission error ratios for wp(rp) for the
;; full sample, saw that the Poisson underestimated the errors badly
;; (factor of ~5) for rp <10, and very badly (~20 to ~100!!) times
;; for the larger scales. 
;; Sidenote: One day, CF errors in the low N regime, really should be
;; gone back to and more throughly investigated!!
;; 
;; For below, 45 is the geometric mean of the min and max of:
;; w = where(sigma gt 10, N)  &   print, err_ratio[w]

w = where(sigma_0pnt00 lt 10, N)
error2_0pnt00[w]              = poisson_0pnt00[w] * 5.
w = where(sigma_0pnt00 gt 10, N)
error2_0pnt00[w]              = poisson_0pnt00[w] * 45.
error2_div_sigma_0pnt00       = error2_0pnt00 / sigma_0pnt00

plotsym, 0, 1.0, /fill, thick=2
oplot,   sigma_0pnt00,  wpsigma_div_sigma_0pnt00, psym=8,      color=0 
errplot, sigma_0pnt00, $
         (wpsigma_div_sigma_0pnt00-error_0pnt00_div_sigma), $
         (wpsigma_div_sigma_0pnt00+error_0pnt00_div_sigma), $
         thick=2.0,                linestyle=0, color=0

error3                      = (delta_0pnt00_v2     /sigma_0pnt00v2)
plotsym, 0, 1.0, thick=2
oplot,   sigma_0pnt00v2,  wpsigma_div_sigma_0pnt00v2, psym=8,      color=128  ;240
errplot, sigma_0pnt00v2, $
         (wpsigma_div_sigma_0pnt00v2-error3), $
         (wpsigma_div_sigma_0pnt00v2+error3), $
         thick=3.0,       linestyle=1,                        color=128 ;240

if plot_error2 eq 'y' then begin
errplot, sigma_0pnt00, $
         (wpsigma_div_sigma_0pnt00-error2_div_sigma_0pnt00), $
         (wpsigma_div_sigma_0pnt00+error2_div_sigma_0pnt00), $
         thick=2.0,                linestyle=1, color=128
endif




;;
;;  0.30 < z < 0.68
;;
plot, sigma_full, wpsigma_div_sigma, $
      position=[0.42, 0.77, 0.70, 0.98], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $ 
      xstyle=1, ystyle=1, $
      thick=2.2, $
      xthick=2.2, ythick=2.2, $
      charsize=2.7, charthick=4.2, $
      xtickformat='(a1)', $
      ytickformat='(a1)', $
      color=0
xyouts, 10., 100., '<z>=0.49', charsize=1.2, charthick=4.2,    color=0 ;240

wpsigma_div_sigma_0pnt30   = Xi_sigma_LS_0pnt30/sigma_0pnt30
wpsigma_div_sigma_0pnt30v2 = (Xi_sigma_LS_0pnt30v2 /sigma_0pnt30v2)

poisson_0pnt30           = (1.+Xi_sigma_LS_0pnt30) * (sqrt(2./DD_0pnt30))

error_0pnt30             = poisson_0pnt30 * err_ratio
error_0pnt30_div_sigma   = error_0pnt30 / sigma_0pnt30

error2_0pnt30            = findgen(n_elements( poisson_0pnt30))
w = where(sigma_0pnt30 lt 10, N)
error2_0pnt30[w]          = poisson_0pnt30[w] * 5.
w = where(sigma_0pnt30 gt 10, N)
error2_0pnt30[w]          = poisson_0pnt30[w] * 45.
error2_div_sigma_0pnt30   = error2_0pnt30 / sigma_0pnt30

plotsym, 0, 1.0, /fill, thick=2
oplot,   sigma_0pnt30,  wpsigma_div_sigma_0pnt30, psym=8,      color=0 ;240
errplot, sigma_0pnt30, $
         (wpsigma_div_sigma_0pnt30-error_0pnt30_div_sigma), $
         (wpsigma_div_sigma_0pnt30+error_0pnt30_div_sigma), $
         thick=2.0,       linestyle=0,                        color=0 ;240

error3                      = (delta_0pnt30_v2     /sigma_0pnt30v2)
plotsym, 0, 1.0, thick=2
oplot,   sigma_0pnt30v2,  wpsigma_div_sigma_0pnt30v2, psym=8,      color=128  ;240
errplot, sigma_0pnt30v2, $
         (wpsigma_div_sigma_0pnt30v2-error3), $
         (wpsigma_div_sigma_0pnt30v2+error3), $
         thick=3.0,       linestyle=1,                        color=128 ;240

if plot_error2 eq 'y' then begin
errplot, sigma_0pnt30, $
         (wpsigma_div_sigma_0pnt30-error2_div_sigma_0pnt30), $
         (wpsigma_div_sigma_0pnt30+error2_div_sigma_0pnt30), $
         thick=2.0,   linestyle=1, color=128 
endif


;;
;;  0.68 < z < 0.92 
;;
plot, sigma_full, wpsigma_div_sigma, $
      position=[0.70, 0.77, 0.98, 0.98], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $ 
      xstyle=1, ystyle=1, $
      thick=2.2, $
      xthick=2.2, ythick=2.2, $
      charsize=2.7, charthick=4.2, $
      xtickformat='(a1)', $
      ytickformat='(a1)', $
      color=0

wpsigma_div_sigma_0pnt68   = Xi_sigma_LS_0pnt68   / sigma_0pnt68
wpsigma_div_sigma_0pnt68v2 = Xi_sigma_LS_0pnt68v2 / sigma_0pnt68v2

poisson_0pnt68             = (1.+Xi_sigma_LS_0pnt68) * (sqrt(2./DD_0pnt68))

error_0pnt68               = poisson_0pnt68 * err_ratio
error_0pnt68_div_sigma     = error_0pnt68 / sigma_0pnt68

error2_0pnt68            = findgen(n_elements( poisson_0pnt68))
w = where(sigma_0pnt68 lt 10, N)
error2_0pnt68[w]         = poisson_0pnt68[w] * 5.
w = where(sigma_0pnt68 gt 10, N)
error2_0pnt68[w]         = poisson_0pnt68[w] * 45.
error2_div_sigma_0pnt68  = error2_0pnt68 / sigma_0pnt68


plotsym, 0, 1.0, /fill, thick=2
oplot,   sigma_0pnt68,  wpsigma_div_sigma_0pnt68, psym=8,      color=0; 216
errplot, sigma_0pnt68, $
         (wpsigma_div_sigma_0pnt68-error_0pnt68_div_sigma), $
         (wpsigma_div_sigma_0pnt68+error_0pnt68_div_sigma), $
         thick=2.0,          linestyl=0,                       color=0; 216
xyouts, 10., 100., '<z>=0.80', charsize=1.2, charthick=4.2,    color=0; 216

error3                      = (delta_0pnt68_v2     /sigma_0pnt68v2)
plotsym, 0, 1.0,  thick=2
oplot,   sigma_0pnt68v2,  wpsigma_div_sigma_0pnt68v2, psym=8,      color=128 ;240
errplot, sigma_0pnt68v2, $
         (wpsigma_div_sigma_0pnt68v2-error3), $
         (wpsigma_div_sigma_0pnt68v2+error3), $
         thick=3.0,       linestyle=1,   color=128

if plot_error2 eq 'y' then begin
errplot, sigma_0pnt68, $
         (wpsigma_div_sigma_0pnt68-error2_div_sigma_0pnt68), $
         (wpsigma_div_sigma_0pnt68+error2_div_sigma_0pnt68), $
         thick=2.0,   linestyle=1, color=128 
endif


;; 
;;  ``TOP MIDDLE''  ROW
;;
;;  0.92 < z < 1.13 
;;
plot, sigma_full,  wpsigma_div_sigma, $
      position=[0.14, 0.56, 0.42, 0.77], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $ 
      xstyle=1, ystyle=1, $
      thick=2.2, $
      xthick=2.2, ythick=2.2, $
      charsize=2.7, charthick=4.2, $
      xtickformat='(a1)', $
      ytitle=' w!Ip!N(!3r!Ip!N)/!3r!Ip!3 ', $
      ytickformat='(f6.2)', $
      color=0

wpsigma_div_sigma_0pnt92   = Xi_sigma_LS_0pnt92   / sigma_0pnt92
wpsigma_div_sigma_0pnt92v2 = Xi_sigma_LS_0pnt92v2 / sigma_0pnt92v2

poisson_0pnt92             = (1.+Xi_sigma_LS_0pnt92) * (sqrt(2./DD_0pnt92))

error_0pnt92               = poisson_0pnt92 * err_ratio
error_0pnt92_div_sigma     = error_0pnt92 / sigma_0pnt92

error2_0pnt92            = findgen(n_elements( poisson_0pnt92))
w = where(sigma_0pnt92 lt 10, N)
error2_0pnt92[w]         = poisson_0pnt92[w] * 5.
w = where(sigma_0pnt92 gt 10, N)
error2_0pnt92[w]         = poisson_0pnt92[w] * 45.
error2_div_sigma_0pnt92  = error2_0pnt92 / sigma_0pnt92

plotsym, 0, 1.0, /fill, thick=2
oplot,   sigma_0pnt92,  wpsigma_div_sigma_0pnt92, psym=8,     color=0 ;192
errplot, sigma_0pnt92, $
         (wpsigma_div_sigma_0pnt92-error_0pnt92_div_sigma), $
         (wpsigma_div_sigma_0pnt92+error_0pnt92_div_sigma), $
         thick=2.0,             linestyle=0,                  color=0 ;192
xyouts, 10., 100., '<z>=1.03', charsize=1.2, charthick=4.2,   color=0 ;192

error3                   = (delta_0pnt92_v2     /sigma_0pnt92v2)
plotsym, 0, 1.0,  thick=2
oplot,   sigma_0pnt92v2, wpsigma_div_sigma_0pnt92v2, psym=8,      color=128 ;240
errplot, sigma_0pnt92v2, $
         (wpsigma_div_sigma_0pnt92v2-error3), $
         (wpsigma_div_sigma_0pnt92v2+error3), $
         thick=3.0,       linestyle=1,   color=128

if plot_error2 eq 'y' then begin
errplot, sigma_0pnt92, $
         (wpsigma_div_sigma_0pnt92-error2_div_sigma_0pnt92), $
         (wpsigma_div_sigma_0pnt92+error2_div_sigma_0pnt92), $
         thick=2.0,   linestyle=1, color=128 
endif


;;
;;  1.13 < z < 1.32 
;;
plot, sigma_full,  wpsigma_div_sigma, $
      position=[0.42, 0.56, 0.70, 0.77], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $ 
      xstyle=1, ystyle=1, $
      thick=2.2,$
      xthick=2.2, ythick=2.2, $
      charsize=2.7, charthick=4.2, $
      xtickformat='(a1)', $
      ytickformat='(a1)', $
      color=0
wpsigma_div_sigma_1pnt13   = Xi_sigma_LS_1pnt13   / sigma_1pnt13
wpsigma_div_sigma_1pnt13v2 = Xi_sigma_LS_1pnt13v2 / sigma_1pnt13v2

poisson_1pnt13 = (1.+Xi_sigma_LS_1pnt13) * (sqrt(2./DD_1pnt13))

error_1pnt13             = poisson_1pnt13 * err_ratio
error_1pnt13_div_sigma   = error_1pnt13 / sigma_1pnt13

error2_1pnt13            = findgen(n_elements( poisson_1pnt13))
w = where(sigma_1pnt13 lt 10, N)
error2_1pnt13[w]         = poisson_1pnt13[w] * 5.
w = where(sigma_1pnt13 gt 10, N)
error2_1pnt13[w]         = poisson_1pnt13[w] * 45.
error2_div_sigma_1pnt13  = error2_1pnt13 / sigma_1pnt13

plotsym, 0, 1.0, /fill, thick=2
oplot,   sigma_1pnt13,  wpsigma_div_sigma_1pnt13, psym=8,      color=0 ;168
errplot, sigma_1pnt13, $
         (wpsigma_div_sigma_1pnt13-error_1pnt13_div_sigma), $
         (wpsigma_div_sigma_1pnt13+error_1pnt13_div_sigma), $
         thick=2.0,              linestyle=0,                  color=0 ;168
xyouts, 10., 100., '<z>=1.23', charsize=1.2, charthick=4.2,    color=0 ;168

error3                      = (delta_1pnt13_v2  /sigma_1pnt13v2)
plotsym, 0, 1.0, thick=2
oplot,   sigma_1pnt13v2,  wpsigma_div_sigma_1pnt13v2, psym=8,      color=128  ;240
errplot, sigma_1pnt13v2, $
         (wpsigma_div_sigma_1pnt13v2-error3), $
         (wpsigma_div_sigma_1pnt13v2+error3), $
         thick=3.0,       linestyle=1,                        color=128 ;240

if plot_error2 eq 'y' then begin
errplot, sigma_1pnt13, $
         (wpsigma_div_sigma_1pnt13-error2_div_sigma_1pnt13), $
         (wpsigma_div_sigma_1pnt13+error2_div_sigma_1pnt13), $
         thick=2.0,   linestyle=1, color=128 
endif


;;
;; 1.32 < z < 1.50  
;;
plot, sigma_full, wpsigma_div_sigma, $
      position=[0.70, 0.56, 0.98, 0.77], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $ 
      xstyle=1, ystyle=1, $
      thick=2.2, $
      xthick=2.2, ythick=2.2, $
      charsize=2.7, charthick=4.2, $
      xtickformat='(a1)', $
      ytickformat='(a1)', $
      color=0

wpsigma_div_sigma_1pnt32   = Xi_sigma_LS_1pnt32   / sigma_1pnt32
wpsigma_div_sigma_1pnt32v2 = Xi_sigma_LS_1pnt32v2 / sigma_0pnt30v2

poisson_1pnt32           = (1.+Xi_sigma_LS_1pnt32) * (sqrt(2./DD_1pnt32))

error_1pnt32             = poisson_1pnt32 * err_ratio
error_1pnt32_div_sigma   = error_1pnt32 / sigma_1pnt32

error2_1pnt32            = findgen(n_elements( poisson_1pnt32))
w = where(sigma_1pnt32 lt 10, N)
error2_1pnt32[w]         = poisson_1pnt32[w] * 5.
w = where(sigma_1pnt32 gt 10, N)
error2_1pnt32[w]         = poisson_1pnt32[w] * 45.
error2_div_sigma_1pnt32  = error2_1pnt32 / sigma_1pnt32

plotsym, 0, 1.0, /fill, thick=2
oplot,   sigma_1pnt32,  wpsigma_div_sigma_1pnt32, psym=8,      color=0 ;144
errplot, sigma_1pnt32, $
         (wpsigma_div_sigma_1pnt32-error_1pnt32_div_sigma), $
         (wpsigma_div_sigma_1pnt32+error_1pnt32_div_sigma), $
         thick=2.0,                linestyle=0,                color=0 ;144
xyouts, 10., 100., '<z>=1.41', charsize=1.2, charthick=4.2,    color=0 ;144

error3                      = (delta_1pnt32_v2     /sigma_1pnt32v2)
plotsym, 0, 1.0, thick=2
oplot,   sigma_1pnt32v2,  wpsigma_div_sigma_1pnt32v2, psym=8,      color=128  ;240
errplot, sigma_1pnt32v2, $
         (wpsigma_div_sigma_1pnt32v2-error3), $
         (wpsigma_div_sigma_1pnt32v2+error3), $
         thick=3.0,       linestyle=1,                        color=128 ;240

if plot_error2 eq 'y' then begin
errplot, sigma_1pnt32, $
         (wpsigma_div_sigma_1pnt32-error2_div_sigma_1pnt32), $
         (wpsigma_div_sigma_1pnt32+error2_div_sigma_1pnt32), $
         thick=2.0,   linestyle=1, color=128 
endif

;;
;; ``BOTTOM MIDDLE'' PANELS
;;
;; 1.50  < z < 1.66
;;
plot, sigma_full, wpsigma_div_sigma, $
      position=[0.14, 0.35, 0.42, 0.56], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $ 
      xstyle=1, ystyle=1, $
      thick=2.2, $
      xthick=2.2, ythick=2.2, $
      charsize=2.7, charthick=4.2, $
      xtickformat='(a1)', $
      ytitle=' w!Ip!N(!3r!Ip!N)/!3r!Ip!3 ', $
      ytickformat='(f6.2)', $
      color=0

wpsigma_div_sigma_1pnt50   = Xi_sigma_LS_1pnt50   / sigma_1pnt50
wpsigma_div_sigma_1pnt50v2 = Xi_sigma_LS_1pnt50v2 / sigma_1pnt50v2

poisson_1pnt50           = (1.+Xi_sigma_LS_1pnt50) * (sqrt(2./DD_1pnt50))

error_1pnt50             = poisson_1pnt50 * err_ratio
error_1pnt50_div_sigma   = error_1pnt50 / sigma_1pnt50

error2_1pnt50            = findgen(n_elements( poisson_1pnt50))
w = where(sigma_1pnt50 lt 10, N)
error2_1pnt50[w]         = poisson_1pnt50[w] * 5.
w = where(sigma_1pnt50 gt 10, N)
error2_1pnt50[w]         = poisson_1pnt50[w] * 45.
error2_div_sigma_1pnt50  = error2_1pnt50 / sigma_1pnt50

plotsym, 0, 1.0, /fill, thick=2
oplot,   sigma_1pnt50,  wpsigma_div_sigma_1pnt50, psym=8,      color=0 ;120
errplot, sigma_1pnt50, $
         (wpsigma_div_sigma_1pnt50-error_1pnt50_div_sigma), $
         (wpsigma_div_sigma_1pnt50+error_1pnt50_div_sigma), $
         thick=2.0,              linestyle=0,                  color=0 ;120
xyouts, 10., 100., '<z>=1.58', charsize=1.2, charthick=4.2,    color=0 ;120

error3                      = (delta_1pnt50_v2     /sigma_1pnt50v2)
plotsym, 0, 1.0, thick=2
oplot,   sigma_1pnt50v2,  wpsigma_div_sigma_1pnt50v2, psym=8,      color=128  ;240
errplot, sigma_1pnt50v2, $
         (wpsigma_div_sigma_1pnt50v2-error3), $
         (wpsigma_div_sigma_1pnt50v2+error3), $
         thick=3.0,       linestyle=1,                        color=128 ;240

if plot_error2 eq 'y' then begin
errplot, sigma_1pnt50, $
         (wpsigma_div_sigma_1pnt50-error2_div_sigma_1pnt50), $
         (wpsigma_div_sigma_1pnt50+error2_div_sigma_1pnt50), $
         thick=3.0,   linestyle=1, color=128 
endif

;;
;; 1.66 < z < 1.83
;;
plot, sigma_full, wpsigma_div_sigma, $
      position=[0.42, 0.35, 0.70, 0.56], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $ 
      xstyle=1, ystyle=1, $
      thick=2.2, $
      xthick=2.2, ythick=2.2, $
      charsize=2.7, charthick=4.2, $
      xtickformat='(a1)', $
      ytickformat='(a1)', $
      color=0

wpsigma_div_sigma_1pnt66   = Xi_sigma_LS_1pnt66   / sigma_1pnt66
wpsigma_div_sigma_1pnt66v2 = Xi_sigma_LS_1pnt66v2 / sigma_1pnt66v2

poisson_1pnt66           = (1.+Xi_sigma_LS_1pnt66) * (sqrt(2./DD_1pnt66))

error_1pnt66             = poisson_1pnt66 * err_ratio
error_1pnt66_div_sigma   = error_1pnt66 / sigma_1pnt66

error2_1pnt66            = findgen(n_elements( poisson_1pnt66))
w = where(sigma_1pnt66 lt 10, N)
error2_1pnt66[w]         = poisson_1pnt66[w] * 5.
w = where(sigma_1pnt66 gt 10, N)
error2_1pnt66[w]         = poisson_1pnt66[w] * 45.
error2_div_sigma_1pnt66  = error2_1pnt66 / sigma_1pnt66

plotsym, 0, 1.0, /fill, thick=2
oplot,   sigma_1pnt66,  wpsigma_div_sigma_1pnt66, psym=8,      color=0 ;96
errplot, sigma_1pnt66, $
         (wpsigma_div_sigma_1pnt66-error_1pnt66_div_sigma), $
         (wpsigma_div_sigma_1pnt66+error_1pnt66_div_sigma), $
         thick=2.0,                     linestyle=0,           color=0 ;96
xyouts, 10., 100., '<z>=1.74', charsize=1.2, charthick=4.2,    color=0 ;96

error3                      = (delta_1pnt66_v2     /sigma_1pnt66v2)
plotsym, 0, 1.0, thick=2
oplot,   sigma_1pnt66v2,  wpsigma_div_sigma_1pnt66v2, psym=8,      color=128  ;240
errplot, sigma_1pnt66v2, $
         (wpsigma_div_sigma_1pnt66v2-error3), $
         (wpsigma_div_sigma_1pnt66v2+error3), $
         thick=3.0,       linestyle=1,                        color=128 ;240

if plot_error2 eq 'y' then begin
errplot, sigma_1pnt66, $
         (wpsigma_div_sigma_1pnt66-error2_div_sigma_1pnt66), $
         (wpsigma_div_sigma_1pnt66+error2_div_sigma_1pnt66), $
         thick=2.0,   linestyle=1, color=128 
endif

;;
;; 1.83 < z < 2.02
;;
plot, sigma_full, wpsigma_div_sigma, $
      position=[0.70, 0.35, 0.98, 0.56], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $ 
      xstyle=1, ystyle=1, $
      thick=2.2, $
      xthick=2.2, ythick=2.2, $
      charsize=2.7, charthick=4.2, $
      xtitle=' !3r!Ip!N / h!E-1!N Mpc', $
      ytickformat='(a1)', $
      color=0

wpsigma_div_sigma_1pnt83   = Xi_sigma_LS_1pnt83   /sigma_1pnt83
wpsigma_div_sigma_1pnt83v2 = Xi_sigma_LS_1pnt83v2 /sigma_1pnt83v2

poisson_1pnt83           = (1.+Xi_sigma_LS_1pnt83) * (sqrt(2./DD_1pnt83))

error_1pnt83             = poisson_1pnt83 * err_ratio
error_1pnt83_div_sigma   = error_1pnt83 / sigma_1pnt83

error2_1pnt83            = findgen(n_elements( poisson_1pnt83))
w = where(sigma_1pnt83 lt 10, N)
error2_1pnt83[w]         = poisson_1pnt83[w] * 5.
w = where(sigma_1pnt83 gt 10, N)
error2_1pnt83[w]         = poisson_1pnt83[w] * 45.
error2_div_sigma_1pnt83  = error2_1pnt83 / sigma_1pnt83

plotsym, 0, 1.0, /fill, thick=2
oplot,   sigma_1pnt83,  wpsigma_div_sigma_1pnt83, psym=8,      color=0 ;72
errplot, sigma_1pnt83, $
         (wpsigma_div_sigma_1pnt83-error_1pnt83_div_sigma), $
         (wpsigma_div_sigma_1pnt83+error_1pnt83_div_sigma), $
         thick=2.0,                     linestyle=0,           color=0 ;72
xyouts, 10., 100., '<z>=1.92', charsize=1.2, charthick=4.2,    color=0 ;72


error3                      = delta_1pnt83_v2    /sigma_1pnt83v2
plotsym, 0, 1.0, thick=2
oplot,   sigma_1pnt83v2,  wpsigma_div_sigma_1pnt83v2, psym=8,      color=128  ;240
errplot, sigma_1pnt83v2, $
         (wpsigma_div_sigma_1pnt83v2-error3), $
         (wpsigma_div_sigma_1pnt83v2+error3), $
         thick=3.0,       linestyle=1,                        color=128 ;240


if plot_error2 eq 'y' then begin
errplot, sigma_1pnt83, $
         (wpsigma_div_sigma_1pnt83-error2_div_sigma_1pnt83), $
         (wpsigma_div_sigma_1pnt83+error2_div_sigma_1pnt83), $
         thick=3.0,   linestyle=1, color=128 
endif

;; 
;; BOTTOM PANELS...
;;
;; 2.02 < z < 2.20
;;
plot, sigma_full, wpsigma_div_sigma, $
      position=[0.14, 0.14, 0.42, 0.35], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $ 
      xstyle=1, ystyle=1, $
      thick=2.2, $
      xthick=2.2, ythick=2.2, $
      charsize=2.7, charthick=4.2, $
      xtitle=' !3r!Ip!N / h!E-1!N Mpc', $
      ytitle=' w!Ip!N(!3r!Ip!N)/!3r!Ip!3 ', $
      ytickformat='(f6.2)', $
      color=0

wpsigma_div_sigma_2pnt02   = Xi_sigma_LS_2pnt02   /sigma_2pnt02
wpsigma_div_sigma_2pnt02v2 = Xi_sigma_LS_2pnt02v2 /sigma_2pnt02v2

poisson_2pnt02           = (1.+Xi_sigma_LS_2pnt02) * (sqrt(2./DD_2pnt02))

error_2pnt02             = poisson_2pnt02 * err_ratio
error_2pnt02_div_sigma   = error_2pnt02 / sigma_2pnt02

error2_2pnt02            = findgen(n_elements( poisson_2pnt02))
w = where(sigma_2pnt02 lt 10, N)
error2_2pnt02[w]         = poisson_2pnt02[w] * 5.
w = where(sigma_2pnt02 gt 10, N)
error2_2pnt02[w]         = poisson_2pnt02[w] * 45.
error2_div_sigma_2pnt02  = error2_2pnt02 / sigma_2pnt02

plotsym, 0, 1.0, /fill, thick=2
oplot,   sigma_2pnt02,  wpsigma_div_sigma_2pnt02, psym=8,      color=0 ;48
errplot, sigma_2pnt02, $
         (wpsigma_div_sigma_2pnt02-error_2pnt02_div_sigma), $
         (wpsigma_div_sigma_2pnt02+error_2pnt02_div_sigma), $
         thick=2.0,                 linestyle=0,               color=0 ;48
xyouts, 10., 100., '<z>=2.10', charsize=1.2, charthick=4.2,    color=0 ;48

error3                      = (delta_2pnt02_v2     /sigma_2pnt02v2)
plotsym, 0, 1.0, thick=2
oplot,   sigma_2pnt02v2,  wpsigma_div_sigma_2pnt02v2, psym=8,      color=128  ;240
errplot, sigma_2pnt02v2, $
         (wpsigma_div_sigma_2pnt02v2-error3), $
         (wpsigma_div_sigma_2pnt02v2+error3), $
         thick=3.0,       linestyle=1,                        color=128 ;240

if plot_error2 eq 'y' then begin
errplot, sigma_2pnt02, $
         (wpsigma_div_sigma_2pnt02-error2_div_sigma_2pnt02), $
         (wpsigma_div_sigma_2pnt02+error2_div_sigma_2pnt02), $
         thick=3.0,   linestyle=1, color=128 
endif



;;
;; 2.20 < z < 2.90
;;
plot, sigma_full, wpsigma_div_sigma, $
      position=[0.42, 0.14, 0.70, 0.35], $ ; if top of 2 panels
      /xlog, /ylog, $
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $ 
      xstyle=1, ystyle=1, $
      thick=2.2, $
      xthick=2.2, ythick=2.2, $
      charsize=2.7, charthick=4.2, $
      xtitle=' !3r!Ip!N / h!E-1!N Mpc', $
      ytickformat='(a1)', $
      color=0

wpsigma_div_sigma_2pnt20   = Xi_sigma_LS_2pnt20   /sigma_2pnt20
wpsigma_div_sigma_2pnt20v2 = Xi_sigma_LS_2pnt20v2 /sigma_2pnt20v2

poisson_2pnt20           = (1.+Xi_sigma_LS_2pnt20) * (sqrt(2./DD_2pnt20))

error_2pnt20             = poisson_2pnt20 * err_ratio
error_2pnt20_div_sigma   = error_2pnt20 / sigma_2pnt20

error2_2pnt20            = findgen(n_elements( poisson_2pnt20))
w = where(sigma_2pnt20 lt 10, N)
error2_2pnt20[w]         = poisson_2pnt20[w] * 5.
w = where(sigma_2pnt20 gt 10, N)
error2_2pnt20[w]         = poisson_2pnt20[w] * 45.
error2_div_sigma_2pnt20  = error2_2pnt20 / sigma_2pnt20

plotsym, 0, 1.0, /fill, thick=2
oplot,   sigma_2pnt20,  wpsigma_div_sigma_2pnt20, psym=8,      color=0 
errplot, sigma_2pnt20, $
         (wpsigma_div_sigma_2pnt20-error_2pnt20_div_sigma), $
         (wpsigma_div_sigma_2pnt20+error_2pnt20_div_sigma), $
         thick=2.0,                      linestyle=0,          color=0 
xyouts, 10., 100., '<z>=2.46', charsize=1.2, charthick=4.2,    color=0 

error3                      = (delta_2pnt20_v2     /sigma_2pnt20v2)
plotsym, 0, 1.0, thick=2
oplot,   sigma_2pnt20v2,  wpsigma_div_sigma_2pnt20v2, psym=8,      color=128  ;240
errplot, sigma_2pnt20v2, $
         (wpsigma_div_sigma_2pnt20v2-error3), $
         (wpsigma_div_sigma_2pnt20v2+error3), $
         thick=3.0,       linestyle=1,                        color=128 ;240

if plot_error2 eq 'y' then begin
errplot, sigma_2pnt20, $
         (wpsigma_div_sigma_2pnt20-error2_div_sigma_2pnt20), $
         (wpsigma_div_sigma_2pnt20+error2_div_sigma_2pnt20), $
         thick=3.0,   linestyle=1, color=128 
endif

!p.multi=0



; OP_20080121 	has UNIFORM 0.30 < z < 0.68, color=240
; OP_20080122b 	has UNIFORM 0.68 < z < 0.92, color=216
; OP_20080123   has UNIFORM 0.92 < z < 1.13, color=192
; OP_20080124 	has UNIFORM 1.13 < z < 1.32, color=168
; OP_20080215	has UNIFORM 1.32 < z < 1.50, color=144
; OP_20080215b	has UNIFORM 1.50 < z < 1.66, color=120
; OP_20080215c	has UNIFORM 1.66 < z < 1.83, color=96
; OP_20080215d	has UNIFORM 1.83 < z < 2.02, color=72
; OP_20080215e	has UNIFORM 2.02 < z < 2.25, color=48
;
; OP_20080122   has UNIFORM 2.25 < z < 2.90, color=24


device, /close
set_plot, 'X'

close, /all



end
