

readcol, 'OP/OP_20080508/k2d_output_UNI22.dat', x, y, k_sig, k_pi, xi, delta_xi, DD, DR, RR, xi_LS, xi_HAM



for i=0L, n_elements(xi_LS)-1 do begin
 if xi_LS[i] gt 0.00 then xi_LS[i] = alog(xi_LS[i])
endfor

;xplot3d, x, y, xi_LS

A = xi_LS[0:16]
B = xi_LS[17:33]
C = xi_LS[34:50]
D = xi_LS[51:67]
E = xi_LS[68:84]
F = xi_LS[85:101]
G = xi_LS[102:118]
H = xi_LS[119:135]
I = xi_LS[136:152]
J = xi_LS[153:169]
K = xi_LS[170:186]
L = xi_LS[187:203]
M = xi_LS[204:220]
N = xi_LS[221:237]
O = xi_LS[238:254]
P = xi_LS[255:271]
Q = xi_LS[272:288]


xmin= 0
xmax= 16
ymin= 0
ymax= 16


xi_2d = [[A], [B], [C], [D], [E], [F], [G], [H], [I], [J], [K], [L], [M], [N], [O], [P], [Q]] 


;surface, xi_2d
contour, xi_2d
contour, xi_2d, nlev=255,/fill,/xs,/ys,C_LINESTYLE = 1., $
         xrange=[xmin,xmax], $
         yrange=[ymin,ymax], $
;         zrange=[zmin,zmax], $
         charsize=2.8,$
         charthick=4,$
         ythick=2, $
         xthick=2, $
         xtitle = '!N !7r (!3h!E-1!N Mpc)', $
         ytitle = '!N !7p (!3h!E-1!N Mpc)',$
         position=[0.1,0.1,0.8,0.9]

close, /all
end
