;; Just a wee .pro program to manipulate and record some of the
;; interesting numbers of the Shen DR5 Homogeneous sample.
;; 
;; NOTES:
;; http://deep.berkeley.edu/DR1/photo.primer.html
;;
;;        IDL> help, photo, /str;
;;
;; which will list the tags and their values for the first object in 
;; the photo structure. Another option is to use the tag_names command like so:
;;
;;        IDL> print, tag_names(photo)
;;
;; npr
;; 21 nov 2007




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
loadct, 6
leq_sign = String(108B)
!p.multi=[0,2,2]
!p.font=-1
set_plot, 'ps'
device, filename='plot_temp.eps', $
        xsize=8, ysize=8, xoffset=0, $
        yoffset=0.2, /inches, /color, /encapsulated
;; position=[(x_0, y_0), (x_1,y_1)]


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; R A   histogram   "on the bottom"
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
plot, data_full[indx_PRIzz22].z, $
      position=[0.32,0.12, 0.98,0.32], $
      xrange=[0.1, 2.4], $
      yrange=[0,1199], $        ; for UNI03z22
      xstyle=1, ystyle=1, $
      xthick=4.2, ythick=4.2, thick=4.2, $
      xtitle='redshift, z', $
      xcharsize=2.2, charthick=4.2, $
      color=0

plothist,  data[indx_z_cut03z22].z, bin=0.05,  $
           position=[0.32,0.12, 0.98,0.32], $
           thick=4.2, $
           color=64, /overplot




indx_PSFMAG_I = where(data_full.PSFMAG_I le 19.10, N_PSFMAG_I)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; M A I N    P L O T 
;;

plot, ra,  dec, $
       position=[0.32,0.32,0.98,0.98], $
      etc.




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Decl. histgram    ``on the side''
;;
plothist, dec, bin = bin_size, $
          thick = 3.0, peak = 0.50, $
          xhist, yhist, $
          /noplot, $
          position=[0.16,0.32,0.32,0.98]


plot, yhist,  xhist,  $
      xrange=, $
      yrange=, $
      xstyle=1, ystyle=1, $
      xthick=4.2, ythick=4.2, thick=4.2, $
      xcharsize=0.8, ycharsize=2.2, charthick=4.2, $
      position=[0.16,0.32,0.32,0.98], $
      /nodata


for i=0L, n_elements(xhist) - 1L do begin
;   if i eq 0L or i eq n_elements(xhist) - 1L then begin 
;  close the first/last      bin
;      oplot, [0,yhist[i]], [xhist[i]+0.05, xhist[i]+0.05], $
;             thick = 4.2, color = 192
;      oplot, [yhist[i], yhist[i]], [xhist[i]-0.05, xhist[i]+0.05], $
;             thick = 4.2, color = 192
;   endif else begin
;      oplot, [yhist[i-1], yhist[i]], [xhist[i]-0.05, xhist[i]-0.05], $
;             thick = 4.2, color = 192
;      oplot, [yhist[i],yhist[i]], [xhist[i]-0.05, xhist[i]+0.05], $
;             thick = 4.2, color = 192
;   endelse
endfor


plothist, data[indx_z_cut03z22].imag, bin = 0.1, $
          thick = 3.0, peak = 0.50, $
          xhist, yhist, $
          /noplot, $
          position=[0.16,0.32,0.32,0.98]
for i=0L, n_elements(xhist) - 1L do begin
   if i eq 0L or i eq n_elements(xhist) - 1L then begin 
      oplot, [0,yhist[i]], [xhist[i]+0.05, xhist[i]+0.05], $
             thick = 4.2, color = 64
      oplot, [yhist[i], yhist[i]], [xhist[i]-0.05, xhist[i]+0.05], $
             thick =4.2, color = 64
   endif else begin
      oplot, [yhist[i-1], yhist[i]], [xhist[i]-0.05, xhist[i]-0.05], $
             thick =4.2, color = 64
      oplot, [yhist[i],yhist[i]], [xhist[i]-0.05, xhist[i]+0.05], $
             thick =4.2, color = 64
   endelse
endfor






close, /all
end

