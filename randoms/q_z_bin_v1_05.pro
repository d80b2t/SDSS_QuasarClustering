;;+
;; NAME:
;;       q_z_bin_vX_xx.pro
;;
;; PURPOSE:
;;       To calculated redshift distribution fits to SDSS DR5 Quasar
;;       data, in order to produce an equivalent redshift distribtion 
;;       the randoms catalogues needed to do correlation functions. 
;;
;; EXPLANATION:
;;
;; CALLING SEQUENCE:
;;       .run q_z_bin_v1_01.pro
;;
;; INPUTS:
;;       None.
;;
;; OPTIONAL INPUTS:
;;       None.
;;
;; KEYWORD PARAMETERS:
;;       n/a
;;
;; OUTPUTS:
;;       various
;;
;; OPTIONAL OUTPUTS:
;;       also various
;;
;; COMMON BLOCKS:
;;       None.
;;
;; RESTRICTIONS:
;;
;; PROCEDURES CALLED:
;;
;; EXAMPLES:
;;
;; COMMENTS:
;;      PROPERLY COMMENT THIS AT SOME POINT IN THE V. NEAER FUTURE!!
;;
;; NOTES:
;;
;; MODIFICATION HISTORY:
;;       Version 1.00  NPR       ~15th October 2007
;;       Version 1.01  NPR       ~20th October 2007
;;               Generates N(z) for `homogeneous' DR5 quasars. ;
;;       Version 1.02  NPR       ~20th December 2007
;;               Produces random ra, decs and redshifts. Plots random N(z)
;;       Version 1.03  NPR        18th January 2008
;;               Produces ra,dec,z,rc writing to DR5QSO_uni_data.dat
;;               and randoms_npr.dat for F90 program. Introduced
;;               cosmology depedence.
;;-

print
print

No_bin = 60L                ;; 0.05 bins for redshift z=0->3...
;No_bin = 120L                ;; 0.05 bins for redshift z=0->6...
x       = fltarr(No_bin)
y       = fltarr(No_bin)
z_bin   = fltarr(No_bin)
z_bin_width = 0.05
counter = 0L

print
;readcol, '../maindr5spectro.par', $
readcol, '../maindr2345spectro.par', $
         drplatemj, plate, mjd, tile, plate_ra, plate_dec, $
         programName, programType, release, $
         format='(a, i, i, i, d,d, a,i,a)'
;print, 'READ-IN maindr5spectro.par', n_elements(plate)
print, 'READ-IN maindr2345spectro.par', n_elements(plate)
; maindr5spectro.par 1268   cf.  maindr5spectro_full.par 1280


;readcol, '../maindr1spectro.par', $
;         drplatemj, plate, mjd, plate_ra, plate_dec, $
;         format='(a, i, i, i, d,d)'
;print, 'READ-IN maindr1spectro.par', n_elements(plate)

print

radius = 1.49



print
choice='U'
;read, choice, PROMPT='UNIFORMS or PRIMARY or X-RAY??  U,P,X   '
print

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  UNIFORM
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if choice eq 'U' then begin
   print, 'UNIFORM'
   print
   print
   data   = mrdfits('../data/DR5QSO_uni_data.fits', 1)
   random = mrdfits('DR5QSO_uni_random_RADEC.fits', 1)

;   readcol, 'DR5Q_uni_data_double_wFibre.dat', $, 
   readcol, 'DR5Q_uni_data_wFibre_20080923.dat', $
            number, ra_wFibre, dec_wFibre, z_wFibre
   
   print
;   help, data, /str
   print
   help, data.ra
   help, data.dec
   help, data.z
   
   indx_z_cut29 = where(data.z le 2.9, N_z_cut29)
   indx_z_cut22 = where(data.z le 2.2, N_z_cut22)
   
   print
   print, 'N_z_cut,  z<=2.9', N_z_cut29
   print, 'N_z_cut,  z<=2.2', N_z_cut22
   
;   data_z_cut = data[indx_z_cut].z
;   data_z_cut = data
   data_z_cut = data[indx_z_cut29]
;   data_z_cut = data[indx_z_cut22]
   print
   help, data_z_cut
   help, data_z_cut.z
   
   openw, 11, 'DR5QSO_uni_data_temp.dat'
   for i=0L, N_elements(data.z)-1 do begin
;      lumd = lumdist(data[i].z, H0=100, Omega_M=0.24, Lambda0=0.76,
;      /SILENT)
      lumd = lumdist(data[i].z, H0=100, Omega_M=0.24, Lambda0=0.76, /SILENT)
      rc = lumd / (1.+data[i].z)
      printf, 11, data[i].ra, data[i].dec, data[i].z, rc
      counter = counter +1
   endfor

;;; add on the 431/625 objects with Fibre Collisions and photoz's:
   for i=0L, N_elements(z_wFibre)-1 do begin
      lumd = lumdist(z_wFibre, H0=100, Omega_M=0.24, Lambda0=0.76, /SILENT)
      rc = lumd / (1.+z_wFibre)
      printf, 11, ra_wFibre[i], dec_wFibre[i], z_wFibre[i], rc[i]
      counter = counter +1
   endfor

   close, 11

   for i=0L, n_elements(data_z_cut.z) -1  do begin
      d = fix((data_z_cut[i].z) * (1./z_bin_width))
;      print, i, data_z_cut[i].z, d
      z_bin(d) = z_bin(d) + 1
   endfor

   N_data = counter
endif



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  X RAY  (UNIFORM)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if choice eq 'X' then begin
   print, 'X-ray UNIFORMs'
   print
   print
   readcol, 'RASS_in_DR5Q_UNI.dat', ra, dec, z
   random = mrdfits('DR5QSO_uni_random_RADEC.fits', 1)
   
   print
;   help, data, /str
   print
   help, ra
   help, dec
   help, z
   
   indx_z_cut29 = where(z le 2.9, N_z_cut29)
   indx_z_cut22 = where(z le 2.2, N_z_cut22)
   
   print
   print, 'N_z_cut29,  z<=2.9', N_z_cut29
   print, 'N_z_cut22,  z<=2.2', N_z_cut22
   
;   data_z_cut = data[indx_z_cut].z
;   data_z_cut = data[indx_z_cut22]
;   print
;   help, data_z_cut
;   help, data_z_cut.z


   ;; For the X-ray data, it seems as if the Chunk78 data
   ;; is missing. Therefore, we'll apply the 'Plate Cuts' 
   ;; to the XRAY (uni) RANDOMS!!!
   
   
   openw, 11, 'DR5QSO_uni_Xray_data_temp.dat'
   for i=0L, N_elements(z)-1 do begin
      
      lumd = lumdist(z[i], H0=100, Omega_M=0.24, Lambda0=0.76, /SILENT)
      rc = lumd / (1.+z[i])
      printf, 11, ra[i], dec[i], z[i], rc, $
              format='(d18.12,1x, d18.12,1x, d18.12,1x, d18.12)'
      counter = counter +1

   endfor
   close, 11
   
   for i=0L, n_elements(z) -1  do begin
      d = fix((z[i]) * (1./z_bin_width))
;      print, i, data_z_cut[i].z, d
      z_bin(d) = z_bin(d) + 1
   endfor
   N_data = counter
endif



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  PRIMARY 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
radius = 1.49                   ; SDSS Plate radius 
if choice eq 'P' then begin
   print, '  PRIMARY '
   print
   print
   data   = mrdfits('../data/dr5qso.fits', 1)
;   random = mrdfits('ra_dec_randoms_20080307.fits', 1)
   readcol, '../../../data/Quasars/CAS/mask/ra_dec_eta_lambda_randoms/ra_dec_eta_lambda_randoms_20080515.dat', $ ;Oneline
            j, ra_rnd, dec_rnd, eta_rnd, lambda_rnd, sector_rnd, $
            format='(i,d,d,d,d, i, d, d)'
   print
;; 
;; randoms_20080519 has the bad fields taken out 

   
   indx_PRI   = where( ((data.TS_T_QSO     eq 1) or $
                        (data.TS_T_HIZ     eq 1) or $
                        (data.TS_T_FIRST   eq 1)) ,  N_TS_T_PRI)
   print, 'PRIMARYs', N_TS_T_PRI
   print

   indx_PRIz   = where( ((data.TS_T_QSO     eq 1) or $
                        (data.TS_T_HIZ     eq 1) or $
                        (data.TS_T_FIRST   eq 1) and $
                        (data.z            le 2.20)),  N_TS_T_PRIz)
   print, 'PRIMARYs  z < 2.2', N_TS_T_PRIz
   print
                
   indx_PRIz22  = where( ((data.TS_T_QSO     eq 1) or $
                          (data.TS_T_HIZ     eq 1) or $
                          (data.TS_T_FIRST   eq 1) and ( $
                          (data.z            ge 0.30) and $
                          (data.z            le 2.20))),  N_TS_T_PRIz22)
   print, 'PRIMARYs 0.30 < z < 2.20', N_TS_T_PRIz22
   
   data_ra_pri         = data[indx_PRIz].ra
   data_dec_pri        = data[indx_PRIz].dec
   data_z_pri          = data[indx_PRIz].z
   
   plate_dec_rad  = (!dpi/180.) *(plate_dec)
   plate_rmax = radius/(cos(plate_dec_rad))
   plate_rmin = radius
   
   openw, 11, 'DR5QSO_pri_data_temp.dat'
   for i=0L, n_elements(data_ra_pri)-1 do begin
      first =  (( data_ra_pri[i] -  plate_ra )^2)/(plate_rmax^2)
      second = ((data_dec_pri[i] - plate_dec )^2)/(plate_rmin^2)
      dist = first+second
      indx = where(dist le 1.00, N)
;      IMPOSE PLATE CUTS, SUCH THAT WE'RE NOT LOOKING AT e.g. chunk78
       
      if N ge 1 then begin
         lumd=lumdist(data_z_pri[i], H0=100, Omega_M=0.24,Lambda0=0.76, /SILENT)
         rc = lumd / (1. + data_z_pri[i])
         printf, 11, data_ra_pri[i], data_dec_pri[i], data_z_pri[i], rc
         
         d = fix((data_z_pri[i]  ) * (1./z_bin_width))
         z_bin(d) = z_bin(d) + 1
         counter = counter +1
      endif
   endfor
   close, 11
   N_data =  counter 
endif
   






openw, 9, 'z_values_temp.dat' 
printf, 9, '#  i,        z_bin,        no. ' 
for i=0L, No_bin-1 do begin
   printf, 9, i, (float(i*z_bin_width)), fix(z_bin(i))
   x[i] = (float(i*z_bin_width))
   y[i] = fix(z_bin(i))
endfor
close, 9   
help, x 
help, y
; x should be a given redshift (from the data)
; y should be the number of objects at that corresponding redshift,
; from the data





print
result = poly_fit(x,y,10, chisq=red_chi) 
;print, result
;for i=0L,10 do print, 'a',i , ' = ', result[i]
print, 'chi^2', red_chi
print


;fit = (result[6]*x^6) + (result[5]*x^5) + (result[4]*x^4) +
;      (result[3]*x^3) + (result[2]*x^2) + (result[1]*x) + (result[0])

fit1 = (result[10]*x^10) + (result[9]*x^9) + (result[8]*x^8) + $
       (result[7]*x^7) + (result[6]*x^6) + (result[5]*x^5) + $
       (result[4]*x^4) + (result[3]*x^3) + (result[2]*x^2) + $
       (result[1]*x)   + (result[0]) 

;fit = fit1

;print, 'fit3 = ((', result[10], ')*x^6) + ( (', result[11],')*x^5) + $
;((',result[12],')*x^4) + ((',result[13],')*x^3) + $
;((',result[14],')*x^2) + ((',result[15],')*x) + ', result[16]

;x = x+0.075 
; shifting the fit along the x-axis to the left by e.g. 0.075 redshift units
; N.B. This is mearly for plotting purposes. The actual random N(z)
; distribution will/would have to be changed below.

;fit[0] = 0.0001
;indx_fit = where(fit gt 0, N_fit)
;fit = fit(indx_fit)

openw, 8, 'DR5QSO_data_Nofz_fit_temp.dat'
for i=0L, n_elements(result)-1 do printf, 8, result[i]
close, 8

;;
;; Set the total number of randoms you would like
;;
N_random = (20L * N_data) +1 
N_random = N_random*4L
;; Since this number will drop with the e.g. DR1 plate cuts...
print, 'N_randoms', N_random
print

j=0L
random_z = fltarr(N_random)


if choice eq 'U' then norm=1146.
;if choice eq 'P' then norm=1644. ;for z_max=2.9
;if choice eq 'P' then norm=1500. ;for z_max=2.2, DR1
if choice eq 'P' then norm=1200. ;for z_max=2.2, DR2345
if choice eq 'X' then norm=1000. ;for z_max=2.2
REPEAT BEGIN
   trial = randomu(s) 
   prob =  randomu(s)

;   z_trial = (trial * 2.900)  
     z_trial = (trial * 2.800) + 0.100 
;   z_trial = (trial * 2.200)  
;   z_trial = (trial * 2.100)  + 0.100
;   z_trial = (trial * 1.900)  + 0.300


   z2=(result[10]*z_trial^10) + (result[9]*z_trial^9) + (result[8]*z_trial^8) + $
      (result[7]*z_trial^7) + (result[6]*z_trial^6) + (result[5]*z_trial^5) + $
      (result[4]*z_trial^4) + (result[3]*z_trial^3) + (result[2]*z_trial^2) + $
      (result[1]*z_trial)   + (result[0]) ;+ 0.1
   
   if (prob lt (z2 / norm)) then begin
      random_z[j] = z_trial
;;      random_z[j] = z_trial + 0.1  ;; BE V. V. V. CAREFUL HERE!!
      j = j+1
   endif
ENDREP UNTIL j eq (N_random)




;sp = replicate({ra: 0D, dec: 0D, z: 0D}, 1000000)
;sp.ra  = random.ra
;sp.dec = random.dec
;sp.z   = random_z
;mwrfits, sp, 'randoms_npr_temp.fits'

plate_dec_rad  = (!dpi/180.) *(plate_dec)
plate_rmax = radius/(cos(plate_dec_rad))
plate_rmin = radius

choice_two = 'n'
read, choice_two, PROMPT='  Make randoms_npr_temp.dat?   y/n    '
if choice_two eq 'y' then begin
   print, ' MAKING:  randoms_npr_temp.dat......'
   print
   openw, 10, 'randoms_npr_temp.dat'
   
   plate_dec_rad  = (!dpi/180.) *(plate_dec)
   plate_rmax = radius/(cos(plate_dec_rad))
   plate_rmin = radius


   for i=0L, 999999 do begin
;   lumd = lumdist(sp[i].z, H0=100, /SILENT)
      lumd = lumdist(random_z[i], H0=100, Omega_M=0.24, Lambda0=0.76,   /SILENT)
      rc=lumd/(1.+ random_z[i])
      
      if (choice eq 'U') then begin
;         for i=0L, N_elements(random.z)-1 do begin
         first =  ((  random[i].ra  -  plate_ra )^2)/(plate_rmax^2)
         second = (( random[i].dec  - plate_dec )^2)/(plate_rmin^2)
         dist = first+second
         indx = where(dist le 1.00, N)
;      IMPOSE PLATE CUTS, SUCH THAT WE'RE NOT LOOKING AT e.g. chunk78
         if N ge 1 then begin
            printf, 10, random[i].ra, random[i].dec, random_z[i], rc, $
                    format='(d16.8,1x, d16.8,1x, d10.6,1x, d16.8)'
         endif
      endif      

      if (choice eq 'X') then begin
         first =  ((  random[i].ra  -  plate_ra )^2)/(plate_rmax^2)
         second = (( random[i].dec  - plate_dec )^2)/(plate_rmin^2)
         dist = first+second
         indx = where(dist le 1.00, N)
         if N ge 1 then begin
            printf, 10, random[i].ra, random[i].dec, random_z[i], rc, $
                    format='(d16.8,1x, d16.8,1x, d10.6,1x, d16.8)'
         endif
      endif
      
      if choice eq 'P' then begin
         first =  ((  ra_rnd[i]  -  plate_ra )^2)/(plate_rmax^2)
         second = (( dec_rnd[i]  - plate_dec )^2)/(plate_rmin^2)
         dist = first+second
         indx = where(dist le 1.00, N)

         if N ge 1 then begin
            printf, 10, ra_rnd[i], dec_rnd[i], random_z[i], rc, $
                    format='(d16.8,1x, d16.8,1x, d10.6,1x, d16.8)'
         endif
      endif
      

   endfor 
   close, 10
endif


close, /all















end
