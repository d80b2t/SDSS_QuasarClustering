

data = mrdfits('rp_min.fits', 1)

z_grid  = data.z
rp_grid = data.rp_max




set_plot, 'ps'
device, filename='rp_min_temp.eps', $
        xsize=9.2, ysize=8.0, /inches, /color, $
        /encapsulated, $
        xoffset=0.3, yoffset=0.2
!p.multi=0



loadct, 0
thick = 3.0
charsize = 2.5
plot, [0],[0], $
      /nodata, $
      xrange = [0,5.5], /xsty, $
      yrange = [0,2], /ysty, $
      charsize = charsize, $
      charthick = thick, ythick = thick, xthick = thick,  $
      xtitle = 'Redshift', $
      ytitle = textoidl('r_{p,min} (h^{-1}Mpc)'), $
      position = [0.15, 0.15, 0.98, 0.98]

oplot, z_grid, rp_grid, $
       linestyle = 0, thick = 4.0
xyouts, 1.5, 1.8, $
        textoidl('\Omega_\Lambda=0.74, \Omega_M=0.26, h=0.7'), $
        charsize = charsize, charthick = thick

polyfill, [z_grid[0], z_grid[0:545L], z_grid[545L]], [0,rp_grid[0:545L],0], $
;          color = fsc_color('gray'), $
          color=100, $
          /line_fill, $
          orientation = 45, $
          thick = 2.0, noclip=0L

device, /close
set_plot, 'X'
close, /all


end
