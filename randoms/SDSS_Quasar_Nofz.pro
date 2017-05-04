; A file to make a nice N(z) for e.g. 
; the UNIFORMS and the randoms:

;; DATA::
readcol, '../data/DR5QSO_uni_data.dat', ra, dec, z   
;readcol, '../data/DR5QSO_pri_data_DR1_20080811.dat', ra, dec, z
; readcol, 'RASS_in_DR5Q_UNI.dat', ra, dec, z
; readcol, 'DR5QSO_pri_data_temp.dat', ra, dec, z   

;; RANDOMS:
readcol, 'randoms_dat/randoms_npr_UNIFORM.dat', $ 
;readcol, 'randoms_npr_PRIMARY_DR1_20080811.dat', $
;readcol, 'randoms_npr_temp.dat', $
         ra_rnd, dec_rnd, z_rnd

z_min_range = 0.00
z_max_range = 2.90

w = where(z ge z_min_range and z le z_max_range, N)
;print

readcol, 'DR5QSO_data_Nofz_fit_temp.dat', Nofz_fit
;readcol, 'DR5QSO_data_Nofz_fit_le2pnt9_120bins.dat', Nofz_fit_120
;readcol, 'DR5QSO_data_Nofz_fit_le2pnt9_60bins.dat', Nofz_fit_60

;Ds_to_Rs = double(n_elements(ra_rnd))/ double(n_elements(ra)) 
Ds_to_Rs = double(n_elements(ra_rnd))/ double(n_elements(ra[w])) 



z_bin_width=0.05


!p.multi=0
loadct, 6
set_plot, 'ps'
device, filename='SDSS_Quasar_Nofz_temp.eps', $
        xsize=8.5, ysize=8, $
        xoffset=0.2, yoffset=0.0, $
        /inches, /color, /encapsulated

plothist, z, $
;plothist, z[w], $
          position=[0.20,0.15,0.98,0.98], $
          xrange=[-0.05, 3.2], $
;          xrange=[-0.1, 4.2], $
;          yrange=[0,220], $  ; for full XRay (uni) sample
;          yrange=[0,500], $              ; for full PRI DR1  sample
          yrange=[0,1500], $              ; for full UNIFORM sample
;          yrange=[0,2000], $              ; for full PRIMARYsample
          xstyle=1, ystyle=1, $
          bin=z_bin_width, $
          thick=6.0, xthick=4.2, ythick=4.2,  $
          xcharsize=2.2, ycharsize=2.2, charthick=4.2,$
          xtitle='redshift, z', $
          ytitle='Number of objects', $
;          /nodata, $
          color=0

plothist, z_rnd, bin=(z_bin_width/Ds_to_Rs), $
          /overplot, linestyle=1, color=64, thick=4.2

;z_rnd_run   = size(histogram(z_rnd, bin=z_bin_width))
z_rnd_histo = histogram(z_rnd, bin=z_bin_width/Ds_to_Rs)
z_rnd_histo = histogram(z_rnd, bin=z_bin_width)

sizze = size(z_rnd_histo)

z_rnd_run = findgen(sizze[1]) ; / 596.896
z_rnd_run = findgen(sizze[1]) / 19.655
z_rnd_histo = z_rnd_histo / 28.54

;oplot, z_rnd_run, z_rnd_histo,  linestyle=0, color=64, thick=6.2


;z_run = findgen(300)/100d
z_run = findgen(60)/20d

fit= (Nofz_fit[10]*z_run^10) + (Nofz_fit[9]*z_run^9) + $
     (Nofz_fit[8] * z_run^8) + (Nofz_fit[7]*z_run^7) + $
     (Nofz_fit[6] * z_run^6) + (Nofz_fit[5]*z_run^5) + $
     (Nofz_fit[4] * z_run^4) + (Nofz_fit[3]*z_run^3) + $
     (Nofz_fit[2] * z_run^2) + (Nofz_fit[1]*z_run)   + (Nofz_fit[0]) 

oplot, (z_run), fit, color=128, thick=4
;;plot, (z_run), fit, color=128, thick=4, yrange=[0,1500], ystyle=1


;xyouts, 2.1,  140, "X-ray DR5Q (uni) ", charsize=2.2, charthick=4.2, color=0
;xyouts, 2.1, 120, "Randoms    ", charsize=2.2, charthick=4.2, color=64
xyouts, 2.1, 1400, "DR5Q (uni) ", charsize=2.2, charthick=4.2, color=0
;legend, [], 
xyouts, 2.1, 1300, "n(z) fit ", charsize=2.2, charthick=4.2, color=128
xyouts, 2.1, 1200, "Randoms    ", charsize=2.2, charthick=4.2, color=64


device, /close
set_plot, 'X'


close, /all



;; Old code from q_z_bin_v1_05.pro: 
;;
;;oplot, x, fit,  color=128
;oplot, (x+0.15), fit,  color=128, linestyle=2
;;oplot, x, (fit*30.29), color=192
;xyouts, 2.1, 1700, "x^10 poly fit", charsize=2.2, charthick=3, color=128;;
;
;
;if choice eq 'U' then begin
;   plothist, sp[0:33700].z, bin=z_bin_width, /overplot, color=192
 ;  plothist, random_z[33700:67400], bin=z_bin_width, /overplot, color=64
;   xyouts, 2.1, 2000, 'Randoms', charsize=2.2, charthick=3, color=64
;   xyouts, 2.1, 1900, "sp.z", charsize=2.2, charthick=3, color=192
;   xyouts, 2.1, 2100, "UNI (x,z_bin)", charsize=2.2, charthick=6, color=0
;endif
;if choice eq 'P' then begin
;;   plothist, sp[0:44347].z, bin=z_bin_width, /overplot, color=192
;;   plothist, random_z[44347:88748], bin=z_bin_width, /overplot, color=64
;;   plothist, sp[88748:134208].z, bin=z_bin_width, /overplot, color=176
;;   plothist, random_z[134208:178944], bin=z_bin_width, /overplot, color=48
;;   plothist, sp[178944:223680].z, bin=z_bin_width, /overplot, color=208
;;   plothist, random_z[223680:268416], bin=z_bin_width, /overplot,
;;   color=80;;
;
;; STROKE OF GENIUS!!: 
;;Ds_to_Rs = 1e6 / 33699 ; e.g. for UNI with z <=2.9
;;plothist, random_z, bin=(z_bin_width/(Ds_to_Rs)), /overplot, color=64
;;;
;
;   plothist, random_z, bin=z_bin_width, /overplot, color=80, peak=norm
;   xyouts, 2.1, 2000, 'Randoms', charsize=2.2, charthick=3, color=80
;;   xyouts, 2.1, 1900, "sp.z", charsize=2.2, charthick=3, color=64
;   xyouts, 2.1,  2100, "PRI (x,z_bin)", charsize=2.2, charthick=3, color=0
;endif



end


