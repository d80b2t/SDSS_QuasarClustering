


data      = mrdfits('/Volumes/Bulk/npr/cos_pc19a_npr/programs/quasars/data/DR5QSO_uni_data.fits', 1)

loadct, 0                       ; black=0=255, red=63, green=127, blue=191
set_plot, 'ps'
device, filename='clustering_eg_temp.ps', $
        xsize=7.5, ysize=7.5, $
        xoffset=0.2, yoffset=0.1, /inches, /color

!p.multi=[0,2,1]

ra_tst = randomu(a, /double, 900)
dec_tst = randomu(b, /double, 900)


x_rnd = ra_tst
y_rnd = dec_tst
p=  [-0.2, -0.2, 1.3, 1.3]
PolyFill, [p[0],p[0],p[2],p[2],p[0]],  [p[1],p[3],p[3],p[1],p[1]],  COLOR=0, /NORMAL


plotsym, 0, 0.5, /fill
plot, x_rnd, y_rnd, $
;      position=[0.04, 0.24, 0.48, 0.68], $ ; if top of 2 panels
      position=[0.58, 0.24, 1.02, 0.68], $ ; if top of 2 panels
      xstyle=1, ystyle=1, $
      /noerase, $
      xrange=[0.0, 1.0], $
      yrange=[0.0, 1.0], $
      thick=2.2, $
      xthick=2.2, ythick=2.2, $
      charsize=1.6, charthick=4.2, $
;      xtitle=' !3r!Ip!N / h!E-1!N Mpc', $
;      ytitle='', $
;      xtickformat='(a1)', $
;      ytickformat='(a1)', $
      psym=8, $
      color=255


w = where(data.ra ge 170. and data.ra le 180 and data.dec ge 3. and data.dec le 13, N)


xx = findgen(900)
yy = findgen(900)


r0 = 0.01
j=0
random_counter =0
REPEAT BEGIN
   
   ra_tst = randomu(c, /double)
   dec_tst = randomu(d, /double)
   
   ra_test = randomu(f, /double)
   dec_test = randomu(g, /double)
   
   complete_tst = randomu(e, /double)
   
   diff = (  sqrt( (ra_tst-ra_test)^2) + sqrt( (dec_tst -dec_test)^2))
   
   prob = (diff/ r0 ) ^(-3.0)

   if prob ge complete_tst then begin
      xx[j] =  ra_tst
      yy[j] = dec_tst
      
      xx[j+1] = ra_test 
      yy[j+1] = dec_test
      
      j=j+2
      
      random_counter = random_counter + 1  
      print, random_counter, j
   endif
   
ENDREP UNTIL random_counter eq 450



r0 = 0.25

x = (data[w].ra-170.)/10.
y = (data[w].dec-3.65)/9.31

;plot, x, y, $
plot, xx, yy, $
      position=[0.04, 0.24, 0.48, 0.68], $ ; if top of 2 panels
;      position=[0.58, 0.24, 1.02, 0.68], $ ; if top of 2 panels
      xstyle=1, ystyle=1, $
      /noerase, $
      xrange=[0.0, 1.0], $
      yrange=[0.0, 1.0], $
      thick=2.2, $
      xthick=2.2, ythick=2.2, $
      charsize=1.6, charthick=4.2, $
;      xtitle=' !3r!Ip!N / h!E-1!N Mpc', $
;      ytitle='', $
;      xtickformat='(a1)', $
;      ytickformat='(a1)', $
      psym=8, $
      color=255


device, /close
set_plot, 'X'
end


