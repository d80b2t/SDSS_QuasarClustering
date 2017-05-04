


readcol, 'COV.dat', x,y,z



!p.multi=0
!p.T3D= 0
loadct, 6  ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='COV_3D.ps', $
        xsize=7.5, ysize=6.0, /inches, /color

;XPLOT3D, X, Y, Z 
;PLOTS, X, Y, Z, /T3D
SURFACE, Z, X, Y

device, /close
set_plot, 'X'
close, /all
end
