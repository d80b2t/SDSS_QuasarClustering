;;+
;; NAME:
;;       qlf
;;
;; PURPOSE:
;;       To calculate Quasar Luminosity fucntions
;;
;; CALLING SEQUENCE:
;;       >  red, omega0=0.27, omegalambda=0.73, h100=0.719
;;       >  .run qlf
;;
;; INPUTS:
;;       An optical or infrared quasar redshift catalog.
;;
;; OUTPUTS:
;;       various
;;
;; PROCEDURES CALLED:
;;
;; COMMENTS:
;;       /usr/common/rsi/lib/general/LibAstro/ 
;;-
print
print

;; Setting up a flat, H0 = 71.9 kms^-1 Mpc^-1 cosmology
;; DLUMINOSITY will not work unless this is set-up...
red, omega0=0.27, omegalambda=0.73, h100=0.719
print
print

     readcol, '2SLAQ_QSO_mini.cat', ra, dec, $
              u_2slaq,  g_2slaq, r_2slaq, i_2slaq, z_2slaq, $
              red_2slaq
;     Absi_mag = 
   
   ;; Reading in the Richards06 k-correction
   ;; Normalized at z=2. 
;   readcol, 'Richards_2006_Table4.dat', kcor_redshift, kcor, /silent
;   print, 'Richards06_kcor.dat READ-IN', n_elements(kcor)
;   print
   

;; Running the DLUMINOSITY command from the red.pro routine
;; Returns LUMINOSITY DISTANCES (using the above cosmology)
;; Divide by 1e6 to get into Mpc

print, 'Doing DLUMS....'
dlums = DLUMINOSITY(red_2slaq) / 1e6
print, 'DLUMS calculated '
print


;; Setting up a "redshift" array that will
;; be used to produce Luminosity Distance values
zphot_limit   = (findgen(61))/10.

;; These luminosity distance values are then used
;; with the bright and faint Kmag limits for the 
;; e.g. Abs Mag vs. redshift plots.
dlumsK_limit =  DLUMINOSITY(zphot_limit) /1e6

;; Working out the ABSOLUTE MAGNITUDE for each object
;; Note DIST_MOD = 5 log (D_L /10pc) which means if D_L is in Mpc:
;Abs_iM = iflux - (5 * alog10(dlums))  - 25.00 +
;                 kcor(fix(redphot/0.01))
Abs_iM = i_2slaq - (5 * alog10(dlums))  - 25.00 + (-0.5)

print, 'Absolute i-band Mags calculated '
print

end
