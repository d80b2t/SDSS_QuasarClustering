
print
print

readcol, 'k_output_DR5Q_chisq_0pnt30z0pnt68_to25.dat', $
         chi2_0pnt30, red_chi2_0pnt30, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i', /silent
print, 'READ-IN xi(s)   0.30 < z 0.68 '
readcol, 'k_output_DR5Q_chisq_0pnt68z0pnt92_to25.dat', $
         chi2_0pnt68, red_chi2_0pnt68, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i', /silent
print, 'READ-IN xi(s)   0.68 < z 0.92 '
readcol, 'k_output_DR5Q_chisq_0pnt92z1pnt13_to25.dat', $
         chi2_0pnt92, red_chi2_0pnt92, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i', /silent
print, 'READ-IN xi(s)   0.92 < z 1.13 '
print

readcol, 'k_output_DR5Q_chisq_1pnt13z1pnt32_to25.dat', $
         chi2_1pnt13, red_chi2_1pnt13, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i', /silent
print, 'READ-IN xi(s)   1.13 < z 1.32 '
readcol, 'k_output_DR5Q_chisq_1pnt32z1pnt50_to25.dat', $
         chi2_1pnt32, red_chi2_1pnt32, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i', /silent
print, 'READ-IN xi(s)   1.32 < z 1.50 '
readcol, 'k_output_DR5Q_chisq_1pnt50z1pnt66_to25.dat', $
         chi2_1pnt50, red_chi2_1pnt50, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i', /silent
print, 'READ-IN xi(s)   1.50 < z 1.66 '
print

readcol, 'k_output_DR5Q_chisq_1pnt66z1pnt83_to25.dat', $
         chi2_1pnt66, red_chi2_1pnt66, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i', /silent
print, 'READ-IN xi(s)   1.66 < z 1.83 '
readcol, 'k_output_DR5Q_chisq_1pnt83z2pnt02_to25.dat', $
         chi2_1pnt83, red_chi2_1pnt83, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i', /silent
print, 'READ-IN xi(s)   1.83 < z 2.02 '
readcol, 'k_output_DR5Q_chisq_2pnt02z2pnt20_to25.dat', $
         chi2_2pnt02, red_chi2_2pnt02, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i', /silent
print, 'READ-IN xi(s)   2.02 < z 2.20 '
print


df_o2_0pnt30 = 13.-2.
df_o2_0pnt68 = 11.-2.
df_o2_0pnt92 =  9.-2.
df_o2_1pnt13 =  8.-2.
df_o2_1pnt32 =  9.-2.
df_o2_1pnt50 = 10.-2.
df_o2_1pnt66 =  8.-2.
df_o2_1pnt83 =  9.-2.
df_o2_2pnt02 =  7.-2.
;df_o2_2pnt25 =  5.-2.

sub2_0pnt30 = where(chi2_0pnt30 eq min(chi2_0pnt30))
sub2_0pnt68 = where(chi2_0pnt68 eq min(chi2_0pnt68))
sub2_0pnt92 = where(chi2_0pnt92 eq min(chi2_0pnt92))
sub2_1pnt13 = where(chi2_1pnt13 eq min(chi2_1pnt13))
sub2_1pnt32 = where(chi2_1pnt32 eq min(chi2_1pnt32))
sub2_1pnt50 = where(chi2_1pnt50 eq min(chi2_1pnt50))
sub2_1pnt66 = where(chi2_1pnt66 eq min(chi2_1pnt66))
sub2_1pnt83 = where(chi2_1pnt83 eq min(chi2_1pnt83))
sub2_2pnt02 = where(chi2_2pnt02 eq min(chi2_2pnt02))


print, min(chi2_0pnt30) 

print, 'at s0 =', s0(sub2_0pnt30)
print, 'and gamma=', gamm(sub2_0pnt30)
print, 'with Reduced chi^2 minimum is', chi2_0pnt30(sub2_0pnt30) ;/df_o2
print

chi2_ran_0pnt30  =  chi2_0pnt30 - min(chi2_0pnt30)
chi2_ran_0pnt68  =  chi2_0pnt68 - min(chi2_0pnt68)
chi2_ran_0pnt92  =  chi2_0pnt92 - min(chi2_0pnt92)
chi2_ran_1pnt13  =  chi2_1pnt13 - min(chi2_1pnt13)
chi2_ran_1pnt32  =  chi2_1pnt32 - min(chi2_1pnt32)
chi2_ran_1pnt50  =  chi2_1pnt50 - min(chi2_1pnt50)
chi2_ran_1pnt66  =  chi2_1pnt66 - min(chi2_1pnt66)
chi2_ran_1pnt83  =  chi2_1pnt83 - min(chi2_1pnt83)
chi2_ran_2pnt02  =  chi2_2pnt02 - min(chi2_2pnt02)

gammamin_ran_0pnt30 = gamm(sub2_0pnt30)
gammamin_ran_0pnt68 = gamm(sub2_0pnt68)
gammamin_ran_0pnt92 = gamm(sub2_0pnt92)
gammamin_ran_1pnt13 = gamm(sub2_1pnt13)
gammamin_ran_1pnt32 = gamm(sub2_1pnt32)
gammamin_ran_1pnt50 = gamm(sub2_1pnt50)
gammamin_ran_1pnt66 = gamm(sub2_1pnt66)
gammamin_ran_1pnt83 = gamm(sub2_1pnt83)
gammamin_ran_2pnt02 = gamm(sub2_2pnt02)

s0min_ran_0pnt30 = s0(sub2_0pnt30)
s0min_ran_0pnt68 = s0(sub2_0pnt68)
s0min_ran_0pnt92 = s0(sub2_0pnt92)
s0min_ran_1pnt13 = s0(sub2_1pnt13)
s0min_ran_1pnt32 = s0(sub2_1pnt32)
s0min_ran_1pnt50 = s0(sub2_1pnt50)
s0min_ran_1pnt66 = s0(sub2_1pnt66)
s0min_ran_1pnt83 = s0(sub2_1pnt83)
s0min_ran_2pnt02 = s0(sub2_2pnt02)


print, 'gamma_min, s0_min'

loadct, 6
set_plot, 'ps'
device, file='fit_s0_gamma_rv1_3by3.ps', $
        xsize = 8.5, ysize = 7.5, $
        /inches, /color,$
        xoffset = 0.0, yoffset = 0.2
!p.multi=[0,3,3]

;##############################################################################


;; 
;; TOP ROW   TOP ROW   TOP ROW   TOP ROW   TOP ROW   TOP ROW  TOP ROW
;;
contour, chi2_ran_0pnt30, gamm, s0, $
         position=[0.14, 0.70, 0.42, 0.98], $
         xrange=[0.0,2.99], yrange=[0.0,15.0], $
         xstyle=1,ystyle=1, $ 
         levels=[1.0,4.00,9.00], $
         c_annotation = ['1!4r','2!4r','3!4r'], /irregular, $
         ytitle='!3s!D0', ycharsize=1.4, $
         xtickformat='(a1)', $
         ytickformat='(i3)', $
         xthick = 4.2, ythick = 4.2, $
         c_linestyle = 0, c_thick = 0, charsize = 2.2, charthick=4.2
oplot, [gammamin_ran_0pnt30], [s0min_ran_0pnt30], psym = 6
;contour, chi2_ran_0pnt30, gamm, s0, /overplot, color=240
xyouts, 1.5, 12., '<!3z>=0.49', charsize=1.2, charthick=4.2, color=240
print, '<!3z>=0.49', gammamin_ran_0pnt30, s0min_ran_0pnt30


contour, chi2_ran_0pnt68, gamm, s0, $
         position=[0.42, 0.70, 0.70, 0.98], $
         xrange=[0.0,2.99], yrange=[0.0,15.0], $
         xstyle=1,ystyle=1, $ 
         levels=[1.0,4.00,9.00], $
         c_annotation = ['1!4r','2!4r','3!4r'], /irregular, $
         xtickformat='(a1)', $
         ytickformat='(a1)', $
         xthick = 4.2, ythick = 4.2, $
         c_linestyle = 0, c_thick = 0, charsize = 2.2, charthick=4.2
oplot, [gammamin_ran_0pnt68], [s0min_ran_0pnt68], psym = 6
xyouts, 1.5, 12., '<!3z>=0.80', charsize=1.2, charthick=4.2, color=240
print, '<!3z>=0.80', gammamin_ran_0pnt68, s0min_ran_0pnt68

contour, chi2_ran_0pnt92, gamm, s0, $
         position=[0.70, 0.70, 0.98, 0.98], $
         xrange=[0.0,2.99], yrange=[0.0,15.0], $
         xstyle=1,ystyle=1, $ 
         levels=[1.0,4.00,9.00], $
         c_annotation = ['1!4r','2!4r','3!4r'], /irregular, $
         xtickformat='(a1)', $
         ytickformat='(a1)', $
         xthick = 4.2, ythick = 4.2, $
         c_linestyle = 0, c_thick = 0, charsize = 2.2, charthick=4.2
gammamin_ran_0pnt92 = mean(gammamin_ran_0pnt92)
s0min_ran_0pnt92    = mean(s0min_ran_0pnt92)
oplot, [gammamin_ran_0pnt92], [s0min_ran_0pnt92], psym = 6
xyouts, 1.5, 12., '<!3z>=1.03', charsize=1.2, charthick=4.2, color=192
print,'<!3z>=1.03', gammamin_ran_0pnt92, s0min_ran_0pnt92


;; 
;; MIDDLE ROW    MIDDLE ROW    MIDDLE ROW   MIDDLE ROW
;;
contour, chi2_ran_1pnt13, gamm, s0, $
         position=[0.14, 0.42, 0.42, 0.70], $
         xrange=[0.0,2.99], yrange=[0.0,15.0], $
         xstyle=1,ystyle=1, $ 
         levels=[1.0,4.00,9.00], $
         c_annotation = ['1!4r','2!4r','3!4r'], /irregular, $
         ytitle='!3s!D0', ycharsize=1.4, $
         xtickformat='(a1)', $
         ytickformat='(i3)', $
         xthick = 4.2, ythick = 4.2, $
         c_linestyle = 0, c_thick = 0, charsize = 2.2, charthick=4.2
;gammamin_ran_1pnt13 = mean(gammamin_ran_1pnt13)
;s0min_ran_1pnt13    = mean(s0min_ran_1pnt13)
oplot, [gammamin_ran_1pnt13], [s0min_ran_1pnt13], psym = 6
xyouts, 1.5, 12., '<!3z>=1.23', charsize=1.2, charthick=4.2, color=168
print,'<!3z>=1.23', gammamin_ran_1pnt13, s0min_ran_1pnt13

contour, chi2_ran_1pnt32, gamm, s0, $
         position=[0.42, 0.42, 0.70, 0.70], $
         xrange=[0.0,2.99], yrange=[0.0,15.0], $
         xstyle=1,ystyle=1, $ 
         levels=[1.0,4.00,9.00], $
         c_annotation = ['1!4r','2!4r','3!4r'], /irregular, $
         xtickformat='(a1)', $
         ytickformat='(a1)', $
         xthick = 4.2, ythick = 4.2, $
         c_linestyle = 0, c_thick = 0, charsize = 2.2, charthick=4.2
gammamin_ran_1pnt32 = mean(gammamin_ran_1pnt32)
s0min_ran_1pnt32    = mean(s0min_ran_1pnt32)
oplot, [gammamin_ran_1pnt32], [s0min_ran_1pnt32], psym = 6
xyouts, 1.5, 12., '<!3z>=1.41', charsize=1.2, charthick=4.2, color=144
print,'<!3z>=1.41', gammamin_ran_1pnt32, s0min_ran_1pnt32


contour, chi2_ran_1pnt50, gamm, s0, $
         position=[0.70, 0.42, 0.98, 0.70], $
         xrange=[0.0,2.99], yrange=[0.0,15.0], $
         xstyle=1,ystyle=1, $ 
         levels=[1.0,4.00,9.00], $
         c_annotation = ['1!4r','2!4r','3!4r'], /irregular, $
         xtickformat='(a1)', $
         ytickformat='(a1)', $
         xthick = 4.2, ythick = 4.2, $
         c_linestyle = 0, c_thick = 0, charsize = 2.2, charthick=4.2
gammamin_ran_1pnt50 = mean(gammamin_ran_1pnt50)
s0min_ran_1pnt50    = mean(s0min_ran_1pnt50)
oplot, [gammamin_ran_1pnt50], [s0min_ran_1pnt50], psym = 6
xyouts, 1.5, 12., '<!3z>=1.58', charsize=1.2, charthick=4.2, color=120
print,'<!3z>=1.58', gammamin_ran_1pnt50, s0min_ran_1pnt50

;; 
;; BOTTOM ROW
;;
contour, chi2_ran_1pnt66, gamm, s0, $
         position=[0.14, 0.14, 0.42, 0.42], $
         xrange=[0.0,2.99], yrange=[0.0,15.0], $
         xstyle=1,ystyle=1, $ 
         levels=[1.0,4.00,9.00], $
         c_annotation = ['1!4r','2!4r','3!4r'], /irregular, $
         xtitle='!3!4c', xcharsize=1.4, $
         ytitle='!3s!D0', ycharsize=1.4, $
         xthick = 4.2, ythick = 4.2, $
         c_linestyle = 0, c_thick = 0, charsize = 2.2, charthick=4.2
oplot, [gammamin_ran_1pnt66], [s0min_ran_1pnt66], psym = 6
xyouts, 1.5, 12., '<!3z>=1.74', charsize=1.2, charthick=4.2, color=96
print,'<!3z>=1.74', gammamin_ran_1pnt66, s0min_ran_1pnt66

contour, chi2_ran_1pnt83, gamm, s0, $
         position=[0.42, 0.14, 0.70, 0.42], $
         xrange=[0.0,2.99], yrange=[0.0,15.0], $
         xstyle=1,ystyle=1, $ 
         levels=[1.0,4.00,9.00], $
         c_annotation = ['1!4r','2!4r','3!4r'], /irregular, $
         xtitle='!3!4c', xcharsize=1.4, $
         ytickformat='(a1)', $
         xthick = 4.2, ythick = 4.2, $
         c_linestyle = 0, c_thick = 0, charsize = 2.2, charthick=4.2
gammamin_ran_1pnt83 = mean(gammamin_ran_1pnt83)
s0min_ran_1pnt83    = mean(s0min_ran_1pnt83)
oplot, [gammamin_ran_1pnt83], [s0min_ran_1pnt83], psym = 6
xyouts, 1.5, 12., '<!3z>=1.92', charsize=1.2, charthick=4.2, color=72
print,'<!3z>=1.92', gammamin_ran_1pnt83, s0min_ran_1pnt83

contour, chi2_ran_2pnt02, gamm, s0, $
         position=[0.70, 0.14, 0.98, 0.42], $
         xrange=[0.0,2.99], yrange=[0.0,15.0], $
         xstyle=1,ystyle=1, $ 
         levels=[1.0,4.00,9.00], $
         c_annotation = ['1!4r','2!4r','3!4r'], /irregular, $
         xtitle='!3!4c', xcharsize=1.4, $
         ytickformat='(a1)', $
         xthick = 4.2, ythick = 4.2, $
         c_linestyle = 0, c_thick = 0, charsize = 2.2, charthick=4.2
gammamin_ran_2pnt02 = mean(gammamin_ran_2pnt02)
s0min_ran_2pnt02    = mean(s0min_ran_2pnt02)
oplot, [gammamin_ran_2pnt02], [s0min_ran_2pnt02], psym = 6
xyouts, 1.5, 12., '<!3z>=2.10', charsize=1.2, charthick=4.2, color=48
print, '<!3z>=2.10',gammamin_ran_2pnt02, s0min_ran_2pnt02


!p.multi=0
device, /close
set_plot, 'x'

print, 'done'


end
