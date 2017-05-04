;+
;
;
;-


readcol, 'OP/OP_20080508/K_wp_output_UNI22.dat', $
         sigma, lg_sigma, Xi_sigma, delta_Xi_sigma, $
         bin_DD_sigma, bin_DR_sigma, $
         Xi_sigma_HAM, Xi_sigma_LS


;; From eg. Hawkins, 2003, MNRAS, 346, 78, eq. (6)
;;          Magliocchetti, 2004, MNRAS, 350, 1485, eq. (4) 

gamma_fixed = 1.8d

gamma_1 = GAMMA(0.5d)
gamma_2 = GAMMA((gamma_fixed -1.0d) / 2.0d)
gamma_3 = GAMMA(gamma_fixed / 2.0d)

A = (gamma_1 * gamma_2) / gamma_3


r_nought = ( Xi_sigma_LS / ( (sigma^(1.0d - gamma_fixed)) *A) ) ^ $
           (1.0d/(gamma_fixed))

print, 'i, gamma_fixed, sigma(i), Xi_sigma_LS(i),  r_nought(i)'
for i = 0L, n_elements(sigma)-1 do begin
;   wp_test = 
   print, i, gamma_fixed, sigma(i), Xi_sigma_LS(i),  r_nought(i)
endfor

print
print, 'r_0 for OP_20080508/K_wp_output_UNI22.dat', mean(r_nought), '  +/-', stddev(r_nought),   '   from ', n_elements(Xi_sigma_LS), ' points, thus SEM =', stddev(r_nought)/ (sqrt(n_elements(Xi_sigma_LS)))
print
print


;; 
;; 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/OP_20080121/K_wp_output_20080121_0pnt30z0pnt68.dat", $
         sigma_0pnt30, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt30, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt30, /silent
print, 'OP/OP_20080121/K_wp_output_20080121_0pnt30z0pnt68.dat read-in '
r_nought_0pnt30 = (Xi_sigma_LS_0pnt30 / ((sigma_0pnt30^(1.0d - gamma_fixed))*A)) $
                  ^ (1.0d/(gamma_fixed))
print, 'r_0 for OP_20080121/K_wp_output_20080121_0pnt30z0pnt68.dat', mean(r_nought_0pnt30), $
       '  +/-', stddev(r_nought_0pnt30), '  from ', n_elements(Xi_sigma_LS_0pnt30), $
       ' points, thus SEM =', stddev(r_nought_0pnt30)/ (sqrt(n_elements(Xi_sigma_LS_0pnt30)))

readcol, "OP/OP_20080121/K_wp_output_UNI22_0pnt30z0pnt68.dat", $
         sigma_0pnt30, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt30, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt30, /silent
print, 'OP/OP_20080121/K_wp_output_UNI22_0pnt30z0pnt68.dat read-in '
w = where(Xi_sigma_LS_0pnt30 gt 0., N)
r_nought_0pnt30 = (Xi_sigma_LS_0pnt30[w] / ((sigma_0pnt30[w]^(1.0d - gamma_fixed))*A)) $
                  ^ (1.0d/(gamma_fixed))
print, 'r_0 for OP_20080121/K_wp_output_UNI22_0pnt30z0pnt68.dat', mean(r_nought_0pnt30), $
       '  +/-', stddev(r_nought_0pnt30), '  from ', n_elements(Xi_sigma_LS_0pnt30[w]), $
       ' points, thus SEM =', stddev(r_nought_0pnt30)/ (sqrt(n_elements(Xi_sigma_LS_0pnt30[w])))
print
print


;;
;; 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/OP_20080122b/K_wp_output_20080122_0pnt68z0pnt92.dat", $
         sigma_0pnt68, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt68, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt68, /silent
print, 'OP/OP_20080122b/K_wp_output_20080122_0pnt68z0pnt92.dat read-in '
w = where(Xi_sigma_LS_0pnt68 gt 0., N)
r_nought_0pnt68 = (Xi_sigma_LS_0pnt68[w]/ ((sigma_0pnt68[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, 'r_0 for OP_20080122b/K_wp_output_20080122_0pnt68z0pnt92.dat', mean(r_nought_0pnt68), '  +/-', stddev(r_nought_0pnt68), '  from ', n_elements(Xi_sigma_LS_0pnt68[w]), ' points, thus SEM =', stddev(r_nought_0pnt68)/ (sqrt(n_elements(Xi_sigma_LS_0pnt68[w])))
readcol, "OP/OP_20080122b/K_wp_output_UNI22_0pnt68z0pnt92.dat", $
         sigma_0pnt68, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt68, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt68, /silent
print, 'OP/OP_20080122b/K_wp_output_UNI22_0pnt68z0pnt92.dat read-in '
w = where(Xi_sigma_LS_0pnt68 gt 0., N)
r_nought_0pnt68 = (Xi_sigma_LS_0pnt68[w]/ ((sigma_0pnt68[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, 'r_0 for OP_20080122b/K_wp_output_20080122_0pnt68z0pnt92.dat', mean(r_nought_0pnt68), '  +/-', stddev(r_nought_0pnt68), '  from ', n_elements(Xi_sigma_LS_0pnt68[w]), ' points, thus SEM =', stddev(r_nought_0pnt68)/ (sqrt(n_elements(Xi_sigma_LS_0pnt68[w])))
print
print


;;
;; 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/OP_20080123/K_wp_output_20080123_0pnt92z1pnt13.dat", $
         sigma_0pnt92, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt92, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt92, /silent
print, 'OP/OP_20080123/K_wp_output_20080123_0pnt92z1pnt13.dat read-in '
w = where(Xi_sigma_LS_0pnt92 gt 0., N)
r_nought_0pnt92 = (Xi_sigma_LS_0pnt92[w] / ((sigma_0pnt92[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, 'r_0 for OP_20080123/K_wp_output_20080123_0pnt92z1pnt13.dat', mean(r_nought_0pnt92), '  +/-', stddev(r_nought_0pnt92), '  from ', n_elements(Xi_sigma_LS_0pnt92[w]), ' points,  thus SEM =', stddev(r_nought_0pnt92)/ (sqrt(n_elements(Xi_sigma_LS_0pnt92[w])))
readcol, "OP/OP_20080123/K_wp_output_UNI22_0pnt92z1pnt13.dat", $
         sigma_0pnt92, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_0pnt92, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_0pnt92, /silent
print, 'OP/OP_20080123/K_wp_output_UNI22_0pnt92z1pnt13.dat read-in '
w = where(Xi_sigma_LS_0pnt92 gt 0., N)
r_nought_0pnt92 = (Xi_sigma_LS_0pnt92[w] / ((sigma_0pnt92[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, 'r_0 for OP_20080123/K_wp_output_20080123_0pnt92z1pnt13.dat', mean(r_nought_0pnt92), '  +/-', stddev(r_nought_0pnt92), '  from ', n_elements(Xi_sigma_LS_0pnt92[w]), ' points,  thus SEM =', stddev(r_nought_0pnt92)/ (sqrt(n_elements(Xi_sigma_LS_0pnt92[w])))
print
print




;;
;; 4 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/OP_20080124/K_wp_output_20080124_1pnt13z1pnt32.dat", $
         sigma_1pnt13, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt13, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt13
print, 'OP/OP_20080124/K_wp_output_20080124_1pnt13z1pnt32.dat read-in '
w = where(Xi_sigma_LS_1pnt13 gt 0., N)
r_nought_1pnt13 = (Xi_sigma_LS_1pnt13[w] / ((sigma_1pnt13[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, 'r_0 for OP_20080124/K_wp_output_20080124_1pnt13z1pnt32.dat', mean(r_nought_1pnt13), '  +/-', stddev(r_nought_1pnt13), '  from ', n_elements(Xi_sigma_LS_1pnt13[w]), ' points, thus SEM =', stddev(r_nought_1pnt13)/ (sqrt(n_elements(Xi_sigma_LS_1pnt13[w])))
print
print


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/OP_20080215/K_wp_output_20080215_1pnt32z1pnt50.dat", $
         sigma_1pnt32, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt32, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt32
print, 'OP/OP_20080215/K_wp_output_20080215_1pnt32z1pnt50.dat read-in '
w = where(Xi_sigma_LS_1pnt32 gt 0., N)
r_nought_1pnt32 = (Xi_sigma_LS_1pnt32[w] / ((sigma_1pnt32[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, 'r_0 for OP_20080124/K_wp_output_20080124_1pnt13z1pnt32.dat', mean(r_nought_1pnt32), '  +/-', stddev(r_nought_1pnt32), '  from ', n_elements(Xi_sigma_LS_1pnt32[w]), ' points, thus SEM =', stddev(r_nought_1pnt32)/ (sqrt(n_elements(Xi_sigma_LS_1pnt32[w])))
print
print


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/OP_20080215b/K_wp_output_20080215_1pnt50z1pnt66.dat", $
         sigma_1pnt50, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt50, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt50
print, 'OP/OP_20080215b/K_wp_output_20080215_1pnt50z1pnt66.dat read-in '
w = where(Xi_sigma_LS_1pnt50 gt 0., N)
r_nought_1pnt50 = (Xi_sigma_LS_1pnt50[w] / ((sigma_1pnt50[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, 'r_0 for /OP_20080215b/K_wp_output_20080215_1pnt50z1pnt66.dat', mean(r_nought_1pnt50), '  +/-', stddev(r_nought_1pnt50), '  from ', n_elements(Xi_sigma_LS_1pnt50[w]), ' points, thus SEM =', stddev(r_nought_1pnt50)/ (sqrt(n_elements(Xi_sigma_LS_1pnt50[w])))
print
print





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/OP_20080215c/K_wp_output_20080215_1pnt66z1pnt83.dat", $
         sigma_1pnt66, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt66, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt66
print, 'OP/OP_20080215c/K_wp_output_20080215_1pnt66z1pnt83.dat read-in '
w = where(Xi_sigma_LS_1pnt66 gt 0., N)
r_nought_1pnt66 = (Xi_sigma_LS_1pnt66[w] / ((sigma_1pnt66[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, 'r_0 for OP_20080215c/K_wp_output_20080215_1pnt66z1pnt83.dat', mean(r_nought_1pnt66), '  +/-', stddev(r_nought_1pnt66), '  from ', n_elements(Xi_sigma_LS_1pnt66[w]), ' points, thus SEM =', stddev(r_nought_1pnt66)/ (sqrt(n_elements(Xi_sigma_LS_1pnt66[w])))
print
print


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/OP_20080215d/K_wp_output_20080215_1pnt83z2pnt02.dat", $
         sigma_1pnt83, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_1pnt83, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_1pnt83
print, 'OP/OP_20080215d/K_wp_output_20080215_1pnt83z2pnt02.dat read-in '
w = where(Xi_sigma_LS_1pnt83 gt 0., N)
r_nought_1pnt83 = (Xi_sigma_LS_1pnt83[w] / ((sigma_1pnt83[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, 'r_0 for OP_20080215d/K_wp_output_20080215_1pnt83z2pnt02.dat', mean(r_nought_1pnt83), '  +/-', stddev(r_nought_1pnt83), '  from ', n_elements(Xi_sigma_LS_1pnt83[w]), ' points, thus SEM =', stddev(r_nought_1pnt83)/ (sqrt(n_elements(Xi_sigma_LS_1pnt83[w])))
print
print


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
readcol, "OP/OP_20080215e/K_wp_output_20080215_2pnt02z2pnt25.dat", $
         sigma_2pnt02, lg_sigma, Xi_sigma, delta_Xi_sigma, DD_2pnt02, DR,  $
         Xi_sigma_HAM, Xi_sigma_LS_2pnt02, /SILENT
print, 'OP/OP_20080215e/K_wp_output_20080215_2pnt02z2pnt25.dat read-in '
w = where(Xi_sigma_LS_2pnt02 gt 0., N)
r_nought_2pnt02 = (Xi_sigma_LS_2pnt02[w] / ((sigma_2pnt02[w]^(1.0d - gamma_fixed))*A)) $
           ^ (1.0d/(gamma_fixed))
print, 'r_0 for OP_20080215e/K_wp_output_20080215_2pnt02z2pnt25.dat', mean(r_nought_2pnt02), '  +/-', stddev(r_nought_2pnt02), '  from ', n_elements(Xi_sigma_LS_2pnt02[w]), ' points, thus SEM =', stddev(r_nought_2pnt02)/ (sqrt(n_elements(Xi_sigma_LS_2pnt02[w])))
print
print

print






end
