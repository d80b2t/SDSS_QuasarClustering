;; 
;;
;; All I want to do is make a random sample using the ra-dec-z
;; mixing technique e.g. Croom et al. (2005), where you 
;; take the RA and DEC data pairs and then assign them 
;; a redshift from the data sample. This way the angular
;; mask should be reproduced (but also whatever signal in 
;; w(theta) will still be there too no??) but the LSS is
;; probably lost since you're shuffling the redshifts so much. 
;; 
;;


readcol, '../data/DR5QSO_uni_data.dat', ra, dec, z   
w = where(z le 2.9, N)


print, 'MAKING RANDOMS_NPR_TEMP.DAT......'
openw, 10, 'randoms_npr_temp.dat'

for i=0L, 999999 do begin
   ra_dec_no = randomu(s) 
   trial = randomu(t) 
   
   data_ra_dec_no = ra_dec_no * 33699d
   data_redshift  = trial *   33699d
   ;; e.g. for the UNI z<=2.9 sample, 33699 DR5Q datas
   
   lumd = lumdist(z[data_redshift], H0=100, Omega_M=0.24, Lambda0=0.76,   /SILENT)
   rc = lumd /(1.+ z[data_redshift])
   
   printf, 10, ra[data_ra_dec_no], dec[data_ra_dec_no], z[data_redshift], rc, $
           format='(d16.8,1x, d16.8,1x, d10.6,1x, d16.8)'
endfor

close, 10



close, /all


end


