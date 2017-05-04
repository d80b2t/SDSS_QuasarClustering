;;+
;;
;;
;;
;;-


;data_full = mrdfits('/Volumes/Bulk/npr/cos_pc19a_npr/programs/quasars/data/dr5qso.fits', 1)
data = mrdfits('data/dr5qso.fits', 1)
data_UNI = mrdfits('data/DR5QSO_uni_data.fits', 1)

;readcol, '../../data/Quasars/CAS/mask/ra_dec_eta_lambda_randoms/ra_dec_eta_lambda_randoms_20080519.dat', $ ;Oneline
;            j, ra_rnd, dec_rnd, eta_rnd, lambda_rnd, sector_rnd, $
;            format='(i,d,d,d,d, i, d, d)'


DR5Q_ra  =  data.ra
DR5Q_dec = data.dec

DR5Q_UNI_ra  =  data_UNI.ra
DR5Q_UNI_dec = data_UNI.dec


openw, 10, 'dr5qso_RADec.dat'
for i=0L, n_elements(DR5Q_ra)-1 do begin
   printf, 10, DR5Q_ra[i], DR5Q_dec[i], format='(f14.6,2x, f14.6)' 
endfor
close, 10

openw, 11, 'dr5qso_uni_RADec.dat'
for i=0L, n_elements(DR5Q_UNI_ra)-1 do begin
   printf, 11, DR5Q_UNI_ra[i], DR5Q_UNI_dec[i], format='(f14.6,2x, f14.6)' 
endfor
close, 11

;astro, 1
;GLACTC, ra, dec, year, gl, gb, j,
GLACTC, DR5Q_ra, DR5Q_dec,         2000, DR5Q_gl, DR5Q_gb, 1, /degree
GLACTC, DR5Q_UNI_ra, DR5Q_UNI_dec, 2000, DR5Q_UNI_gl, DR5Q_UNI_gb, 1, /degree

loadct, 6
!p.multi=0

loadct, 6  ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='SDSS_DR5Q_Aitoff.ps', $
        xsize=7.5, ysize=6.0, $
;        /landscape, $
;        xoffset=0.0, $
;        yoffset=0.0, $
        /inches, /color


;aitoff_grid, /label, /new    
my_aitoff_grid, label=1, /new, offset=180, $
                CHARSIZE = 1.2, CHARTHICK = 4.2, color = 192, $
                thick=4.2


aitoff, DR5Q_gl, DR5Q_gb, x,y 
aitoff, DR5Q_UNI_gl, DR5Q_UNI_gb, x_UNI, y_UNI 

DR5Q_ra = DR5Q_ra  -180.
DR5Q_UNI_ra = DR5Q_UNI_ra  - 180.

w = where(DR5Q_UNI_ra gt 180d, N)
;DR5Q_ra[w] = DR5Q_ra[w] 180.

loadct, 6
;device, filename='SDSS_DR5Q_Aitoff.ps', $
;        xsize=7.5, ysize=5.5, /inches, /color
;plots,x,y,psym=2
;plots,DR5Q_ra,DR5Q_dec,psym=3
plots,DR5Q_ra,DR5Q_dec, $
      psym=3, color=20
;oplot, x, y,       psym=3, color=20

oplot, DR5Q_UNI_ra,DR5Q_UNI_dec, psym=3, color=100

xyouts, -30, 120, 'DR5Q', charsize=2.2,    charthick=4.2, color=20
xyouts, -45, 120, 'UNIFORM', charsize=2.2, charthick=4.2, color=100

device, /close
close, /all


end
