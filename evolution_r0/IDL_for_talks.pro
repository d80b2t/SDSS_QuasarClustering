;;+
;; NAME:
;;
;; PURPOSE:
;;
;; PROCEDURES CALLED:
;;
;;-



set_plot, 'ps'
device, filename='For_talks_temp.ps', $
        xsize=8.5, ysize=6.0,  /inches, /color, $
        xoffset=0.0, yoffset=0.2


!p.multi=0
loadct, 0

;;
p=  [-0.2, -0.2, 1.3, 1.3]
pp =  [0.14, 0.14, 0.98, 0.98]

;;
PolyFill, [p[0],p[0],p[2],p[2],p[0]],  [p[1],p[3],p[3],p[1],p[1]],  $
          COLOR=0, /NORMAL

plot, x_variable, y_variable, $
      position=pp, $
      /noerase, $
      xrange=[0,2.92], yrange=[0.0,25], $ 
      psym=3, $
      xstyle=8+1, ystyle=3, $
      thick=8, xthick=4, ythick=8, $
      charsize=2.2, charthick=6, $
      xtitle='!8z, redshift', $
      ytitle='!8r!I0!n / !8h!E-1!n!8 Mpc', $
      /nodata, $
      color=255


loadct, 0
plotsym,0,2
oplot, z_bar, r0, psym=8, color=255, thick=1;, symsize=4
oploterror, z_bar, r0, z_err_lo, r0_minus, $
            /lobar, errthick=1, errcolor=255, psym=1, color=255
oploterror, z_bar, r0, z_err_hi, r0_plus, $
            /hibar, errthick=1, errcolor=255, psym=1, color=255


loadct, 0
plotsym,0,1.0,/fill, thick=4
xyouts, 0.3, 23.0, 'Label Here', color=255, charthick=6, charsize=1.8
legend, [''], psym=8, color=255, pos=[0.1,24.5], box=0, $
           charthick=4.2, charsize=1.8, thick=4.2

device, /close
set_plot, 'X'



;PSYM Value 
;Plotting Symbol 
;1
;Plus sign (+) 
;2
;Asterisk (*) 
;3
;Period (.) 
;4
;Diamond 
;5
;Triangle 
;6
;Square 
;7
;X 
;8
;User-defined. See USERSYM procedure. 
;9
;Undefined 
;10
;Histogram mode. Horizontal and vertical lines connect the plotted points, as opposed to the normal method of connecting points with straight lines. See Histogram Mode for an example. 



; plotsym:
; x   PSYM -  The following integer values of PSYM will create the
;             corresponding plot symbols
;     0 - circle
;     1 - downward arrow (upper limit), base of arrow begins at plot value             value
;     2 - upward arrow (lower limt)
;     3 - 5 pointed star
;     4 - triangle
;     5 - upside down triangle
;     6 - left pointing arrow
;     7 - right pointing arrow
;     8 - square






end

