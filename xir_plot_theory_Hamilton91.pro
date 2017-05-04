

r = findgen(10000)
r = r+1
r = r/100.
;r = alog10(r)


   top = 1 + (0.679*r) + (0.0164* (r^2))
bottom = 1 + (0.424*r) + (0.0118* (r^2)) + (0.000778*(r^3))
 
sq_br = ( alog  (1 +  (6 / r) ))

xi_bar = 0.38 * (sq_br^3) * (top/ bottom)


loadct, 6
plot, r, xi_bar, $
      xrange=[0.01, 100], $
      yrange=[0.0001, 100000], $
      xstyle=1, $
      ystyle=1, $
      /xlog, /ylog, $
      linestyle=0

pl = (r^(-1.8))

oplot, r, pl, $
       linestyle=1

end
