
readcol, 'k_output_DR5Q_chisq_0pnt30z0pnt68.dat', $
         chi2_0pnt30, red_chi2_0pnt30, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i'
print, 'READ-IN xi(s)   0.30 < z 0.68 '
print
readcol, 'k_output_DR5Q_chisq_0pnt68z0pnt92.dat', $
         chi2_0pnt68, red_chi2_0pnt68, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i'
print, 'READ-IN xi(s)   0. < z 0.68 '
print
readcol, 'k_output_DR5Q_chisq_0pnt92z1pnt13.dat', $
         chi2_0pnt92, red_chi2_0pnt92, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i'
print, 'READ-IN xi(s)   0.30 < z 0.68 '
print

readcol, 'k_output_DR5Q_chisq_1pnt13z1pnt32.dat', $
         chi2_1pnt13, red_chi2_1pnt13, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i'
print, 'READ-IN xi(s)   0.30 < z 0.68 '
print
readcol, 'k_output_DR5Q_chisq_1pnt32z1pnt50.dat', $
         chi2_1pnt32, red_chi2_1pnt32, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i'
print, 'READ-IN xi(s)   0.30 < z 0.68 '
print
readcol, 'k_output_DR5Q_chisq_1pnt50z1pnt66.dat', $
         chi2_1pnt50, red_chi2_1pnt50, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i'
print, 'READ-IN xi(s)   0.30 < z 0.68 '
print

readcol, 'k_output_DR5Q_chisq_1pnt66z1pnt83.dat', $
         chi2_1pnt66, red_chi2_1pnt66, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i'
print, 'READ-IN xi(s)   0.30 < z 0.68 '
print
readcol, 'k_output_DR5Q_chisq_1pnt83z2pnt02.dat', $
         chi2_1pnt83, red_chi2_1pnt83, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i'
print, 'READ-IN xi(s)   0.30 < z 0.68 '
print
readcol, 'k_output_DR5Q_chisq_2pnt02z2pnt20.dat', $
         chi2_2pnt02, red_chi2_2pnt02, s0, gamm, bla, bla2, format = 'd,d,d,d,i,i'
print, 'READ-IN xi(s)   0.30 < z 0.68 '
print


df_o2_0pnt30 = 13.-2.
df_o2_0pnt68 = 10.-2.
df_o2_0pnt92 =  9.-2.
df_o2_1pnt13 =  8.-2.
df_o2_1pnt32 =  9.-2.
df_o2_1pnt50 = 11.-2.
df_o2_1pnt66 = 11.-2.
df_o2_1pnt83 = 11.-2.
df_o2_2pnt02 = 11.-2.

sub2_00pnt30 = where(chi2_0pnt30 eq min(chi2_0pnt30))
sub2_00pnt30 = where(chi2_0pnt30 eq min(chi2_0pnt30))
sub2_00pnt30 = where(chi2_0pnt30 eq min(chi2_0pnt30))
sub2_00pnt30 = where(chi2_0pnt30 eq min(chi2_0pnt30))
sub2_00pnt30 = where(chi2_0pnt30 eq min(chi2_0pnt30))
sub2_00pnt30 = where(chi2_0pnt30 eq min(chi2_0pnt30))
sub2_00pnt30 = where(chi2_0pnt30 eq min(chi2_0pnt30))
sub2_00pnt30 = where(chi2_0pnt30 eq min(chi2_0pnt30))
sub2_00pnt30 = where(chi2_0pnt30 eq min(chi2_0pnt30))


print, min(chi2_0pnt30) 

print, 'Reduced chi^2 minimum is', chi2(sub2);/df_o2
print, 'and gamma=', gamm(sub2)
print, 'at s0 =', s0(sub2)
print

chi2_ran  =  chi2 - min(chi2)

gammamin_ran_o = gamm(sub2)
s0min_ran_o = s0(sub2)


set_plot, 'ps'
device, file='fit_s0_gamma_rv1_3by3.ps', $
        xsize = 7.5, ysize = 6.5, /inches, /color,$
        yoffset = 0.2., xoffset = 0.2.
!p.mulit=[0,3,3]

;##############################################################################


;contour, chi2_ran, gamm, s0, levels=[2.3,6.17,11.8], $
contour, chi2_ran, gamm, s0, $
         position=[0.14, 0.70, 0.42, 0.98], $
         xrange=[0.5,2.5], yrange=[0.,10.], $
         xstyle=1,ystyle=1, $ 
         levels=[1.0,4.00,9.00], $
         c_annotation = ['1!4r','2!4r','3!4r'], /irregular, $
         xtitle='!3!4c', $
         ytitle='!3r!D0', $
         xthick = 4.2, ythick = 4.2, $
         c_linestyle = 0, c_thick = 0, charsize = 2.2, charthick=4.2
oplot, [gammamin_ran_o], [somin_ran_o], psym = 6








device, /close
set_plot, 'x'

print, 'done'


end
