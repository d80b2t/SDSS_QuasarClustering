;+
; NAME:
;       
;
; PURPOSE:
;         Quickly makes ra_dec_randoms_npr.fits for q_z_bin_v1_xx.pro
; 
; INPUTS:
;       ra_dec_eta_lambda_randoms.dat from 
;       /Volumes/Bulk/npr/cos_pc19a_npr/data/Quasars/CAS/mask
;
;-


;readcol, '../../../data/Quasars/CAS/mask/ra_dec_eta_lambda_randoms_20080425.dat', $
;readcol, '../../../data/Quasars/CAS/mask/ra_dec_eta_lambda_randoms_20080502.dat', $
readcol, '../../../data/Quasars/CAS/mask/ra_dec_eta_lambda_randoms_20080508.dat', $
         j, ra_rnd, dec_rnd, eta_rnd, lambda_rnd, sector_rnd
print, 'READ-IN ra_dec_eta_lambda_randoms.dat'
print

wsp     = replicate({ra: 0D, dec: 0D}, 1000000)
wsp.ra  =  ra_rnd
wsp.dec = dec_rnd

mwrfits, wsp, 'ra_dec_randoms_npr.fits'


end
