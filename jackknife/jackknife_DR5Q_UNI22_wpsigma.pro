;+
; NAME:
;       jackknife_DR5Q_UNI22_wpsigma
;
; PURPOSE:
;       To calculate the jackknife errors from the UNIFORM DR5Q sample
;       on wp(sigma)
;
; EXPLANATION:
;
; CALLING SEQUENCE:
;       .run jackknife_DR5Q_UNI22_wpsigma
;
; INPUTS:
;      The UNI22 wp(sigma) jackknife input files from
;      UNI22_evol_5logbins_wpsigma
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
;       /usr/commomn/rsi/lib/general/LibAstro/  
;    
; MODIFICATION HISTORY:
;       Version 1.00  NPR    20th November 2007
;-

print
print
readcol, '../OP/OP_20080508/K_wp_output_UNI22.dat', $
         sigma, log_sigma, wpsigma_std, delta_Xi_sigma, $
         DD, DR, wpsigma_HAM, wpsigma_LS
print, ' READ-IN FULL wp(sigma)   [OP_20080508/K_wp_output_UNI22.dat]'
print 
no_subsamples = 0


readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N1.dat', $
         sigma_N1, log_sigma_N1, wpsigma_std_N1, delta_Xi_sigma_N1, $
         DD_N1, DR_N1, wpsigma_HAM_N1, wpsigma_LS_N1
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N2.dat', $
         sigma_N2, log_sigma_N2, wpsigma_std_N2, delta_Xi_sigma_N2, $
         DD_N2, DR_N2, wpsigma_HAM_N2, wpsigma_LS_N2
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N3.dat', $
         sigma_N3, log_sigma_N3, wpsigma_std_N3, delta_Xi_sigma_N3, $
         DD_N3, DR_N3, wpsigma_HAM_N3, wpsigma_LS_N3
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N4.dat', $
         sigma_N4, log_sigma_N4, wpsigma_std_N4, delta_Xi_sigma_N4, $ 
         DD_N4, DR_N4, wpsigma_HAM_N4, wpsigma_LS_N4
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N5.dat', $
         sigma_N5, log_sigma_N5, wpsigma_std_N5, delta_Xi_sigma_N5, $
         DD_N5, DR_N5, wpsigma_HAM_N5, wpsigma_LS_N5
no_subsamples = no_subsamples +1
;-------------------------------------------------------------------------
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N6.dat', $
         sigma_N6, log_sigma_N6, wpsigma_std_N6, delta_Xi_sigma_N6, $
         DD_N6, DR_N6, wpsigma_HAM_N6, wpsigma_LS_N6
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N7.dat', $
         sigma_N7, log_sigma_N7, wpsigma_std_N7, delta_Xi_sigma_N7, $
         DD_N7, DR_N7, wpsigma_HAM_N7, wpsigma_LS_N7
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N8.dat', $
         sigma_N8, log_sigma_N8, wpsigma_std_N8, delta_Xi_sigma_N8, $
         DD_N8, DR_N8, wpsigma_HAM_N8, wpsigma_LS_N8
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N9.dat', $
         sigma_N9, log_sigma_N9, wpsigma_std_N9, delta_Xi_sigma_N9, $
         DD_N9, DR_N9, wpsigma_HAM_N9, wpsigma_LS_N9
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N10.dat', $
         sigma_N10, log_sigma_N10, wpsigma_std_N10, delta_Xi_sigma_N10, $
         DD_N10, DR_N10, wpsigma_HAM_N10, wpsigma_LS_N10
no_subsamples = no_subsamples +1
;--------------------------------------------------------------------------------
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N11.dat', $
         sigma_N11, log_sigma_N11, wpsigma_std_N11, delta_Xi_sigma_N11, $
         DD_N11, DR_N11, wpsigma_HAM_N11, wpsigma_LS_N11
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N12.dat', $
         sigma_N12, log_sigma_N12, wpsigma_std_N12, delta_Xi_sigma_N12, $
         DD_N12, DR_N12, wpsigma_HAM_N12, wpsigma_LS_N12
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N13.dat', $
         sigma_N13, log_sigma_N13, wpsigma_std_N13, delta_Xi_sigma_N13, $
         DD_N13, DR_N13, wpsigma_HAM_N13, wpsigma_LS_N13
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N14.dat', $
         sigma_N14, log_sigma_N14, wpsigma_std_N14, delta_Xi_sigma_N14, $
         DD_N14, DR_N14, wpsigma_HAM_N14, wpsigma_LS_N14
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N15.dat', $
         sigma_N15, log_sigma_N15, wpsigma_std_N15, delta_Xi_sigma_N15, $
         DD_N15, DR_N15, wpsigma_HAM_N15, wpsigma_LS_N15
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N16.dat', $
         sigma_N16, log_sigma_N16, wpsigma_std_N16, delta_Xi_sigma_N16, $
         DD_N16, DR_N16, wpsigma_HAM_N16, wpsigma_LS_N16
no_subsamples = no_subsamples +1
;--------------------------------------------------------------------------------
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N17.dat', $
         sigma_N17, log_sigma_N17, wpsigma_std_N17, delta_Xi_sigma_N17, $
         DD_N17, DR_N17, wpsigma_HAM_N17, wpsigma_LS_N17
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N18.dat', $
         sigma_N18, log_sigma_N18, wpsigma_std_N18, delta_Xi_sigma_N18, $
         DD_N18, DR_N18, wpsigma_HAM_N18, wpsigma_LS_N18
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N19.dat', $
         sigma_N19, log_sigma_N19, wpsigma_std_N19, delta_Xi_sigma_N19, $
         DD_N19, DR_N19, wpsigma_HAM_N19, wpsigma_LS_N19
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_N20.dat', $
         sigma_N20, log_sigma_N20, wpsigma_std_N20, delta_Xi_sigma_N20, $
         DD_N20, DR_N20, wpsigma_HAM_N20, wpsigma_LS_N20
no_subsamples = no_subsamples +1
;--------------------------------------------------------------------------------
readcol, '../OP/OP_UNI22_jack_wpsigma/K_wp_output_UNI22_jack_S.dat', $
         sigma_S, log_sigma_S, wpsigma_std_S, delta_Xi_sigma_S, $
         DD_S, DR_S, wpsigma_HAM_S, wpsigma_LS_S
no_subsamples = no_subsamples +1
;--------------------------------------------------------------------------------


print
print, 'no_subsamples  ', no_subsamples

print
readcol, 'jackknife_area_weights.dat', $
         area_name, ra_low, ra_high, dec_low, dec_high, DD_weight, RR_weight, $
         format='(a, d,d, d,d, d,d)'

    RR = 892630.
 RR_N1 = RR_weight[0]
 RR_N2 = RR_weight[1]
 RR_N3 = RR_weight[2]
 RR_N4 = RR_weight[3]
 RR_N5 = RR_weight[4]
 RR_N6 = RR_weight[5]
 RR_N7 = RR_weight[6]
 RR_N8 = RR_weight[7]
 RR_N9 = RR_weight[8]
RR_N10 = RR_weight[9]
RR_N11 = RR_weight[10]
RR_N12 = RR_weight[11]
RR_N13 = RR_weight[12]
RR_N14 = RR_weight[13]
RR_N15 = RR_weight[14]
RR_N16 = RR_weight[15]
RR_N17 = RR_weight[16]
RR_N18 = RR_weight[17]
RR_N19 = RR_weight[18]
RR_N20 = RR_weight[19]
  RR_S = RR_weight[20]


;or ell=0L, n_elements(no_subsamples)-1 do begin
print
print, 'FULL DDs', sqrt(total(DD)), '   RRs ', sqrt(total(RR))
print
print, ' N1 DDs', sqrt(total(DD_N1)),  '   RRs ', sqrt(total(RR_N1))
print, ' N2 DDs', sqrt(total(DD_N2)),  '   RRs ', sqrt(total(RR_N2))
print, ' N3 DDs', sqrt(total(DD_N3)),  '   RRs ', sqrt(total(RR_N3))
print, ' N4 DDs', sqrt(total(DD_N4)),  '   RRs ', sqrt(total(RR_N4))
print, ' N5 DDs', sqrt(total(DD_N5)),  '   RRs ', sqrt(total(RR_N5))
print, ' N6 DDs', sqrt(total(DD_N6)),  '   RRs ', sqrt(total(RR_N6))
print, ' N7 DDs', sqrt(total(DD_N7)),  '   RRs ', sqrt(total(RR_N7))
print, ' N8 DDs', sqrt(total(DD_N8)),  '   RRs ', sqrt(total(RR_N8))
print, ' N9 DDs', sqrt(total(DD_N9)),  '   RRs ', sqrt(total(RR_N9))
print, 'N10 DDs', sqrt(total(DD_N10)), '   RRs ', sqrt(total(RR_N10))
print, 'N10 DDs', sqrt(total(DD_N11)), '   RRs ', sqrt(total(RR_N11))
print, 'N10 DDs', sqrt(total(DD_N12)), '   RRs ', sqrt(total(RR_N12))
print, 'N10 DDs', sqrt(total(DD_N13)), '   RRs ', sqrt(total(RR_N13))
print, 'N10 DDs', sqrt(total(DD_N14)), '   RRs ', sqrt(total(RR_N14))
print, 'N10 DDs', sqrt(total(DD_N15)), '   RRs ', sqrt(total(RR_N15))
print, 'N10 DDs', sqrt(total(DD_N16)), '   RRs ', sqrt(total(RR_N16))
print, 'N10 DDs', sqrt(total(DD_N17)), '   RRs ', sqrt(total(RR_N17))
print, 'N10 DDs', sqrt(total(DD_N18)), '   RRs ', sqrt(total(RR_N18))
print, 'N10 DDs', sqrt(total(DD_N19)), '   RRs ', sqrt(total(RR_N19))
print, 'N10 DDs', sqrt(total(DD_N20)), '   RRs ', sqrt(total(RR_N20))
print, '  S DDs', sqrt(total(DD_S)), '   RRs ', sqrt(total(RR_S))
print

RR_sub = [[RR_N1], [RR_N2], [RR_N3], [RR_N4], [RR_N5], [RR_N6], [RR_N7], [RR_N8], [RR_N9], [RR_N10], [RR_N11], [RR_N12], [RR_N13], [RR_N14], [RR_N15], [RR_N16], [RR_N17], [RR_N18], [RR_N19], [RR_N20], [RR_S]]

; wpsigma_LS_S
wpsigma_LS_sub = [[wpsigma_LS_N1], [wpsigma_LS_N2], [wpsigma_LS_N3], [wpsigma_LS_N4], [wpsigma_LS_N5], [wpsigma_LS_N6], [wpsigma_LS_N7], [wpsigma_LS_N8], [wpsigma_LS_N9], [wpsigma_LS_N10], [wpsigma_LS_N11], [wpsigma_LS_N12], [wpsigma_LS_N13], [wpsigma_LS_N14], [wpsigma_LS_N15], [wpsigma_LS_N16], [wpsigma_LS_N17], [wpsigma_LS_N18], [wpsigma_LS_N19], [wpsigma_LS_N20], [wpsigma_LS_S]]


openw, 10, 'COV_ijl_wpsigma.dat'
openw, 11, 'COV_buildup_wpsigma.dat'
openw, 12, 'COV_wpsigma.dat'
openw, 13, 'REG_wpsigma.dat'
openw, 14, 'K_wp_output_UNI22_jackknife_errors.dat'

printf, 10, ' i, j, l, RR_weight_ati,   RR_weight_atj,   RR_ati,   RR_atj' 
printf, 11, '  i, j, l,    A_two,       COV_sum,    A_three_i, A_three_j, A_three '


COV     = fltarr(n_elements(DD),  n_elements(DD))
REG     = fltarr(n_elements(DD),  n_elements(DD))
COV_ii  = fltarr(n_elements(DD))
COV_jj  = fltarr(n_elements(DD))
sigma_i = fltarr(n_elements(DD))
sigma_j = fltarr(n_elements(DD))
for i=0L, n_elements(DD)-1 do begin
   for j=0L, n_elements(DD)-1 do begin
      
      COV_sum = 0d
      A_three_sum = 0d
      for l=0L, no_subsamples-1 do begin
;         ;; Looping over the 'L' subsamples 
;         ;; (at a fixed separation, i,j ) 
;         ;; Homeage to Myers et al. (2007, ApJ, 658, 85) 
;         ;; Appendix A
         
;         A_two = (sqrt(RR_sub[i,l]/RR[i]))*(wpsigma_LS_sub[i,l]-wpsigma_LS[i])* $
;                 (sqrt(RR_sub[j,l]/RR[j]))*(wpsigma_LS_sub[j,l]-wpsigma_LS[j])
         
         A_two = (sqrt(RR_sub[l]/RR))*(wpsigma_LS_sub[i,l]-wpsigma_LS[i])* $
                 (sqrt(RR_sub[l]/RR))*(wpsigma_LS_sub[j,l]-wpsigma_LS[j])
         
         COV_sum     = COV_sum + A_two
         
         A_three_i=sqrt((RR_sub[l] / RR) * $
                        ((wpsigma_LS_sub[i,l] - wpsigma_LS[i])^2))
         A_three_j=sqrt((RR_sub[l] / RR) * $
                        ((wpsigma_LS_sub[j,l] - wpsigma_LS[j])^2))
         
         A_three = A_three_i * A_three_j
         A_three_sum = A_three_sum + A_three
         
         printf, 10,  i,j,l, RR_sub[l], RR_sub[l], RR, RR, $
                 (RR_sub[l]/RR),  (RR_sub[l]/RR), $
                 wpsigma_LS_sub[i,l],  wpsigma_LS[i], $
                 wpsigma_LS_sub[j,l], wpsigma_LS[j], $
                 format='(i4,i4,i4, i22,i22,i22,i22, d16.8,1x,d16.8,1x, d16.8,1x,d16.8,1x,d16.8,1x,d16.8,1x)'
         
         printf,11, i,j,l, $
                A_two, COV_sum, A_three_i, A_three_j, A_three, A_three_sum, $
                format='(i4,i4,i4,  d16.8,1x, d16.8,1x, d16.8,1x, d16.8,1x, d16.8,1x, d16.8)'
      endfor  ; for l=0L, no_subsamples-1 do begin

      COV(i,j) = COV_sum

      if i eq j then begin
         COV_ii[i] = COV(i,j)
         COV_jj[j] = COV(i,j)
         sigma_i[i] = sqrt(COV_ii[i])
         sigma_j[j] = sqrt(COV_jj[j])
         print, i,j, COV(i,j), sigma_i[i]
         printf, 14, i,j, COV(i,j), sigma_i[i], $
                 format='(i4,i4, d16.8,1x, d16.8)'
      endif

      ;REG(i,j) = COV_sum / A_three_sum
;      REG(i,j) = COV(i,j) / sig
      printf, 12, i, j, COV(i,j)
;      printf, 12, COV(i,j)/(max(COV))

   endfor                       ; for j=0L, n_elements(DD)-1 do begin
endfor                          ; for i=0L, n_elements(DD)-1 do begin

   
for i=0L, n_elements(RR)-1 do begin
   for j=0L, n_elements(RR)-1 do begin
       REG(i,j) = COV(i,j) / (sigma_i[i]*sigma_j[j])
       printf, 13, i, j, REG(i,j)
   endfor
endfor


jack = sigma_i

inv_COV = invert(COV, status, /double)



!p.multi=0
loadct, 6                       ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='COV_3D_wpsigma.ps', $
        xsize=7.5, ysize=6.0, /inches, /color, xoffset=0.0, yoffset=0.2
SURFACE, COV, /lego, $
         SKIRT=0.0, $
         TITLE = '!3Covariance Matrix, w!Ip!N(!4r!3)', $
         CHARSIZE = 2, $
         xthick=2.0, ythick=2.0, thick=2.0
device, /close
set_plot, 'X'


!p.multi=0
loadct, 1                       ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='COV_3D_shade_wpsigma.ps', $
        xsize=7.5, ysize=6.0, /inches, /color, xoffset=0.0, yoffset=0.2
SHADE_SURF, COV, SHADES=BYTSCL(COV, TOP = !D.TABLE_SIZE), color=128
loadct, 6                       ; black=0=255, red=63, green=127, blue=191
SURFACE, COV, /noerase, $
         color=0
device, /close
set_plot, 'X'


!p.multi=0
set_plot, 'ps'
device, filename='REG_3D_wpsigma.ps', $
        xsize=7.5, ysize=6.0, /inches, /color, xoffset=0.0, yoffset=0.2
SURFACE, REG, /lego, $
         SKIRT=0.0, $
         TITLE = '!#Regression Matrix,  w!Ip!N(!4r!3)', $
         CHARSIZE = 2, $
         xthick=2.0, ythick=2.0, thick=2.0, $
         color=64
device, /close
set_plot, 'X'






x_range_min =    0.12
x_range_max =  250.
y_range_min =    0.11
y_range_max = 9000.


!p.multi=0
loadct, 6  ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='wpsigma_DR5_quasars_jackknifes_temp.ps', $
        xsize=8.3, ysize=6.0, /inches, /color, $
        xoffset=0.0, yoffset=0.1

plot, sigma, wpsigma_LS, $
      /xlog, /ylog, $
      position=[0.18, 0.16, 1.00, 1.00], $      ; if top of 2 panels
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $    
      psym=4, $
      thick=4.2, $
      xstyle=1, ystyle=1, $
      xthick=4.2, ythick=4.2, $
      charsize=2.2, charthick=4.2, $
      xtitle=' !7r!3 / h!E-1!N Mpc', $
      ytitle=' w!Ip!N(!7r!3)', $
      ytickformat='(i4)', $
      color=0

oplot,  sigma_N1,  wpsigma_LS_N1, linestyle=1
oplot,  sigma_N2,  wpsigma_LS_N2, linestyle=1
oplot,  sigma_N3,  wpsigma_LS_N3, linestyle=1
oplot,  sigma_N4,  wpsigma_LS_N4, linestyle=1
oplot,  sigma_N5,  wpsigma_LS_N5, linestyle=1
oplot,  sigma_N6,  wpsigma_LS_N6, linestyle=1
oplot,  sigma_N7,  wpsigma_LS_N7, linestyle=1
oplot,  sigma_N8,  wpsigma_LS_N8, linestyle=1
oplot,  sigma_N9,  wpsigma_LS_N9, linestyle=1
oplot, sigma_N10, wpsigma_LS_N10, linestyle=1
oplot, sigma_N11, wpsigma_LS_N11, linestyle=1
oplot, sigma_N12, wpsigma_LS_N12, linestyle=1
oplot, sigma_N13, wpsigma_LS_N13, linestyle=1
oplot, sigma_N14, wpsigma_LS_N14, linestyle=1
oplot, sigma_N15, wpsigma_LS_N15, linestyle=1
oplot, sigma_N16, wpsigma_LS_N16, linestyle=1
oplot, sigma_N17, wpsigma_LS_N17, linestyle=1
oplot, sigma_N18, wpsigma_LS_N18, linestyle=1
oplot, sigma_N19, wpsigma_LS_N19, linestyle=1
oplot, sigma_N20, wpsigma_LS_N20, linestyle=1
oplot,   sigma_S, wpsigma_LS_S,   linestyle=1

legend, [''], box=0, position=[3.5,4000.], psym=4, thick=4.2
legend, [''], box=0, position=[2.0,1200.],  linestyle=1, thick=4.2
xyouts, 6., 2000., 'SDSS DR5Q (uni)', color=0, charthick=4.2, charsize=2.2
xyouts, 6., 750., '21 Jackknifes', color=0, charthick=4.2, charsize=2.2


device, /close
set_plot, 'X'



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; wp(sigma)  UNI22  WITH  the  JK  errors
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
xis_q = wpsigma_LS                       ; just setting the xi_Q(s) to the xi_LS
poisson = (1.+xis_q) * (sqrt(2./DD)) ; Poisson errors, da Angela et al. (2005).


loadct, 6  ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='wpsigma_DR5_quasars_jackknife_errs_temp.ps', $
        xsize=8.3, ysize=6.0, /inches, /color, $
        xoffset=0.3, yoffset=0.1
!p.multi=[0,1,2]

plot, sigma, xis_q, $
      /xlog, /ylog, $
      position=[0.14, 0.25, 0.98, 0.98], $      ; if top of 2 panels
;      xrange=[0.5, 300], yrange=[0.001, 500], $ ; bring down to 500 w/o V. PREL.
      xrange=[x_range_min, x_range_max], $
      yrange=[y_range_min, y_range_max], $    
      psym=4, $
      xstyle=1, ystyle=1, $
      xthick=4.2, ythick=4.2, $
      charsize=2.2, charthick=4.2, $
      xtickformat='(a1)', $
      ytitle=' w!Ip!N(!7r!3)', $
      ytickformat='(i4)', $
      /nodata, $
      color=0

plotsym,0, 1.25, /fill                                
oplot, sigma, xis_q, psym=8, thick=4, color=0 ;also psym=4 is nice.
oplot, sigma, xis_q, linestyle=0, thick=4, color=0
errplot, sigma, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=0, linestyle=1
errplot, sigma, (xis_q-jack),    (xis_q+jack), thick=8.0, color=128, linestyle=0
errplot, sigma, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=0, linestyle=1

legend, [''], box=0, position=[3.5,4000.], psym=4, thick=4.2
legend, [''], box=0, position=[2.0,1200.],  linestyle=1, thick=4.2, color=0
legend, [''], box=0, position=[2.0,600.],  linestyle=0, thick=4.2, color=128
xyouts, 6., 2000., 'SDSS DR5Q (uni)', color=0, charthick=4.2, charsize=2.2
xyouts, 6., 750., 'Poisson errors', color=0, charthick=4.2, charsize=2.2
xyouts, 6., 350., 'Jackknife errors', color=0, charthick=4.2, charsize=2.2

plot, sigma, (jack/poisson), $
      /xlog, $
      position=[0.14, 0.14, 0.98, 0.25], $
      xrange=[x_range_min, x_range_max], $
      yrange=[0.0, 100.0], $   
      xstyle=1, ystyle=1, $
      thick=4.2, $
      xthick=4.2, ythick=4.2, $
      xcharsize=2.2, ycharsize=1.0, charthick=4.2, $
;      xticks=3, $
      xtitle=' !7r!3 / h!E-1!N Mpc', $
      ytitle='ratio', $
      xtickformat='(i4)', $
      ytickformat='(i4)', $
;     /nodata, $
      color=0


!p.multi=0
device, /close
set_plot, 'X'



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Poisson vs. JK errors plot
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
set_plot, 'ps'
device, filename='wpsigma_DR5_quasars_Poisson_vs_JK_errs_temp.ps', $
        xsize=8.3, ysize=6.0, $
        /inches, /color, $
        xoffset=0.1, yoffset=0.1
!p.multi=0

plot, sigma, (jack/poisson), $
      /xlog, $
      position=[0.14, 0.14, 0.98, 0.98], $      ; if top of 2 panels
      xrange=[x_range_min, x_range_max], $
      ;xrange=[0.8, 135.0], $
      yrange=[-10, 200.0], $     ; bring down to 500 w/o V. PREL.
      psym=4, $
      xstyle=1, ystyle=1, $
      xthick=4.2, ythick=4.2, thick=4.2, $
      charsize=2.2, charthick=4.2, $
      xtitle=' !7r!3 / h!E-1!N Mpc', $
      ytitle='error ratio', $
      xtickformat='(f5.1)', $
      ytickformat='(i3)', $
;      /nodata, $
;      xcharsize=1.2, ycharsize=1.2, $
      color=0


plotsym,0, 1.25, /fill                                  ;for UNI22
oplot, sigma, (jack/poisson), psym=8, thick=4, color=0      ;also psym=4 is nice.
oplot, sigma, (jack/poisson), linestyle=0, thick=4, color=0

plotsym,0, 1.0, /fill        
legend, ['Jackknife/Poisson'], $
        psym=8, box=0, position=[0.5,120.], $
        charsize=2.2, charthick=6.2
xyouts, 0.5, 170., 'SDSS DR5Q (uni)', charsize=2.2, charthick=6.2, color=0
xyouts, 0.5, 150.,  '0.3 < z < 2.2 ', charsize=2.2, charthick=6.2, color=0

!p.multi=0
device, /close
set_plot, 'X'










close, /all


end
