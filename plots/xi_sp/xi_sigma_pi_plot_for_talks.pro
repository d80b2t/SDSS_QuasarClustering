;pro Ross_cont

set_plot,'x'
ps = 1
colour = 39
loadct,colour,/silent
!p.background=255
!p.color=0


;+++++++++++++++++++++++++++++++++++++++++
; ascii files                            +
;+++++++++++++++++++++++++++++++++++++++++
;
; read it
i=0
j=0

lim=20

element=0
;readcol, 'OP_20071102/kde_2d_output_tempf_20071102.dat', $
;         k_sigma, k_pi, sigma, pi, nDD, nDR, nRR, xi, xi_LS
readcol, 'OP/OP_20080508/k2d_output_UNI22.dat', $
         sigma, pi, k_sigma, k_pi, xi, delta_xi, nDD, nDR, nRR, xi_HAM, xi_LS


max_value = 53.19188386664581

z=fltarr(289)
for i=0L, n_elements(xi_LS)-1 do begin
   if xi_LS[i] gt 0.00 then z[i] = alog10(xi_LS[i])
   if xi_LS[i] lt 0.00 then z[i] = xi_LS[i]
   if xi_LS[i] eq 0.00 then z[i] = alog10( 53.19188)

   if k_sigma[i] le 10 and k_pi[i] le 12 then begin
;;      if xi_LS[i] eq 0.00 then z[i]     = alog10(max(xi_LS))
;;      if xi_LS[i] eq 0.00 then xi_LS[i] = alog10(max(xi_LS))
      xi_LS[i] = max_value
      z[i] =   alog10(xi_LS[i])
;      if k_sigma[i] le 8 and k_pi[i] le 10 then begin
;         xi_LS[i] = max_value^3
;         z[i] =   alog10(xi_LS[i])
;      endif
   endif

endfor



;   z=alog10(sqrt(xi^2)+0.0000001)        ;for DD/DR
;   z=alog10(sqrt(xi_STD^2)+0.0000001)    ;for DD/RR
;   z=alog10(sqrt(xi_LS^2)+0.0000001)     ;for LS

;z=alog10(xi_LS)     ;for LS

;A = xi_LS[0:16]
B = xi_LS[18:33]
C = xi_LS[35:50]
D = xi_LS[52:67]
E = xi_LS[69:84]
F = xi_LS[86:101]
G = xi_LS[103:118]
H = xi_LS[120:135]
I = xi_LS[137:152]
J = xi_LS[154:169]
K = xi_LS[171:186]
L = xi_LS[188:203]
M = xi_LS[205:220]
N = xi_LS[222:237]
O = xi_LS[239:254]
P = xi_LS[256:271]
Q = xi_LS[273:288]
xi_2d = [[B], [C], [D], [E], [F], [G], [H], [I], [J], [K], [L], [M], [N], [O], [P], [Q]] 




;xi_LS = xi_LS + 1.
print
print, 'xi(sigma,pi)'
;print, xi_LS
help, xi_LS
;print, xi_LS
;help, xi_LS
print
;print, 'k_sigma'
;print, k_sigma
help, k_sigma
print

k_sigma=sigma
sz = sqrt(size(k_sigma))
print, 'size(k_sigma)', size(k_sigma)
print
print, 'sz', sz
print

;print, 'sigma'
;print,  sigma
help,   sigma
print
;print, 'pi'
;print,  pi
help, pi
print



; Low value cutting:
; values of vsx=3 and vsy=4 are needed to produce the xi(sigma,pi)
; digrams from  the ``old'', k2d_output files
;

vsx=6
vsy=7




sz4x = sz[1]*2-(vsx*2)
sz4y = sz[1]*2-(vsy*2)
array = fltarr(sz[1],sz[1])

print, 'sz4x', sz4x 
print
print, 'sz4y', sz4y 
print

openw, 10, 'cont_plot_result.dat'
z4 = fltarr(sz4x,sz4y)
xy4 = fltarr(sz4x,sz4y)
help, z4

x = fltarr(sz[1])
y = fltarr(sz[1])
x4 = fltarr(sz4x)
y4 = fltarr(sz4y)
for i=0,sz[1]-1 do begin
;   print, 'i, sz[1], (i*sz[1]), sigma[i*sz[1]]', i, sz[1], (i*sz[1]), sigma[i*sz[1]]
   x[i]=sigma[i*sz[1]]          ; since only every 17th value has a sigma increment
   y[i]=pi[i]
endfor

print
print, 'x',x 
print
print
print, 'y', y
print
print




printf, 10, 'i,j, z[element], element, xi_LS[element], '
for i=0,sz[1]-1 do begin
   for j=0,sz[1]-1 do begin
      array[i,j]=z[element]
      printf, 10, i,j, z[element], element, xi_LS[element] 
      element=element+1 
   endfor
endfor
;printf, 10
;printf, 10, array
 

printf, 10, 'i, j, x4[i], y4[j], z4[i,j]'
for i=0,sz[1]-1-vsx do begin
   x4[i]=-x[sz[1]-1-i]
   for j=0,sz[1]-1-vsy do begin
      z4[i,j]=array[sz[1]-1-i,sz[1]-1-j]
      y4[j]=-y[sz[1]-1-j]
      printf, 10, i, j, x4[i], y4[j], sz[1]-1-i, sz[1]-1-j, array[sz[1]-1-i,sz[1]-1-j],  z4[i,j]
   endfor
   printf, 10
   for j=sz[1]-vsy,sz4y-1 do begin
      printf, 10, i, j
      z4[i,j]=array[sz[1]-1-i,j-sz[1]+(2*vsy)]
      y4[j]=y[j-sz[1]+(2*vsy)]
      printf, 10, i, j, x4[i], y4[j], z4[i,j]
   endfor
   printf, 10
endfor
printf, 10
printf, 10
print


for i=sz[1]-vsx,sz4x-1 do begin
        x4[i]=x[i-sz[1]+(2*vsx)]
    for j=0,sz[1]-1-vsy do begin
        z4[i,j]=array[i-sz[1]+(2*vsx),sz[1]-1-j]
        printf, 10, i, j, x4[i], y4[j], z4[i,j], '  2nd loop'
    endfor
    for j=sz[1]-vsy,sz4y-1 do begin
        z4[i,j]=array[i-sz[1]+(2*vsx),j-sz[1]+(2*vsy)]
        printf, 10, i, j, x4[i], y4[j], z4[i,j], '  2nd loop'
    endfor
endfor

print, 'x4'
print, x4
print

if lim gt 0. then begin
   print, 'lim', lim
   xmin=-lim
   xmax=lim
   ymin=-lim
   ymax=lim
endif else begin
   print, 'lim', lim
   xmin=min(x4)
   xmax=max(x4)
   ymin=min(y4)
   ymax=max(y4)
endelse
zmin=-1.2
zmax= 2.0
;zmin=min(z4)
;zmax=max(z4)

print, 'xmin, xmax', xmin, xmax, '  ymin, ymax', ymin, ymax, '   zmin, zmax', zmin, zmax

help, z4
help, x4
help, y4


result = MIN_CURVE_SURF(z4)
;result_x = MIN_CURVE_SURF(x4)
;result_y = MIN_CURVE_SURF(y4)

help, result
;help, result_x
;help, result_y


printf, 10, 'result'
printf, 10, result
printf, 10, result
print



print, 'x4'
print, x4
print

print, 'y4'
print, y4
print

printf, 10 
printf, 10, 'x4[i], y4[j], z4[i,j]'
for i=0,sz4x-1 do begin
   for j=0,sz4y-1 do begin
;      if ( (abs(x4[i] lt 0.5)  and y4[j] lt 0.5) $
;           and ( (z4[i,j] lt zmin) or (z4[i,j] gt zmax))) then z4[i,j] = zmax

;      if z4[i,j] lt zmin then z4[i,j] = zmin
;      if z4[i,j] gt zmax then z4[i,j] = zmax
      printf, 10, x4[i], y4[j], z4[i,j]
   endfor
endfor
   

help, z4
printf, 10, 'z4'
;printf, 10, z4
print

print, 'gth1'






if ps eq 1 then set_plot,'ps'
if ps eq 1 then device, filename='xi_si_pi_plot_for_talks.ps', $
                        /color, /inches, $
                        xsize=8, ysize=6, $
                        xoffset=0.2, yoffset=0.2

loadct, 0
p=  [-0.2, -0.2, 1.3, 1.3]
pp =[0.14,0.14,0.8,1.00]

PolyFill, [p[0],p[0],p[2],p[2],p[0]],  [p[1],p[3],p[3],p[1],p[1]],  COLOR=0, /NORMAL

loadct, 0
z5 =BILINEAR(z4, x4, y4)
contour, z4, x4, y4, $
;contour, z4, $
         nlev=255, $
         /fill, $
         xstyle=1, ystyle=1, $
         C_LINESTYLE = 1.,$ 
         xrange=[xmin,xmax], $ 
         yrange=[ymin,ymax], $ 
         zrange=[zmin,zmax], $ 
         charsize=2.2,$
         charthick=4,$
         ythick=2, $
         xthick=2, $
         xtitle = '!Nr!Ip!N / !3h!E-1!N Mpc', $
         ytitle = '!N !7p / !3h!E-1!N Mpc', $
         /noerase, $
         color=255, $ 
         position=pp

loadct, 39
contour, z4, x4, y4, $
;contour, z4, $
         nlev=255, $
         /fill, $
         xstyle=1, ystyle=1, $
         C_LINESTYLE = 1.,$ 
         xrange=[xmin,xmax], $ 
         yrange=[ymin,ymax], $ 
         zrange=[zmin,zmax], $ 
         charsize=2.2,$
         charthick=4,$
         ythick=2, $
         xthick=2, $
         xtitle = '!Nr!Ip!N / !3h!E-1!N Mpc', $
         ytitle = '!N !7p / !3h!E-1!N Mpc', $
         /overplot, $
         position=pp


print, 'gth2'
contour,z4,x4,y4,$
        /overplot, $  
        C_LINESTYLE = 0, c_color=0, $
        xrange=[xmin,xmax],yrange=[ymin,ymax], $
;;; 0
        levels = [  -1.2, -0.8, -0.4, 0.0, 0.4, 0.8, 1.2, 1.6], $
        c_thick= [     1,    1,    1,   10,   1,   1,   1,  1 ], $  
        c_annotation=['0.06',  '0.16',  '0.4',  '1.0',  '2.5',  '',  '16', '' ], $
;;; 1
;        levels = [     -1.0, -0.5,   0.0, 0.5,  1.0, 1.5, 2.0], $
;        c_thick= [        1,    1,     7,   1,    1,   1,   1], $  
;        c_annotation=['0.1',   '', '1.0',  '', '10',  '', '100'], $ 
;;
;        levels = [-2,     -1.699, -1.301,    -1, -0.699, -0.301,   0,     1, 1.699, 2.0],$
;        c_thick= [ 1,          1,      1,     1,      1,      1,   7,     1,    1,    1,   1],$
;        c_annotation=['0.01', '0.02', '0.05', '0.1',  '0.2',  '0.5', '1',  '10',  '50', '100'], $
;;
;        levels = [-2,-1.699,-1.301,-1,-0.699,-0.301,0,0.301,0.699,1,1.3,1.699],$
;        c_thick=[1,1,1,1,1,1,3,1,1,1,1],$
;        c_annotation=['0.01','0.02','0.05','0.1','0.2','0.5','1','2','5','10','20','50'], $
;;
;        levels = [-1.3,-1.1,-0.9,-0.7,-0.5,-0.3,-0.1, 0, 0.1, 0.3, 0.5, 0.7, 0.9, 1.1, 1.3], $
;        c_thick=[   1,   1,   1,   1,   1,   1,   1, 5,   1,   1,   1,   1,   1,   1, 1], $
;        c_annotation=['0.05','0.08','0.13','0.2','0.32','0.5','0.79','1','1.3','2.0','3.2','5.0','7.9', '12.6','20.0'], $
        c_charsize=1.2, c_charthick= 3


print, 'gth3'
scale = fltarr(2,256)
scalex=[0,1]
scaley = zmin+findgen(256)*(zmax-zmin)/255
label=string(alog10(scaley),format='(F4.2)')
print, 'gth4'
for i = 0,255 do scale(*,i) = scaley[i]
contour, scale, scalex, scaley, $
         /fill, $
         nlev=255, $
         xstyle=1, ystyle=1, $
         zrange=[zmin,zmax], $
         /closed, $
         charsize=1.6, $
         charthick=4, $
         xtickname=[' ',' '], $
         xtickinterval=1, $
         ytitle="!N !3log(!7n!3)",$
         position=[0.95,0.14,1.00,1.00], $ 
         /noerase, $
         color=255

if ps eq 1 then device,/close


print, 'gth5'
print, 'z4', z4

new_zmax = max(z4)
print, 'zmax', new_zmax

close, 10
close, /all


print, 'gth6'
;stop
end
