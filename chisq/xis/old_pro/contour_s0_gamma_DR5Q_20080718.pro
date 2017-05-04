
readcol, 'k_output_k_output_DR5Q_chisq_0pnt30z0pnt68.dat', chi2, bla, s0, gamm, bla2, bla2, format = 'd,d,d,d,i,i'
;readcol, '../w_theta_files/w_theta_2SLAQ_chisq_1_largescales.dat',
;chi2, bla, s0, gamm, bla2, bla2, format = 'd,d,d,d,d'
print, 'READ-IN'
print

readcol, '../idl/xir_r0_gamma_from_jackknifes_20070307.dat', no, r0_j, gamma_j, chi2_j
print, 'READ-IN'
print


df_o2 = 11.-2.
sub2 = where(chi2 eq min(chi2))

print
print, min(chi2) 
print

print, 'Reduced chi^2 minimum is', chi2(sub2);/df_o2
print, 'and gamma=', gamm(sub2)
print, 'at s0 =', s0(sub2)

chi2_ran  =  chi2 - min(chi2)

gammamin_ran_o = gamm(sub2)
somin_ran_o = s0(sub2)
;chi2_ran = chi2_ran/1.6*1.2
!p.multi = [0,1,1]

set_plot, 'ps'

device, file='fit_s0_gamma_rv1.ps', $
        xsize = 7.5, ysize = 6.5, /inches, /color,$
        yoffset = 2., xoffset = -1.

;##############################################################################


;contour, chi2_ran, gamm, s0, levels=[2.3,6.17,11.8], $
contour, chi2_ran, gamm, s0, $
         levels=[1.0,4.00,9.00], $
 c_annotation = ['1!4r','2!4r','3!4r'], /irregular, $
; xrange=[1.6,1.75], xstyle=1,yrange=[0.0,1.0], $
; xrange=[2.0,2.5], xstyle=1,yrange=[0.5,1.0], $
; xrange=[1.5,2.0], xstyle=1,yrange=[6.,9.], $            ; for  xi(s), xi(r) 
 xrange=[0.5,2.5], xstyle=1,yrange=[0.,10.], $          ; for   2SLAQ xi(s), small scales
; xrange=[1.5,2.2], xstyle=1,yrange=[6.,11.], $           ; for   2SLAQ xi(s), large scales
; xrange=[1.0,2.8], xstyle=1,yrange=[8.,11.], $           ; for AAOmega xi(s), all scales
; xrange=[0.0,2.5], xstyle=1,yrange=[0.,40.], $           ; very wide for xi(s), AAOmega small scales... 
; xrange=[1.6,2.2], xstyle=1,yrange=[10.,14.], $          ; very tight for xi(s), SDSS LRGs large scales... 

; xrange=[0.6,1.0], xstyle=1,yrange=[100.,1000.], $       ; for 2SLAQ wp(sigma)
; xrange=[0.0,1.0], xstyle=1,yrange=[100.,5000.], $       ; for AAOmega wp(sigma)
; xrange=[0.6,0.8], xstyle=1,yrange=[500.,2000.], $       ; for AAOmega wp(sigma), zoomed in 


; xrange=[0.0,3.0], xstyle=1,yrange=[0.,1.], $            ; for 2SLAQ w(theta)
; xrange=[0.0,3.0], xstyle=1,yrange=[0.,1.], $            ; for AAOmega w(theta)
; xrange=[0.6,1.0], xstyle=1,yrange=[6.,9.], $

 ystyle=1, xtitle='!3!4c', ytitle='!3r!D0', $
; ystyle=1, xtitle='!3!4c', ytitle='A', $

 c_linestyle = 0, c_thick = 0, charsize = 1.5, xthick = 2, ythick = 2, charthick=2


oplot, [gammamin_ran_o], [somin_ran_o], psym = 6


device, /close
set_plot, 'x'

print, 'done'


end
