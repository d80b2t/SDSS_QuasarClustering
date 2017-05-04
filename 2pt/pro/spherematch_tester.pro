;+
; NAME:
;       spherematch_tester
;
; PURPOSE:
;       To test the spherematch.pro routine
;
; EXPLANATION:
;
; CALLING SEQUENCE:
;       .run spherematch_tester.pro
;
; INPUTS:
;       None.
;
; OPTIONAL INPUTS:
;       None.
;
; KEYWORD PARAMETERS:
;       n/a
;
; OUTPUTS:
;       various
;
; OPTIONAL OUTPUTS:
;       also various
;
; COMMON BLOCKS:
;       None.
;
; RESTRICTIONS:
;
; PROCEDURES CALLED:
;
; EXAMPLES:
;
; COMMENTS:
;
; NOTES:
;
; MODIFICATION HISTORY:
;       Version 0.09  NPR    23th November 2007
;-

print


read, choice, PROMPT='1) full 38 208 Ds, 1e6 Rs,    2) full 38208 Ds, 764k Rs 3) 33 011 z<2.5 Ds, 660k Rs   4) reshift sub-samples' 

if choice eq 1 then begin
   data   = mrdfits('../data/DR5QSO_uni_data_z_cut.fits', 1)
   random = mrdfits('../randoms/randoms_npr.fits', 1)
;readcol, 'data/randoms_npr.dat', ra_rnd, dec_rnd, redshift_rnd
endif


ra_J2K = data.ra
dec_J2K = data.dec
z_fin   = data.z

ra_rnd        = random.ra
dec_rnd       = random.dec
redshift_rnd  = random.z

spherematch, ra_J2K, dec_J2K, ra_J2K, dec_J2K, 0.0002777, match1, match2
     		       distance12

help, ra_J2K
help, dec_J2K
help, match1
help, match2, 
help, distance12


device, /close
close, /all
end
