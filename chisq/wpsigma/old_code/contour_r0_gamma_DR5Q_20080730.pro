
;; Plotting the chi^2 contours.
;; 

readcol, 'wp_sigma_DR5Q_chisq_2.dat', $ 
;readcol, 'k_output_DR5Q_chisq_0pnt30z2pnt20_to20.dat', $ 
;readcol, 'k_output_DR5Q_chisq_0pnt30z2pnt20_to25.dat', $ 
;readcol, 'k_output_DR5Q_chisq_0pnt30z2pnt20_to100.dat', $ 
         chi2, bla, s0, gamm, bla2, bla2, format = 'd,d,d,d,i,i'
print, 'READ-IN'
print



df_o2 = 11.-2.
sub2 = where(chi2 eq min(chi2))

print
print, min(chi2) 
print

print, 'at s0 =', s0(sub2)
print, 'and gamma=', gamm(sub2)
print, 'with a Reduced chi^2 minimum of', chi2(sub2);/df_o2

chi2_ran  =  chi2 - min(chi2)
somin_ran_o = s0(sub2)
gammamin_ran_o = gamm(sub2)

;chi2_ran = chi2_ran/1.6*1.2
!p.multi = [0,1,1]

set_plot, 'ps'

device, file='fit_r0_gamma_rv1.ps', $
        xsize = 7.5, ysize = 6.5, $
        /inches, /color,$
        yoffset = 0.1, xoffset = 0.1

;##############################################################################


;contour, chi2_ran, gamm, s0, levels=[2.3,6.17,11.8], $
contour, chi2_ran, gamm, s0, $
         position=[0.14, 0.14, 0.98, 0.98], $
         xrange=[0.0,4.99], $
;         xrange=[0.0,2.99], $
         yrange=[0.0,15.0], $
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
xyouts, 1.0, 12., '2.20  < z < 2.90', charsize=2.2, charthick=4.2, color=0
xyouts, 1.0, 11., '1.0 < !8s!3 < 100.0 h!E-1!N Mpc', charsize=2.2, charthick=4.2, color=0




device, /close
set_plot, 'x'

print, 'done'


end
