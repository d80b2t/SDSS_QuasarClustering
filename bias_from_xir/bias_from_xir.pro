;; +
;;
;; Does what it says on the tin. Calculates the linear bias, b, 
;; from the xi(r) measurements. 
;;
;; These measurements are performed over the scales 1 < r 
;;
;; -

print
print


A = 0.2041253448
B = -1.0823273659
C = 0.0178005192

redshift = 1.27
read, redshift, PROMPT=' - What redshift are we at??    '

xi_rho =  A* (exp(B*redshift)) + C

rmax = 20.0
rmin = 1.0

gamma_r = 2.0
r_0 = 5.0
read, r_0, PROMPT=' - What is the r0 value we want to fit?   '


xi_r_bar = (3d / (r_max^3 - r_min^3)) * (rmax - rmin) * ((1./r_0)^(-2))
;xi_r_bar = (3d / (r_max^3 - r_min^3)) * 25.99856 * ((1./r_0)^(-1.9))

bias = (xi_r_bar / xi_rho)^(.5)

print
print, ' In that case, with r_max =  ', rmax, '  and r_min', rmin
print, ' and gamma', gamma_r, '  and r0', r_0
print, ' gives xi(r)_bar = ', xi_r_bar, ' and xi_rho =  ', xi_rho 
print, ' and thus, bias, b=', bias

print
print

end


