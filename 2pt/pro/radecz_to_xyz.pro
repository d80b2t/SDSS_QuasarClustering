;+
; NAME:
;       q_omega_rs_v1_25
;
; PURPOSE:
;       To calculated correlation functions for SDSS DR5 quasars.
;
; EXPLANATION:
;
; CALLING SEQUENCE:
;       .run q_omega_rs_v1_25
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
;         Based on omega_rs_v1_24.pro code in 
;         /Volumes/Bulk/npr/cos_pc19a_npr/programs/omega_rs
;
; NOTES:
;
; MODIFICATION HISTORY:
;       Version 1.25  NPR    18th October, 2007
;-


data   = mrdfits('../data/DR5QSO_uni_data_z_cut.fits', 1)
random = mrdfits('../randoms/randoms_npr_002.fits', 1)

ra_J2K = data.ra
dec_J2K = data.dec
z_fin   = data.z

ra_rnd        = random.ra
dec_rnd       = random.dec
redshift_rnd  = random.z


rc_LRG = lumdist(z_fin, H0=100)
rc_LRG = rc_LRG/(1+z_fin)       ; to convert from lum dist to comoving dist.
; result = lumdist(z, [H0 = , k = , Omega_M =, Lambda0 = , q0 = ,/SILENT])

ra_J2K_rad  = ra_J2K/180. * !dpi
dec_J2K_rad = dec_J2K/180. * !dpi

x_coord_LRG = rc_LRG * cos(dec_J2K_rad) * cos(ra_J2K_rad)  
y_coord_LRG = rc_LRG * cos(dec_J2K_rad) * sin(ra_J2K_rad)  
z_coord_LRG = rc_LRG * sin(dec_J2K_rad)



rc_rnd = lumdist(redshift_rnd, H0=100)
rc_rnd = rc_rnd/(1.+redshift_rnd)

ra_rnd_rad  = ra_rnd/180. * !dpi
dec_rnd_rad = dec_rnd/180. * !dpi

x_coord_rnd = rc_rnd * cos(dec_rnd_rad) * cos(ra_rnd_rad)  
y_coord_rnd = rc_rnd * cos(dec_rnd_rad) * sin(ra_rnd_rad)  
z_coord_rnd = rc_rnd * sin(dec_rnd_rad)




openw, 10, 'randoms_npr_002_xyz.dat'
for i=0L, N_elements(x_coord_rnd)-1 do begin
   printf, 10, x_coord_rnd[i], y_coord_rnd[i], z_coord_rnd[i]
endfor
close, 10
























close, /all
end

