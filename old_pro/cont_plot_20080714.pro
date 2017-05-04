pro Ross_cont

set_plot,'x'
ps = 1
colour = 39
loadct,colour,/silent
!p.background=255
!p.color=0
if ps eq 1 then set_plot,'ps'
if ps eq 1 then device, filename='xi_si_pi_plot.ps', /color, $
                        xsize=8, ysize=6, xoffset=0, $
                        yoffset=0.5+(10-8), /inches

;+++++++++++++++++++++++++++++++++++++++++
; ascii files                            +
;+++++++++++++++++++++++++++++++++++++++++
;
; read it
i=0
j=0

lim=20

element=0
;readcol,'k2d_output_2SLAQ_Edin_cor_Ham_FtF.dat',temp1,temp2,sigma,pi,temp3,xi
;sigma,pi,k_sigma,k_pi, xi(sigma,pi),xi_HAM(sigma,pi), delta_xi, nDD etc. 

;readcol,'k2d_output_jack_perl_full_newcor.dat',temp1,temp2,sigma,pi,xi_std,$
;                                         Poi_err, nDD, nDR, nRR, xi_HAM, xi_LS
;produces /cos/pc19a/npr/LaTeX/the_paper/xi_si_pi_plot_from_perl_full_090806.ps

;readcol, 'k2d_output_jack_perl_full_newcor_090806.dat',temp1,temp2,sigma,pi, $
;	                     xi_std,  Poi_err, nDD, nDR, nRR, xi_HAM, xi_LS

;readcol,'k2d_output_jack_perl_EdS_full.dat',temp1,temp2,sigma,pi,xi_std,$
;                                         Poi_err, nDD, nDR, nRR, xi_HAM, xi_LS

;readcol,'k2d_output_jack_perl_full_newcor_090806.dat',sigma,pi,k_sigma,k_pi, $
;readcol,'k2d_output_jack_perl_full_newcor_v2.dat',sigma,pi,k_sigma,k_pi, $
;                                xi_std, Poi_err, nDD, nDR, nRR, xi_HAM, xi_LS
;produces /cos/pc19a/npr/.....
;From correl_five.f90, correl_five_perl.f90 and
;correl_five_AAOmega.f90


;readcol, 'kde_2d_output_20070907.dat', k_sigma, k_pi, sigma, pi, nDD,nDR, nRR, $
;                                   xi, xi_LS
;readcol, 'kde_2d_output_temp.dat', sigma, pi, xi, xi_STD, xi_LS
readcol, 'OP_20071102/kde_2d_output_tempf_20071102.dat', k_sigma, k_pi, $
         sigma, pi, nDD, nDR, nRR, xi, xi_LS


z=alog10(sqrt(xi^2)+0.0000001)       ;for DD/DR
;z=alog10(sqrt(xi_STD^2)+0.0000001)       ;for DD/RR
;z=alog10(sqrt(xi_LS^2)+0.0000001)       ;for LS


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
vsx=3
vsy=4

vsx=6
;vsy=5
;vsy=6
vsy=8

;vsx=6
;vsy=7
; Low value cutting:
; values of vsx=5 and vsy=7 work well for 


vsx=8
vsy=10

;vsx=8
;vsy=10





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
printf, 10, z4

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

; this line moved to nearer the top...
;z=alog10(sqrt(xi^2)+0.0000001)         ;for the Standard
;z=alog10(sqrt(xi^2)+0.0000001)         ;for the Hamiliton
;z=alog10(sqrt(xi_LS^2)+0.0000001)       ;for LS 


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
zmin=-2.5
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
if ps eq 1 then device, filename='xi_si_pi_plot.ps', $
                        /color, /inches
                        xsize=8, ysize=6, $
                        xoffset=0, yoffset=0.2

contour,z4,x4,y4, $
        nlev=255, /fill, /xs, /ys, $
        C_LINESTYLE = 1.,$ 
        xrange=[xmin,xmax], $ 
        yrange=[ymin,ymax], $ 
        zrange=[zmin,zmax], $ 
        charsize=2.8,$
        charthick=4,$
        ythick=2, $
        xthick=2, $
        xtitle = '!N !7r (!3h!E-1!N Mpc)', $
        ytitle = '!N !7p (!3h!E-1!N Mpc)',$
        position=[0.1,0.1,0.8,0.9]


print, 'gth2'
contour,z4,x4,y4,/overplot,/xs,/ys,C_LINESTYLE = 0,c_color=0,$
        xrange=[xmin,xmax],yrange=[ymin,ymax],$
 ;   ;    levels = [-2,-1.699,-1.301,-1,-0.699,-0.301,0,0.301,0.699,1,1.3,1.699],$
    ;    c_thick=[1,1,1,1,1,1,3,1,1,1,1],$
 ;   ;    c_annotation=['0.01','0.02','0.05','0.1','0.2','0.5','1','2','5','10','20','50'],c_charsize=0.6
levels = [-1.3,-1.1,-0.9,-0.7,-0.5,-0.3,-0.1, 0, 0.1, 0.3, 0.5, 0.7, 0.9, 1.1, 1.3], $
 c_thick=[   1,   1,   1,   1,   1,   1,   1, 5,   1,   1,   1,   1,   1,   1, 1], $
 c_annotation=['0.05','0.08','0.13','0.2','0.32','0.5','0.79','1','1.3','2.0','3.2','5.0','7.9', '12.6','20.0'],c_charsize=0.6



print, 'gth3'
scale = fltarr(2,256)
scalex=[0,1]
scaley = zmin+findgen(256)*(zmax-zmin)/255
label=string(alog10(scaley),format='(F4.2)')
print, 'gth4'
for i = 0,255 do scale(*,i) = scaley[i]
contour,scale,scalex,scaley,/fill,nlev=255,/xs,/ys,zrange=[zmin,zmax],$
  /closed,xtickname=[' ',' '],xtickinterval=1,ytitle="!N !3log(!7n)",$
  position=[0.9,0.1,0.95,0.9],/noerase,charsize=0.8
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
