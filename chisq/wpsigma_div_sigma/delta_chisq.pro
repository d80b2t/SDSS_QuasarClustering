;;
;;
;;
;;

readcol, 'fort.20', chi_sq, red_chi_sq, s_nought, gamma

print
print, 'chi_sq MIN = ', min(chi_sq)
indx_chisq_min = where(chi_sq eq min(chi_sq), N_one)

print, 's0 at chisq min', s_nought(indx_chisq_min)



w = where(chi_sq lt ((min(chi_sq)+1.00)))

print
print, 'min(s_nought[w])',  min(s_nought[w])
print, 'max(s_nought[w])',  max(s_nought[w])

plus = abs( s_nought(indx_chisq_min) -max(s_nought[w]))
minus =   abs( s_nought(indx_chisq_min) -min(s_nought[w]))
print
print, 'Implies you have an r0 = ', s_nought(indx_chisq_min[0]), ' + ', plus,' - ', minus, format='(a, d9.5,a, d9.5,a,d9.5)'

end
