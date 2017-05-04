;+
; NAME:
;       jackknife_DR5Q_UNI22_xis
;
; PURPOSE:
;       To calculate the jackknife errors from the UNIFORM DR5Q sample
;       on xi(s)
;
; EXPLANATION:
;
; CALLING SEQUENCE:
;       .run jackknife_DR5Q_UNI22_xis
;
; INPUTS:
;      The UNI22 xi(s) jackknife input files.
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
readcol, '../OP/OP_20080508/k_output_UNI22.dat', $
         s_log, s, xis_std, delta_xis, DD, DR, RR, xis_LS, xis_HAM, ratio
print, ' READ-IN FULL xi(s)   [OP_20080508/k_output_UNI22.dat]'
print 
no_subsamples = 0


readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N1.dat', $
         s_log_N1, s_N1, xis_std_N1, delta_xis_N1, DD_N1, DR_N1, RR_N1, $
         xis_LS_N1, xis_HAM_N1, ratio_N1
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N2.dat', $
         s_log_N2, s_N2, xis_std_N2, delta_xis_N2, DD_N2, DR_N2, RR_N2, $
         xis_LS_N2, xis_HAM_N2, ratio_N2
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N3.dat', $
         s_log_N3, s_N3, xis_std_N3, delta_xis_N3, DD_N3, DR_N3, RR_N3, $
         xis_LS_N3, xis_HAM_N3, ratio_N3
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N4.dat', $
         s_log_N4, s_N4, xis_std_N4, delta_xis_N4, DD_N4, DR_N4, RR_N4, $
         xis_LS_N4, xis_HAM_N4, ratio_N4
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N5.dat', $
         s_log_N5, s_N5, xis_std_N5, delta_xis_N5, DD_N5, DR_N5, RR_N5, $
         xis_LS_N5, xis_HAM_N5, ratio_N5
;-------------------------------------------------------------------------
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N6.dat', $
         s_log_N6, s_N6, xis_std_N6, delta_xis_N6, DD_N6, DR_N6, RR_N6, $
         xis_LS_N6, xis_HAM_N6, ratio_N6
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N7.dat', $
         s_log_N7, s_N7, xis_std_N7, delta_xis_N7, DD_N7, DR_N7, RR_N7, $
         xis_LS_N7, xis_HAM_N7, ratio_N7
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N8.dat', $
         s_log_N8, s_N8, xis_std_N8, delta_xis_N8, DD_N8, DR_N8, RR_N8, $
         xis_LS_N8, xis_HAM_N8, ratio_N8
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N9.dat', $
         s_log_N9, s_N9, xis_std_N9, delta_xis_N9, DD_N9, DR_N9, RR_N9, $
         xis_LS_N9, xis_HAM_N9, ratio_N9
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N10.dat', $
         s_log_N10, s_N10, xis_std_N10, delta_xis_N10, DD_N10, DR_N10, RR_N10, $
         xis_LS_N10, xis_HAM_N10, ratio_N10
no_subsamples = no_subsamples +1
;--------------------------------------------------------------------------------
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N11.dat', $
         s_log_N11, s_N11, xis_std_N11, delta_xis_N11, DD_N11, DR_N11, RR_N11, $
         xis_LS_N11, xis_HAM_N11, ratio_N11
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N12.dat', $
         s_log_N12, s_N12, xis_std_N12, delta_xis_N12, DD_N12, DR_N12, RR_N12, $
         xis_LS_N12, xis_HAM_N12, ratio_N12
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N13.dat', $
         s_log_N13, s_N13, xis_std_N13, delta_xis_N13, DD_N13, DR_N13, RR_N13, $
         xis_LS_N13, xis_HAM_N13, ratio_N13
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N14.dat', $
         s_log_N14, s_N14, xis_std_N14, delta_xis_N14, DD_N14, DR_N14, RR_N14, $
         xis_LS_N14, xis_HAM_N14, ratio_N14
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N15.dat', $
         s_log_N15, s_N15, xis_std_N15, delta_xis_N15, DD_N15, DR_N15, RR_N15, $
         xis_LS_N15, xis_HAM_N15, ratio_N15
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N16.dat', $
         s_log_N16, s_N16, xis_std_N16, delta_xis_N16, DD_N16, DR_N16, RR_N16, $
         xis_LS_N16, xis_HAM_N16, ratio_N16
no_subsamples = no_subsamples +1
;--------------------------------------------------------------------------------
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N17.dat', $
         s_log_N17, s_N17, xis_std_N17, delta_xis_N17, DD_N17, DR_N17, RR_N17, $
         xis_LS_N17, xis_HAM_N17, ratio_N17
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N18.dat', $
         s_log_N18, s_N18, xis_std_N18, delta_xis_N18, DD_N18, DR_N18, RR_N18, $
         xis_LS_N18, xis_HAM_N18, ratio_N18
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N19.dat', $
         s_log_N19, s_N19, xis_std_N19, delta_xis_N19, DD_N19, DR_N19, RR_N19, $
         xis_LS_N19, xis_HAM_N19, ratio_N19
no_subsamples = no_subsamples +1
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_N20.dat', $
         s_log_N20, s_N20, xis_std_N20, delta_xis_N20, DD_N20, DR_N20, RR_N20, $
         xis_LS_N20, xis_HAM_N20, ratio_N20
no_subsamples = no_subsamples +1
;--------------------------------------------------------------------------------
readcol, '../OP/OP_UNI22_jack_xis/k_output_UNI22_jack_S.dat', $
         s_log_S, s_S, xis_std_S, delta_xis_S, DD_S, DR_S, RR_S, $
         xis_LS_S, xis_HAM_S, ratio_S
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

RR_sub = [[RR_N1], [RR_N2], [RR_N3], [RR_N4], [RR_N5], [RR_N6], [RR_N7], [RR_N8], [RR_N9], [RR_N10], [RR_N11], [RR_N12], [RR_N13], [RR_N14], [RR_N15], [RR_N16], [RR_N17], [RR_N18], [RR_N19], [RR_N20]]

Cov_sum = 0d
;for i=0L, n_elements(s)-1 do begin
;   for j=0L, n_elements(s)-1 do begin

;   for ell=0L, n_elements(no_subsamples)-1 do begin
;      ;

Cov[i,j] = Cov_sum + (sqrt(RR_weight[l]/RR)*())  *  (sqrt())


;   endfor
;endfor




xis_q = xis_LS                       ; just setting the xi_Q(s) to the xi_LS
poisson = (1.+xis_q) * (sqrt(2./DD)) ; Poisson errors, da Angela et al. (2005).

loadct, 6  ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='xis_DR5_quasars_jackknifes_temp.ps', $
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

xyouts, 15.0, 128.0, 'SDSS DR5Q (uni)', charsize=2.2, charthick=6.2, color=0
;   xyouts, 5.0,20.0, 'SDSS DR5 ', charsize=2.2, charthick=6.2, color=0
xyouts, 15.0, 45.3,  '0.3 < z < 2.2 ', charsize=2.2, charthick=6.2, color=0
;   xyouts, 15.0, 16.0, 'Landy-Szalay', charsize=2.2, charthick=5.2, color=0
;   xyouts, 1.0, 1400, '!!!! V. PRELIMINARY RESULT !!!!', $
;           charsize=2.2, charthick=6.2, color=0
legend, [''], psym=8, box=0, position=[10.,256.]

!p.multi=0

end
