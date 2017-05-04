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
         s_log, s, xis_std, delta_xis, DD, DR, RR, xis_LS, , 
print, ' READ-IN FULL xi(s)   [OP_20080508/k_output_UNI22.dat]'
print 
no_subsamples = 0


readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N1.dat', $
         s_log_N1, s_N1, xis_std_N1, delta_xis_N1, DD_N1, DR_N1, $
         xis_HAM_N1, xis_LS_N1
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N2.dat', $
         s_log_N2, s_N2, xis_std_N2, delta_xis_N2, DD_N2, DR_N2, $
         xis_HAM_N2, xis_LS_N2
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N3.dat', $
         s_log_N3, s_N3, xis_std_N3, delta_xis_N3, DD_N3, DR_N3, $
         xis_HAM_N3, xis_LS_N3
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N4.dat', $
         s_log_N4, s_N4, xis_std_N4, delta_xis_N4, DD_N4, DR_N4, $
         xis_HAM_N4, xis_LS_N4
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N5.dat', $
         s_log_N5, s_N5, xis_std_N5, delta_xis_N5, DD_N5, DR_N5, $
         xis_HAM_N5, xis_LS_N5
;-------------------------------------------------------------------------
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N6.dat', $
         s_log_N6, s_N6, xis_std_N6, delta_xis_N6, DD_N6, DR_N6, $
         xis_HAM_N6, xis_LS_N6
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N7.dat', $
         s_log_N7, s_N7, xis_std_N7, delta_xis_N7, DD_N7, DR_N7, $
         xis_HAM_N7, xis_LS_N7
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N8.dat', $
         s_log_N8, s_N8, xis_std_N8, delta_xis_N8, DD_N8, DR_N8, $
         xis_HAM_N8, xis_LS_N8
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N9.dat', $
         s_log_N9, s_N9, xis_std_N9, delta_xis_N9, DD_N9, DR_N9, $
         xis_HAM_N9, xis_LS_N9
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N10.dat', $
         s_log_N10, s_N10, xis_std_N10, delta_xis_N10, DD_N10, DR_N10, $
         xis_HAM_N10, xis_LS_N10
no_subsamples = no_subsamples +1
;--------------------------------------------------------------------------------
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N11.dat', $
         s_log_N11, s_N11, xis_std_N11, delta_xis_N11, DD_N11, DR_N11, xis_HAM_N11, $
         xis_LS_N11, _N11, _N11
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N12.dat', $
         s_log_N12, s_N12, xis_std_N12, delta_xis_N12, DD_N12, DR_N12, xis_HAM_N12, $
         xis_LS_N12, _N12, _N12
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N13.dat', $
         s_log_N13, s_N13, xis_std_N13, delta_xis_N13, DD_N13, DR_N13, xis_HAM_N13, $
         xis_LS_N13, _N13, _N13
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N14.dat', $
         s_log_N14, s_N14, xis_std_N14, delta_xis_N14, DD_N14, DR_N14, xis_HAM_N14, $
         xis_LS_N14, _N14, _N14
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N15.dat', $
         s_log_N15, s_N15, xis_std_N15, delta_xis_N15, DD_N15, DR_N15, xis_HAM_N15, $
         xis_LS_N15, _N15, _N15
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N16.dat', $
         s_log_N16, s_N16, xis_std_N16, delta_xis_N16, DD_N16, DR_N16, xis_HAM_N16, $
         xis_LS_N16, _N16, _N16
no_subsamples = no_subsamples +1
;--------------------------------------------------------------------------------
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N17.dat', $
         s_log_N17, s_N17, xis_std_N17, delta_xis_N17, DD_N17, DR_N17, xis_HAM_N17, $
         xis_LS_N17, _N17, _N17
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N18.dat', $
         s_log_N18, s_N18, xis_std_N18, delta_xis_N18, DD_N18, DR_N18, xis_HAM_N18, $
         xis_LS_N18, _N18, _N18
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N19.dat', $
         s_log_N19, s_N19, xis_std_N19, delta_xis_N19, DD_N19, DR_N19, xis_HAM_N19, $
         xis_LS_N19, _N19, _N19
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N20.dat', $
         s_log_N20, s_N20, xis_std_N20, delta_xis_N20, DD_N20, DR_N20, xis_HAM_N20, $
         xis_LS_N20, _N20, _N20
no_subsamples = no_subsamples +1
;--------------------------------------------------------------------------------
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_S.dat', $
         s_log_S, s_S, xis_std_S, delta_xis_S, DD_S, DR_S, xis_HAM_S, $
         xis_LS_S, _S, _S
no_subsamples = no_subsamples +1
;--------------------------------------------------------------------------------


print
print, 'no_subsamples  ', no_subsamples

print
readcol, 'jackknife_area_weights.dat', $
         area_name, ra_low, ra_high, dec_low, dec_high, DD_weight, RR_weight, $
         format='(a, d,d, d,d, d,d)'



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
print, 'S DDs', sqrt(total(DD_S)), '   RRs ', sqrt(total(RR_S))
print

RR_sub = [[RR_N1], [RR_N2], [RR_N3], [RR_N4], [RR_N5], [RR_N6], [RR_N7], [RR_N8], [RR_N9], [RR_N10], [RR_N11], [RR_N12], [RR_N13], [RR_N14], [RR_N15], [RR_N16], [RR_N17], [RR_N18], [RR_N19], [RR_N20], [RR_S]]

xis_LS_sub = [[xis_LS_N1], [xis_LS_N2], [xis_LS_N3], [xis_LS_N4], [xis_LS_N5], [xis_LS_N6], [xis_LS_N7], [xis_LS_N8], [xis_LS_N9], [xis_LS_N10], [xis_LS_N11], [xis_LS_N12], [xis_LS_N13], [xis_LS_N14], [xis_LS_N15], [xis_LS_N16], [xis_LS_N17], [xis_LS_N18], [xis_LS_N19], [xis_LS_N20], [xis_LS_S]]


openw, 10, 'COV_ijl.dat'
openw, 11, 'COV_buildup.dat'
openw, 12, 'COV.dat'
openw, 13, 'REG.dat'
openw, 14, 'k_output_UNI22_jackknife_errors.dat'

printf, 10, ' i, j, l, RR_weight_ati,   RR_weight_atj,   RR_ati,   RR_atj' 
printf, 11, '  i, j, l,    A_two,       COV_sum,    A_three_i, A_three_j, A_three '


COV     = fltarr(n_elements(RR),  n_elements(RR))
REG     = fltarr(n_elements(RR),  n_elements(RR))
COV_ii  = fltarr(n_elements(RR))
COV_jj  = fltarr(n_elements(RR))
sigma_i = fltarr(n_elements(RR))
sigma_j = fltarr(n_elements(RR))
for i=0L, n_elements(RR)-1 do begin
   for j=0L, n_elements(RR)-1 do begin

      COV_sum = 0d
      A_three_sum = 0d
      for l=0L, no_subsamples-1 do begin
;         ;; Looping over the 'L' subsamples 
;         ;; (at a fixed separation, i,j ) 
;         ;; Homeage to Myers et al. (2007, ApJ, 658, 85) 
;         ;; Appendix A
         
         A_two = (sqrt(RR_sub[i,l] / RR[i])) * (xis_LS_sub[i,l] - xis_LS[i]) * $
                 (sqrt(RR_sub[j,l] / RR[j])) * (xis_LS_sub[j,l] - xis_LS[j]) 
         
         A_three_i=sqrt((RR_sub[i,l] / RR[i]) * ((xis_LS_sub[i,l] - xis_LS[i])^2))
         A_three_j=sqrt((RR_sub[j,l] / RR[j]) * ((xis_LS_sub[j,l] - xis_LS[j])^2))
         
         A_three = A_three_i * A_three_j

         COV_sum     = COV_sum + A_two
         A_three_sum = A_three_sum + A_three

         printf, 10,  i,j,l, RR_sub[i,l], RR_sub[j,l], RR[i], RR[j], $
                 (RR_sub[i,l]/RR[i]),  (RR_sub[j,l]/RR[j]), $
                 xis_LS_sub[i,l], xis_LS[i],  xis_LS_sub[j,l], xis_LS[j], $
                 format='(i4,i4,i4, i22,i22,i22,i22, d16.8,1x,d16.8,1x, d16.8,1x,d16.8,1x,d16.8,1x,d16.8,1x)'
         
         printf,11, i,j,l, $
                A_two, COV_sum, A_three_i, A_three_j, A_three, A_three_sum, $
;                (A_two/A_three), (COV_sum/A_three), $
                format='(i4,i4,i4,  d16.8,1x, d16.8,1x, d16.8,1x, d16.8,1x, d16.8,1x, d16.8)'
      endfor 


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

   endfor                       ;
endfor

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
device, filename='COV_3D.ps', $
        xsize=7.5, ysize=6.0, /inches, /color, xoffset=0.0, yoffset=0.2
;XPLOT3D, X, Y, Z 
;PLOTS, X, Y, Z, /T3D
;SURFACE, COV, $
SURFACE, COV, /lego, $
;         AX=300, $
;         AZ=330, $
         SKIRT=0.0, TITLE = 'Covariance Matrix, xi(s)', CHARSIZE = 2, $
         xthick=2.0, ythick=2.0, thick=2.0
;SURFACE, Z [, X, Y] [, AX=degrees] [, AZ=degrees] [, BOTTOM=index] [, /HORIZONTAL] [, /LEGO] [, /LOWER_ONLY | , /UPPER_ONLY] [, MAX_VALUE=value] [, MIN_VALUE=value] [, /SAVE] [, SHADES=array] [, SKIRT=value] [, /XLOG] [, /YLOG] [, ZAXIS={1 | 2 | 3 | 4}] [, /ZLOG] 
device, /close
set_plot, 'X'

!p.multi=0
loadct, 1                       ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='COV_3D_shade.ps', $
        xsize=7.5, ysize=6.0, /inches, /color, xoffset=0.0, yoffset=0.2

SHADE_SURF, COV, SHADES=BYTSCL(COV, TOP = !D.TABLE_SIZE), color=128

loadct, 6                       ; black=0=255, red=63, green=127, blue=191
SURFACE, COV, /noerase, $
;         /lego, $
         color=0
;SHADE_SURF, COV, /lego, $
;         AX=300, $
;         AZ=330, $
;         SKIRT=0.0, TITLE = 'Surface Plot', CHARSIZE = 2, $
;         xthick=2.0, ythick=2.0, thick=2.0
;SURFACE, Z [, X, Y] [, AX=degrees] [, AZ=degrees] [, BOTTOM=index] [, /HORIZONTAL] [, /LEGO] [, /LOWER_ONLY | , /UPPER_ONLY] [, MAX_VALUE=value] [, MIN_VALUE=value] [, /SAVE] [, SHADES=array] [, SKIRT=value] [, /XLOG] [, /YLOG] [, ZAXIS={1 | 2 | 3 | 4}] [, /ZLOG] 
device, /close
set_plot, 'X'


!p.multi=0
set_plot, 'ps'
device, filename='REG_3D.ps', $
        xsize=7.5, ysize=6.0, /inches, /color, xoffset=0.0, yoffset=0.2
SURFACE, REG, /lego, $
         SKIRT=0.0, TITLE = 'Regression Matrix, xi(s)', CHARSIZE = 2, $
         xthick=2.0, ythick=2.0, thick=2.0, $
         color=64
device, /close
set_plot, 'X'



!p.multi=0
loadct, 6  ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='xis_DR5_quasars_jackknifes_temp.ps', $
        xsize=7.5, ysize=6.0, /inches, /color

plot, s, xis_LS, $
      /xlog, /ylog, $
      position=[0.14, 0.25, 0.98, 0.98], $      ; if top of 2 panels
      xrange=[0.5, 300], yrange=[0.001, 500], $ ; bring down to 500 w/o V. PREL.
      psym=4, $
      thick=4, $
      xstyle=1, ystyle=1, $
      charsize=2.2, charthick=4.2, $
      ytitle=' !7n(!3s)', $
      xtickformat='(a1)', ytickformat='(f6.2)', $
;      /nodata, $
      color=0

oplot,  s_N1,  xis_LS_N1, linestyle=1
oplot,  s_N2,  xis_LS_N1, linestyle=1
oplot,  s_N3,  xis_LS_N1, linestyle=1
oplot,  s_N4,  xis_LS_N1, linestyle=1
oplot,  s_N5,  xis_LS_N1, linestyle=1
oplot,  s_N6,  xis_LS_N1, linestyle=1
oplot,  s_N7,  xis_LS_N1, linestyle=1
oplot,  s_N8,  xis_LS_N1, linestyle=1
oplot,  s_N9,  xis_LS_N1, linestyle=1
oplot, s_N10, xis_LS_N10, linestyle=1
oplot, s_N11, xis_LS_N11, linestyle=1
oplot, s_N12, xis_LS_N12, linestyle=1
oplot, s_N13, xis_LS_N13, linestyle=1
oplot, s_N14, xis_LS_N14, linestyle=1
oplot, s_N15, xis_LS_N15, linestyle=1
oplot, s_N16, xis_LS_N16, linestyle=1
oplot, s_N17, xis_LS_N17, linestyle=1
oplot, s_N18, xis_LS_N18, linestyle=1
oplot, s_N19, xis_LS_N19, linestyle=1
oplot, s_N20, xis_LS_N20, linestyle=1
oplot,   s_S, xis_LS_S,   linestyle=1


device, /close
set_plot, 'X'




xis_q = xis_LS                       ; just setting the xi_Q(s) to the xi_LS
poisson = (1.+xis_q) * (sqrt(2./DD)) ; Poisson errors, da Angela et al. (2005).

loadct, 6  ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='xis_DR5_quasars_jackknife_errs_temp.ps', $
        xsize=7.5, ysize=6.0, /inches, /color
!p.multi=[0,1,2]

plot, s, xis_q, $
      /xlog, /ylog, $
      position=[0.14, 0.25, 0.98, 0.98], $      ; if top of 2 panels
      xrange=[0.5, 300], yrange=[0.001, 500], $ ; bring down to 500 w/o V. PREL.
      psym=4, $
      xstyle=1, ystyle=1, $
      charsize=2.2, charthick=4.2, $
      ytitle=' !7n(!3s)', $
      xtickformat='(a1)', ytickformat='(f6.2)', $
      /nodata, $
      color=0

plotsym,0, 1.25, /fill                                  ;for UNI22
oplot, s, xis_q, psym=8, thick=4, color=0               ;also psym=4 is nice.
oplot, s, xis_q, linestyle=0, thick=4, color=0
errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=0
errplot, s, (xis_q-jack),    (xis_q+jack), thick=8.0, color=128
errplot, s, (xis_q-poisson), (xis_q+poisson), thick=4.0, color=0

plot, s, (jack/poisson), $
      position=[0.14, 0.14, 0.98, 0.25], $
      xrange=[0.5, 300], yrange=[ 0., 2.], $ ; bring down to 500 w/o V. PREL.
      xstyle=1, ystyle=1, $
      /xlog



xyouts, 15.0, 128.0, 'SDSS DR5Q (uni)', charsize=2.2, charthick=6.2, color=0
;   xyouts, 5.0,20.0, 'SDSS DR5 ', charsize=2.2, charthick=6.2, color=0
xyouts, 15.0, 45.3,  '0.3 < z < 2.2 ', charsize=2.2, charthick=6.2, color=0
;   xyouts, 15.0, 16.0, 'Landy-Szalay', charsize=2.2, charthick=5.2, color=0
;   xyouts, 1.0, 1400, '!!!! V. PRELIMINARY RESULT !!!!', $
;           charsize=2.2, charthick=6.2, color=0
legend, [''], psym=8, box=0, position=[10.,256.]

!p.multi=0
device, /close
set_plot, 'X'



set_plot, 'ps'
device, filename='xis_DR5_quasars_Poisson_vs_JK_errs_temp.ps', $
        xsize=7.5, ysize=6.0, $
        /inches, /color, xoffset=0.14, yoffset=0.14
!p.multi=0

plot, s, (jack/poisson), $
      /xlog, $
      position=[0.14, 0.14, 0.98, 0.98], $      ; if top of 2 panels
      xrange=[0.8, 3500], yrange=[-0.1, 4.0], $ ; bring down to 500 w/o V. PREL.
      psym=4, $
      xstyle=1, ystyle=1, $
      charsize=2.2, charthick=4.2, $
      xtitle=' s / h!E-1!N Mpc', $
      ytitle='error ratio', $
      xtickformat='(i5)', ytickformat='(f3.1)', $
;      /nodata, $
;      xcharsize=1.2, ycharsize=1.2, $
      color=0


plotsym,0, 1.25, /fill                                  ;for UNI22
oplot, s, (jack/poisson), psym=8, thick=4, color=0      ;also psym=4 is nice.
oplot, s, (jack/poisson), linestyle=0, thick=4, color=0

xyouts, 2.0, 3.5, 'SDSS DR5Q (uni)', charsize=2.2, charthick=6.2, color=0
xyouts, 2.0, 3.2,  '0.3 < z < 2.2 ', charsize=2.2, charthick=6.2, color=0
plotsym,0, 1.0, /fill        
legend, ['Jackknife/Poisson'], $
        psym=8, box=0, position=[1.5,2.9], $
        charsize=2.2, charthick=6.2

!p.multi=0
device, /close
set_plot, 'X'










close, /all


end
