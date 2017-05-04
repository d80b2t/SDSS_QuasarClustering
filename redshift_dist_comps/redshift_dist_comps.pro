;+
; NAME:
;       redshift_dist_comp

; PURPOSE:
;       To calculated correlation functions for SDSS DR5 quasars.
;
; EXPLANATION:
;
; CALLING SEQUENCE:
;       .run redshift_dist_comp
;
; INPUTS:
;       None.
;
; OUTPUTS:
;       various
;
; MODIFICATION HISTORY:
;       Version 1.00  NPR    18th January 2008
;               Works nicely. 
;-



;readcol, '2pt/redshift_comov_f90_temp.dat', zplus1, rc_f90, dlum, dlzcomb
readcol, '../2pt/redshift_comov_f90_CONCOR.dat', zplus1, rc_f90, dlum, dlzcomb
;readcol, '2pt/redshift_comov_f90_WMAP3.dat', zplus1_W, rc_f90_W, dlum_W, dlzcomb

zplus1 = zplus1 -1


z          = findgen(10000)
lumd       = findgen(10000)
rc         = findgen(10000)
lumd_WMAP3 = findgen(10000)
rc_WMAP3   = findgen(10000)

openw, 10, 'redshift_comov_IDL_temp.dat'
for i=0L,9999 do begin
   z[i]= (i*0.0005) + 0.0005

   lumd[i]       = lumdist(z[i], H0=100, /SILENT)
   rc[i]         = lumd[i]/(1.+z[i])
   lumd_WMAP3[i] = lumdist(z[i], H0=100,  Omega_M=0.26, Lambda0=0.74, /SILENT)
   rc_WMAP3[i]   = lumd_WMAP3[i]/(1.+z[i])

   printf, 10, z[i], rc[i], lumd[i], rc_WMAP3[i], lumd_WMAP3[i]
endfor




loadct, 6
!p.multi=0
set_plot, 'ps'
device, filename='redshift_dist_comps.ps', $
        xsize=8, ysize=8, /inches,/color
plot, z, rc, $
      xrange=[0.00, 5.0], yrange=[0.00, 20000], $
;      xrange=[0.00, 1.0], yrange=[0.00, 6000], $
      position=[0.20,0.12,0.98,0.98], $
      xstyle=1, ystyle=1, linestyle=0, $
      xcharsize=2.2, ycharsize=1.8, $
      charthick=3.2, thick=4, $
      xtitle='redshift, z', ytitle='distance / h-1 Mpc'
oplot, z, lumd, linestyle=1, thick=4
;oplot, zplus1, rc_f90, thick=4, color=128 
;oplot, zplus1, dlum,   thick=4, color=128, linestyle=1

oplot, z, rc_WMAP3,   thick=4, linestyle=0, color=64
oplot, z, lumd_WMAP3, thick=4, linestyle=1, color=64


;xyouts, 2.7,  9000, 'Omega_M=0.3', charsize=2.2
;xyouts, 2.7,  8000, 'Lambda=0.7', charsize=2.2
;xyouts, 2.7,  7000, 'k=0', charsize=2.2
;legend,['IDL  rc','IDL  lumd','F90 rc', 'F90 lumd'], $
;       line=[0,1,0,1], box=0, position=[2.7,13000], $
;       color=[0,0,128,128], charsize=1.8, charthick=4.2

;xyouts, 2.7, 14000, 'IDL', charsize=1.8, charthick=4.2
legend,['(0.3,0.7) rc','(0.3,0.7) lumd','WMAP3 rc', 'WMAP3 lumd'], $
       line=[0,1,0,1], box=0, position=[2.3,12000], $
       color=[0,0,64,64], charsize=1.8, charthick=4.2

;/usr/common/rsi/lib/general/LibAstro> aqua pro/legend.pro 
device, /close



print, 'z[9999], rc[9999], zplus1[9999], rc_f90[9999]'
print, z[9999], rc[9999], zplus1[9999], rc_f90[9999]








close, /all
end

