
;; Plotting the chi^2 contours.
;; 

readcol, 'k_output_DR5Q_chisq/k_output_DR5Q_chisq_0pnt30z2pnt20_to25.dat', $ 
;readcol, 'k_output_DR5Q_chisq/k_output_DR5Q_chisq_0pnt30z2pnt20_to100.dat', $ 
;readcol, 'k_output_DR5Q_chisq_0pnt30z2pnt20_to20.dat', $ 
;readcol, 'k_output_DR5Q_chisq_0pnt30z2pnt20_to25.dat', $ 
;readcol, 'k_output_DR5Q_chisq_0pnt30z2pnt20_to100.dat', $ 
         chi2, bla, s0, gamm, bla2, bla2, format = 'd,d,d,d,i,i'
print, 'READ-IN, UNI22', n_elements(chi2_COV)
print

;readcol, 'k_output_DR5Q_chisq_1.dat', $ 
;readcol, 'k_output_DR5Q_chisq_0pnt30z2pnt20_to25_wFibre.dat', $ 
;readcol, 'k_output_DR5Q_chisq/k_output_DR5Q_chisq_0pnt30z2pnt20_to100.dat', $ 
readcol, '../../jackknife/xis/Build_up_of_chi_sq_using_REG_UNI22_25.dat', $
         chi2_COV, bla, s0_COV, gamm_COV, format = 'd,d,d,d'
print, 'READ-IN COV', n_elements(chi2_COV)
print
chi2_COV = chi2_COV/min(chi2)
;; Really not sure if this is a fair thing to do, but
;; puts the non-COV and COV calculated delta_chi_sqs
;; on a much more comparative footing...



;;readcol, 'k_output_DR5Q_chisq_1.dat', $ 
readcol, 'k_output_DR5Q_chisq_0pnt30z2pnt20_to25_wFibre.dat', $ 
;;readcol, 'k_output_DR5Q_chisq/k_output_DR5Q_chisq_0pnt30z2pnt20_to100.dat', $ 
;;readcol, '../../jackknife/Build_up_of_chi_sq_using_REG.dat', $
         chi2_fibre, bla, s0_fibre, gamm_fibre, format = 'd,d,d,d'
print, 'READ-IN wFibre', n_elements(chi2_fibre)
print










df_o2 = 11.-2.
sub2 = where(chi2 eq min(chi2))
sub2_COV = where(chi2_COV eq min(chi2_COV))
sub2_fibre = where(chi2_fibre eq min(chi2_fibre))

print
print, min(chi2) 
print, min(chi2_COV) 
print, min(chi2_fibre) 
print

print, 'UNI22'
print, 'at s0 =', s0(sub2)
print, 'and gamma=', gamm(sub2)
print, 'with a Reduced chi^2 minimum of', chi2(sub2);/df_o2
print
print
print, 'UNI22 COV'
print, 'at s0 =', s0(sub2_COV)
print, 'and gamma=', gamm(sub2_COV)
print, 'with a Reduced chi^2 minimum of', chi2(sub2_COV);/df_o2
print
print
print, 'UNI22 wFibre'
print, 'at s0 =', s0(sub2_fibre)
print, 'and gamma=', gamm(sub2_fibre)
print, 'with a Reduced chi^2 minimum of', chi2(sub2_fibre);/df_o2


chi2_ran       = chi2 - min(chi2)
somin_ran_o    = s0(sub2)
gammamin_ran_o = gamm(sub2)

chi2_ran_COV       = chi2_COV - min(chi2_COV)
somin_ran_o_COV    = s0(sub2_COV)
gammamin_ran_o_COV = gamm(sub2_COV)

chi2_ran_fibre       = chi2_fibre - min(chi2_fibre)
somin_ran_o_fibre    = s0(sub2_fibre)
gammamin_ran_o_fibre = gamm(sub2_fibre)


print
print
w = where(chi2_COV eq min(chi2_COV), N)
ww = where(abs(chi2_COV - min(chi2_COV)) le 1.00, N)
print, 'COV: s0 = ', s0_COV[w[0]], '+', (max(s0_COV[ww])-s0_COV[w[0]]), ' - ', (s0_COV[w[0]] - min(s0_COV[ww]))
print
print

print
print
w = where(chi2_fibre eq min(chi2_fibre), N)
ww = where(abs(chi2_fibre - min(chi2_fibre)) le 1.00, N)
print, 'wFibre: s0 = ', s0_fibre[w[0]], '+', (max(s0_fibre[ww])-s0_fibre[w[0]]), ' - ', (s0_fibre[w[0]] - min(s0_fibre[ww]))
print
print




;chi2_ran = chi2_ran/1.6*1.2
!p.multi = [0,1,1]

set_plot, 'ps'

device, file='fit_s0_gamma_rv1.ps', $
        xsize = 7.5, ysize = 6.5, $
        /inches, /color,$
        yoffset = 0.1, xoffset = 0.1

;##############################################################################


;contour, chi2_ran, gamm, s0, levels=[2.3,6.17,11.8], $
contour, chi2_ran, gamm, s0, $
         position=[0.14, 0.14, 0.98, 0.98], $
;         xrange=[0.0,4.99], $
;         xrange=[0.0,2.99], $
         xrange=[0.4,2.00], $
;         yrange=[0.0,15.0], $
         yrange=[2.0,10.0], $
         xstyle=1, ystyle=1, $ 
         levels=[1.0,4.00,9.00], $
         c_annotation = ['1!4r','2!4r','3!4r'], /irregular, $
         xtitle='!3!4c', $
         ytitle='!3s!D0', $
         c_linestyle = 0, c_thick = 4.2, $
         charsize = 2.3, xthick = 4.2, ythick = 4.2, charthick=4.2
;contour, chi2_ran_to20, gamm_to20, s0_to20, /overplot, linestyle=1
;contour, chi2_ran_to100, gamm_to20, s0_to20, /overplot, linestyle=1
oplot, [gammamin_ran_o], [somin_ran_o], psym = 6

xyouts, 1.0, 13., '!3SDSS DR5Q (uni)', charsize=2.2, charthick=4.2, color=0
xyouts, 1.0, 12., '0.30  < z < 2.20', charsize=2.2, charthick=4.2, color=0
xyouts, 1.0, 11., '1.0 < !8s!3 < 25.0 h!E-1!N Mpc', charsize=2.2, charthick=4.2, color=0
;xyouts, 1.0, 11., '1.0 < !8s!3 < 100.0 h!E-1!N Mpc', charsize=2.2, charthick=4.2, color=0



contour, chi2_ran_COV, gamm_COV, s0_COV, $
         levels=[1.0,4.00,9.00], $
         c_annotation = ['1!4r','2!4r','3!4r'], /irregular, $
         c_linestyle = 1, c_thick = 6, $
         /overplot, $
         charsize = 2.3, xthick = 6, ythick = 6, charthick=6, thick=6
oplot, [gammamin_ran_o_COV], [somin_ran_o_COV], psym = 4

xyouts, 1.0, 10., '!3 w/ Covariance', charsize=2.2, charthick=6, color=0
legend, [' '], box=0, position=[1.0,10.], linestyle=1, thick=6, color=0


contour, chi2_ran_fibre, gamm_fibre, s0_fibre, $
         levels=[1.0,4.00,9.00], $
         c_annotation = ['1!4r','2!4r','3!4r'], /irregular, $
         c_linestyle = 2, c_thick = 4.2, $
         /overplot, $
         charsize = 2.3, xthick = 4.2, ythick = 4.2, charthick=4.2
oplot, [gammamin_ran_o_fibre], [somin_ran_o_fibre], psym = 4

xyouts, 1.0, 10., '!3w/ Fibre Corr', charsize=2.2, charthick=4.2, color=0
legend, [' '], box=0, position=[1.0,10.], linestyle=2, thick=6, color=0











device, /close
set_plot, 'x'

print, 'done'


end
