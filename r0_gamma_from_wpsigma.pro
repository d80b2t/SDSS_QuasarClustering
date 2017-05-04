;;+
;;
;;
;;-


readcol, 'OP/OP_20080508/K_wp_output_UNI22.dat', $
         sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
         bin_DD_sigma, bin_DR_sigma, $
         Xi_sigma_HAM, Xi_sigma_LS


;; From eg. Hawkins, 2003, MNRAS, 346, 78, eq. (6)
;;          Magliocchetti, 2004, MNRAS, 350, 1485, eq. (4) 


sigma_min=1.0
;read, sigma_min, PROMPT=' sigma_min?    '
print, 'sigma_min = ', sigma_min
print

gamma_fixed = 2.0d

gamma_1 = GAMMA(0.5d)
gamma_2 = GAMMA((gamma_fixed -1.0d) / 2.0d)
gamma_3 = GAMMA(gamma_fixed / 2.0d)

A = (gamma_1 * gamma_2) / gamma_3


w = where(Xi_sigma_LS gt 0. and sigma gt sigma_min, N)
r_nought = ( Xi_sigma_LS[w] / ( (sigma[w]^(1.0d - gamma_fixed)) *A) ) ^ $
           (1.0d/(gamma_fixed))

print, 'i, gamma_fixed, sigma(i), Xi_sigma_LS(i),  r_nought(i)'
for i = 0L, n_elements(sigma[w])-1 do begin
;   wp_test = 
   print, i, gamma_fixed, sigma(i), Xi_sigma_LS(i),  r_nought(i)
endfor

print
print, 'r_0 for OP_20080508/K_wp_output_UNI22.dat', mean(r_nought), '  +/-', stddev(r_nought),   '   from ', n_elements(Xi_sigma_LS[w]), ' points, thus SEM =', stddev(r_nought)/ (sqrt(n_elements(Xi_sigma_LS[w])))
print
print


;; 
;; 0.00 < z < 0.30
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt00z0pnt30.dat", $
         sigma_0pnt00, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt00, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt00, /silent
;print,   'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt00z0pnt30.dat read-in '

w = where(Xi_sigma_LS_0pnt00 gt 0. and sigma_0pnt00 gt sigma_min, N)
r_nought_0pnt00 = (Xi_sigma_LS_0pnt00[w] / ((sigma_0pnt00[w]^(1.0d - gamma_fixed))*A)) $
                  ^ (1.0d/(gamma_fixed))
print, '   r0   for   0.00 < z < 0.30  ', mean(r_nought_0pnt00), $
       '  +/-', stddev(r_nought_0pnt00), '  from ', n_elements(Xi_sigma_LS_0pnt00[w]), $
       ' points, thus SEM =', stddev(r_nought_0pnt00)/ (sqrt(n_elements(Xi_sigma_LS_0pnt00[w])))
print
print


;; 
;; 0.30 < z < 0.68
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt30z0pnt68.dat", $
         sigma_0pnt30, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt30, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt30, /silent
;; same as OP/OP_20080121/K_wp_output_UNI22_0pnt30z0pnt68.dat

w = where(Xi_sigma_LS_0pnt30 gt 0. and sigma_0pnt30 gt sigma_min, N)
r_nought_0pnt30 = (Xi_sigma_LS_0pnt30[w] / ((sigma_0pnt30[w]^(1.0d - gamma_fixed))*A)) $
                  ^ (1.0d/(gamma_fixed))
;print, N, w, A, gamma_fixed
print, '   r0   for   0.30 < z < 0.68 ', mean(r_nought_0pnt30), $
       '  +/-', stddev(r_nought_0pnt30), '  from ', n_elements(Xi_sigma_LS_0pnt30[w]), $
       ' points, thus SEM =', stddev(r_nought_0pnt30)/ (sqrt(n_elements(Xi_sigma_LS_0pnt30[w])))
print
print


;;
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt68z0pnt92.dat", $
         sigma_0pnt68, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt68, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt68, /silent
;; same as OP/OP_20080122b/K_wp_output_UNI22_0pnt68z0pnt92.dat

w = where(Xi_sigma_LS_0pnt68 gt 0. and sigma_0pnt68 gt sigma_min, N)
r_nought_0pnt68 = (Xi_sigma_LS_0pnt68[w]/ ((sigma_0pnt68[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, '   r0   for  0.68 < z < 0.92  ', mean(r_nought_0pnt68), '  +/-', stddev(r_nought_0pnt68), '  from ', n_elements(Xi_sigma_LS_0pnt68[w]), ' points, thus SEM =', stddev(r_nought_0pnt68)/ (sqrt(n_elements(Xi_sigma_LS_0pnt68[w])))
print
print


;;
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt92z1pnt13.dat", $
         sigma_0pnt92, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt92, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt92, /silent
;; same as OP/OP_20080123/K_wp_output_UNI22_0pnt92z1pnt13.dat


w = where(Xi_sigma_LS_0pnt92 gt 0. and sigma_0pnt92 gt sigma_min, N)
r_nought_0pnt92 = (Xi_sigma_LS_0pnt92[w] / ((sigma_0pnt92[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, '  r0  for  0.92 < z <  1.13 ', mean(r_nought_0pnt92), '  +/-', stddev(r_nought_0pnt92), '  from ', n_elements(Xi_sigma_LS_0pnt92[w]), ' points,  thus SEM =', stddev(r_nought_0pnt92)/ (sqrt(n_elements(Xi_sigma_LS_0pnt92[w])))
print
print



;;
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt13z1pnt32.dat", $
         sigma_1pnt13, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt13, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt13, /silent

w = where(Xi_sigma_LS_1pnt13 gt 0. and sigma_1pnt13 gt sigma_min, N)
r_nought_1pnt13 = (Xi_sigma_LS_1pnt13[w] / ((sigma_1pnt13[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, '   r0  for  1.13 < z < 1.32 ', mean(r_nought_1pnt13), '  +/-', stddev(r_nought_1pnt13), '  from ', n_elements(Xi_sigma_LS_1pnt13[w]), ' points, thus SEM =', stddev(r_nought_1pnt13)/ (sqrt(n_elements(Xi_sigma_LS_1pnt13[w])))
print
print


;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt32z1pnt50.dat", $
         sigma_1pnt32, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt32, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt32, /silent
;; same as OP/OP_20080215/K_wp_output_20080215_1pnt32z1pnt50.dat

w = where(Xi_sigma_LS_1pnt32 gt 0. and sigma_1pnt32 gt sigma_min, N)
r_nought_1pnt32 = (Xi_sigma_LS_1pnt32[w] / ((sigma_1pnt32[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, '   r0  for  1.32 < z < 1.50  ', mean(r_nought_1pnt32), '  +/-', stddev(r_nought_1pnt32), '  from ', n_elements(Xi_sigma_LS_1pnt32[w]), ' points, thus SEM =', stddev(r_nought_1pnt32)/ (sqrt(n_elements(Xi_sigma_LS_1pnt32[w])))
print
print


;;
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt50z1pnt66.dat", $
         sigma_1pnt50, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt50, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt50, /silent

w = where(Xi_sigma_LS_1pnt50 gt 0. and sigma_1pnt50 gt sigma_min, N)
r_nought_1pnt50 = (Xi_sigma_LS_1pnt50[w] / ((sigma_1pnt50[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, '   r0  for   1.50 < z < 1.66  ', mean(r_nought_1pnt50), '  +/-', stddev(r_nought_1pnt50), '  from ', n_elements(Xi_sigma_LS_1pnt50[w]), ' points, thus SEM =', stddev(r_nought_1pnt50)/ (sqrt(n_elements(Xi_sigma_LS_1pnt50[w])))
print
print


;;
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt66z1pnt83.dat", $
         sigma_1pnt66, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt66, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt66, /silent

w = where(Xi_sigma_LS_1pnt66 gt 0. and sigma_1pnt66 gt sigma_min, N)
r_nought_1pnt66 = (Xi_sigma_LS_1pnt66[w] / ((sigma_1pnt66[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, '   r0  for   1.66 < z < 1.83 ', mean(r_nought_1pnt66), '  +/-', stddev(r_nought_1pnt66), '  from ', n_elements(Xi_sigma_LS_1pnt66[w]), ' points, thus SEM =', stddev(r_nought_1pnt66)/ (sqrt(n_elements(Xi_sigma_LS_1pnt66[w])))
print
print


;;
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt83z2pnt02.dat", $
         sigma_1pnt83, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt83, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt83, /silent

w = where(Xi_sigma_LS_1pnt83 gt 0. and sigma_1pnt83 gt sigma_min, N)
r_nought_1pnt83 = (Xi_sigma_LS_1pnt83[w] / ((sigma_1pnt83[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, '   r0   for  1.83 < z < 2.02 ', mean(r_nought_1pnt83), '  +/-', stddev(r_nought_1pnt83), '  from ', n_elements(Xi_sigma_LS_1pnt83[w]), ' points, thus SEM =', stddev(r_nought_1pnt83)/ (sqrt(n_elements(Xi_sigma_LS_1pnt83[w])))
print
print


;;
;; 2.02 < z < 2.20
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/UNI22_evol_wpsigma/K_wp_output_UNI22_2pnt02z2pnt20.dat", $
         sigma_2pnt02, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_2pnt02, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_2pnt02, /SILENT
;print, "OP/UNI22_evol_wpsigma/K_wp_output_UNI22_2pnt02z2pnt20.dat"

w = where(Xi_sigma_LS_2pnt02 gt 0. and sigma gt sigma_min, N)
r_nought_2pnt02 = (Xi_sigma_LS_2pnt02[w] / ((sigma_2pnt02[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, '   r0   for   2.02 < z < 2.20  ', mean(r_nought_2pnt02), '  +/-', stddev(r_nought_2pnt02), '  from ', n_elements(Xi_sigma_LS_2pnt02[w]), ' points, thus SEM =', stddev(r_nought_2pnt02)/ (sqrt(n_elements(Xi_sigma_LS_2pnt02[w])))
print
print



;;
;; 2.20 < z < 2.90
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/UNI22_evol_wpsigma/K_wp_output_UNI22_2pnt20z2pnt90.dat", $
         sigma_2pnt20, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_2pnt20, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_2pnt20, /SILENT

w = where(Xi_sigma_LS_2pnt20 gt 0. and sigma_2pnt20 gt sigma_min, N)
r_nought_2pnt20 = (Xi_sigma_LS_2pnt20[w] / ((sigma_2pnt20[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, '   r0  for  2.20 < z < 2.90 ', mean(r_nought_2pnt20), '  +/-', stddev(r_nought_2pnt20), '  from ', n_elements(Xi_sigma_LS_2pnt20[w]), ' points, thus SEM =', stddev(r_nought_2pnt20)/ (sqrt(n_elements(Xi_sigma_LS_2pnt20[w])))
print
print


;;
;; Xray
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;readcol, "OP/UNI22_Xray/K_wp_output_UNI22_RASS_Xray_temp.dat", $
;         sigma_Xray, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_Xray, DR,  $
;         Xi_sigma_HAM, Xi_sigma_LS_Xray, /SILENT
;print, "OP/UNI22_evol_wpsigma/K_wp_output_UNI22_XRAY.dat"
print

;w = where(Xi_sigma_LS_Xray gt 0. and sigma gt sigma_min and sigma_Xray lt 30., N)
;r_nought_Xray = (Xi_sigma_LS_Xray[w] / ((sigma_Xray[w]^(1.0d - gamma_fixed))*A)) $
;           ^ (1.0d/(gamma_fixed))
;print, 'r_0 for OP_20080215e/K_wp_output_20080215_Xray.dat', mean(r_nought_Xray), '  +/-', stddev(r_nought_Xray), ;'  from ', n_elements(Xi_sigma_LS_Xray[w]), ' points, thus SEM =', stddev(r_nought_Xray)/ (sqrt(n_elements(Xi_sigm;a_LS_Xray[w])))
print
print





end
