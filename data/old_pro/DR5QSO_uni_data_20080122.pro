; Just a wee .pro program to manipulate and record some of the
; interesting numbers of the Shen DR5 Homogeneous sample.
; 
; npr
; 21 nov 2007

print
data_full = mrdfits('/Volumes/Bulk/npr/cos_pc19a_npr/programs/quasars/data/dr5qso.fits', 1)
data      = mrdfits('/Volumes/Bulk/npr/cos_pc19a_npr/programs/quasars/data/DR5QSO_uni_data.fits', 1)
print
;http://deep.berkeley.edu/DR1/photo.primer.html
;
;        IDL> help, photo, /str;
;
; which will list the tags and their values for the first object in 
; the photo structure. Another option is to use the tag_names command like so:
;
;        IDL> print, tag_names(photo)
;

print
help, data_full
print, 'minimun redshift (full DR5) = ', min(data_full.z)
print, 'maximum redshift (full DR5) = ', max(data_full.z)
print, 'minimun Abso. i-Magnitude (full DR5) = ', min(data_full.M_I)
print, 'maximum Abso. i-Magnitude (full DR5) = ', max(data_full.M_I)
print


print
help, data
print, 'minimun redshift (Shen) = ', min(data.z)
print, 'maximum redshift (Shen) = ', max(data.z)
print, 'minimun redshift (Shen) = ', min(data.imag)
print, 'maximum redshift (Shen) = ', max(data.imag)
print


indx_z_cut_full   = where(data_full.z le 2.900, N_z_cut)
print, 'N_z_cut_full z<2.9', N_z_cut
indx_z_cut_full25 = where(data_full.z le 2.500, N_z_cut)
print, 'N_z_cut_full z<2.5', N_z_cut
print

indx_z_cut = where(data.z le 2.900, N_z_cut)
help, indx_z_cut
print
print, 'minimun redshift (homog, z<2.9) = ', min(data[indx_z_cut].imag)
print, 'maximum redshift (homog, z<2.9) = ', max(data[indx_z_cut].imag)

indx_z_cut25 = where(data.z le 2.500, N_z_cut)
help, indx_z_cut25
print, 'N_z_cut, z<2.5', N_z_cut
print
print, 'minimun redshift (homog, z<2.5) = ', min(data[indx_z_cut25].imag)
print, 'maximum redshift (homog, z<2.5) = ', max(data[indx_z_cut25].imag)



; ``Where do all the quasars come from''??
; i.e. under which selection did they get targetted??
; (not using TARGET and not BEST...)
indx_QSO   = where(data_full.TS_T_QSO      eq 1, N_TS_T_QSO)
indx_HIZ   = where(data_full.TS_T_HIZ      eq 1, N_TS_T_HIZ)
indx_FIRST = where(data_full.TS_T_FIRST    eq 1, N_TS_T_FIRST)
indx_ROAST = where(data_full.TS_T_ROSAT    eq 1, N_TS_T_ROSAT)
indx_SEREN = where(data_full.TS_T_SERENDIP eq 1, N_TS_T_SEREN)
indx_STAR  = where(data_full.TS_T_STAR     eq 1, N_TS_T_STAR)
indx_GAL   = where(data_full.TS_T_GAL      eq 1, N_TS_T_GAL)

indx_PRI   = where( ((data_full.TS_T_QSO     eq 1) or $
                     (data_full.TS_T_HIZ     eq 1) or $
                     (data_full.TS_T_FIRST   eq 1)),  N_TS_T_PRI)

indx_PRIz  = where( ((data_full.TS_T_QSO     eq 1) or $
                     (data_full.TS_T_HIZ     eq 1) or $
                     (data_full.TS_T_FIRST   eq 1) and $
                     (data_full.z            le 2.900)),  N_TS_T_PRIz)

indx_PRIs  = where( ((data_full.TS_T_QSO      eq 0) and $
                     (data_full.TS_T_HIZ      eq 0) and $
                     (data_full.TS_T_FIRST    eq 0) and $
                     (data_full.TS_T_SERENDIP eq 1) and $
                     (data_full.z             le 2.900)),  N_TS_T_PRIs)

indx_PRIt  = where( ((data_full.TS_T_QSO      eq 1) or $
                     (data_full.TS_T_HIZ      eq 1) or $
                     (data_full.TS_T_FIRST    eq 1) and $
                     (data_full.TS_T_SERENDIP eq 0) and $
                     (data_full.z             le 2.900)),  N_TS_T_PRIt)

indx_HIZz  = where( ((data_full.TS_T_HIZ     eq 1) and $
                     (data_full.z            le 2.900)),  N_TS_T_HIZz)



print, 'low    QSO targer flag (49010)', N_TS_T_QSO 
print, 'high   QSO targer flag (16383)', N_TS_T_HIZ 
print, 'FIRST  QSO targer flag ( 3501)', N_TS_T_FIRST 
print, 'ROSAT  QSO targer flag ( 4817)', N_TS_T_ROSAT 
print, 'Seren  QSO targer flag (42109)', N_TS_T_SEREN 
print, 'Star   QSO targer flag ( 1970)', N_TS_T_STAR
print, 'Galazy QSO targer flag (  536)', N_TS_T_GAL
print, 'Number in brackets from Schneider07, Table3' 
print
print, 'NUMBER OF OBJECTS IN ``PRIMARY'' SAMPLE,      ',  N_TS_T_PRI
;print, 'NUMBER OF OBJECTS IN ``PRIMARY'' SAMPLE, z<2.9',  N_TS_T_PRIz
print, 'NUMBER OF OBJECTS IN ``PRIMARY'' SAMPLE, z<2.5',  N_TS_T_PRIz
print
print, 'PRI=0 but SEREN=1',  N_TS_T_PRIs
print, 'PRI=1 but SEREN=0',  N_TS_T_PRIt
print, 'HIZ and z<2.9',  N_TS_T_HIZz
print


plate_hist = histogram(data_full.plate, min=266, max=2210, binsize=1)
; min(data_full.plate) =  266
; max(data_full.plate) = 2210
; h_DD         = h_DD + histogram(k_dist_DD, min=0, max=60)



indx_midz_cut = where(data.z ge 2.501 and data.z le 3.5, N_midz_cut)
help, indx_midz_cut
print, 'N_midz_cut (2.5<z<3.5)', N_midz_cut
print

;indx_uni_flag_yue = where(data.uni_flag_yue_new ne 1, N_uni_flag_yue)
;help, indx_uni_flag_yue
;print, 'N_uni_flag_yue', N_uni_flag_yue
;print

count=DINDGEN(1)
;print, 'count', count
j=26

;for j=0L, 31 do begin 
count=0
print
print, 'Now going after target_flag_bin[j], where j=',j
for i=0L,N_elements(data_full.targprimtarget)-1 do begin
   target_flag_bin  = better_binary(data_full[i].targprimtarget) 
;   target_flag_binn[i] =   best_binary(data_full[i].targprimtarget) 
   
   if target_flag_bin[j] eq 1 then begin
;      print, data_full[i].sdssname, data_full[i].ra, data_full[i].dec 
      count = count +1.
   endif
endfor
;   print, 'Number of objects where target_flag_bin[',j,'] =1 is', count
;endfor
   




loadct, 6

!p.multi=0
!p.multi=[0,2,2]
!p.font=-1
set_plot, 'ps'
device, filename='SDSS_Quasar_Nofz.ps', $
        xsize=8, ysize=8, xoffset=0, $
       yoffset=0.5+(10-8), /inches, /color
plothist, data_full.z, bin=0.05, $
          xrange=[-0.05, 3.6], yrange=[0.00, 2500], $
          position=[0.18,0.12,0.98,0.98], $
          xstyle=1, ystyle=1, linestyle=1, $
          charsize=2.2, charthick=3.2, thick=2, $
          xtitle='redshift, z', ytitle='Number of obecjts (0.05 bins)'
plothist, data_full[indx_PRIz].z,  bin=0.05, /overplot, linestyle=0, color=64, font=-2, thick=6
plothist, data[indx_z_cut].z,      bin=0.05, /overplot, linestyle=2, color=192, font=-2, thick=4

;xyouts, 2.1, 2250, 'dotted', color=0,  charsize=2.2, charthick=3.2 
;xyouts, 2.1, 2125, 'DR5Q ', color=0,  charsize=2.2, charthick=3.2
;xyouts, 2.1, 2000, '77 429 objects', color=0,  charsize=2.2, charthick=3.2

;xyouts, 2.1, 2250, 'dotted', color=0,  charsize=2.2, charthick=3.2 
;xyouts, 2.1, 2125, 'DR5Q ', color=0,  charsize=2.2, charthick=3.2
;xyouts, 2.1, 2000, '77 429 objects', color=0,  charsize=2.2, charthick=3.2

;xyouts, 2.1, 1850, 'solid', color=192,  charsize=2.2, charthick=3.2
;xyouts, 2.1, 1725, 'DR5Q homog.', color=192,  charsize=2.2, charthick=3.2
;xyouts, 2.1, 1600, '33 699 objects', color=192,  charsize=2.2, charthick=3.2

legend,['DR5Q','PRIMARY','Homogen.'],line=[1,0,2], box=0, position=[2.0,2250], color=[0,64,192],charsize=1.8, charthick=4.2
;/usr/common/rsi/lib/general/LibAstro> aqua pro/legend.pro 
device, /close

x=findgen(100)
x=(x/39)+0.08
a0 =      0.722126
a1 =      -3714.99
a2 =       61307.8
a3 =      -240654.
a4 =       465198.
a5 =      -524333.
a6 =       368668.
a7 =      -164409.
a8 =       45257.3
a9 =      -7016.63
a10=        468.571

fit = (a10*x^10)+(a9*x^9)+(a8*x^8)+(a7*x^7)+(a6*x^6)+(a5*x^5) + $
       (a4*x^4) + (a3*x^3) + (a2*x^2) + (a1*x) + (a0) 

fit[0] = 0.0001
indx_fit = where(fit gt 0, N_fit)
fit = fit(indx_fit)

set_plot, 'ps'
device, filename='SDSS_Quasar_Nofz_wFIT.ps', $
        xsize=8, ysize=8, xoffset=0, $
       yoffset=0.5+(10-8), /inches, /color
plothist, data[indx_z_cut25].z, bin=0.05, $
;plothist, data_full[indx_PRIz].z, bin=0.05, $
          xrange=[-0.05, 3.6], yrange=[0.00, 2500], $
          position=[0.18,0.12,0.98,0.98], $
          xstyle=1, ystyle=1, linestyle=2, $
          charsize=2.2, charthick=3.2, thick=4, $
          xtitle='redshift, z', ytitle='Number of obecjts (0.05 bins)'
plothist, data[indx_z_cut].z,  bin=0.05, /overplot, linestyle=2, color=192, font=-2, thick=4
oplot, x, fit,         color=128
;oplot, x, (fit*30.29), color=192

device, /close



;!p.multi=[0,2,2]
!p.multi=0
set_plot, 'ps'
device, filename='SDSS_Quasar_ra_dec.ps', $
        xsize=12, ysize=8, xoffset=0, $
        yoffset=0.5+(10-8), /inches, /color
aitoff_grid, /label, /new
;oplot, data.ra, data.dec, psym=3 ;,  position=[0.05,0.05,0.95,0.95]
device, /close


;data_full_Mpc = lumdist(data_full.z, H0=100.)
;data_full_Mpc = data_full_Mpc / (1+data_full.z)
;colour_int = fix( (data_full_Mpc / $
;                  (max(data_full_Mpc) - min(data_full_Mpc))) * 256.)
;data_full_theta = data_full.ra *(!dpi/180.)

data_Mpc = lumdist(data[indx_z_cut].z, H0=100.)
data_Mpc = data_Mpc / (1+data[indx_z_cut].z)
colour_int = fix( (data_Mpc / $
                  (max(data_Mpc) - min(data_Mpc))) * 256.)
data_theta = data[indx_z_cut].ra *(!dpi/180.)


set_plot, 'ps'
!p.multi=0
device, filename='SDSS_Quasar_Wedge.ps', $
        xsize=16, ysize=16, /inches, /color
plot, /polar, data_Mpc, data_theta, $
      xrange=[-5000,5000], yrange=[-5000,5000], $
;      xrange=[-2000,-1000], yrange=[-500,500], $
      xstyle=1, ystyle=1, $
      psym=3
;for i=0L, n_elements(data_Mpc)-1 do begin
;   oplot, /polar, data_Mpc[i], data_theta[i], $
;          psym=3, color=colour_int[i]
;endfor
device, /close



targ_flag_hist = histogram(data_full.targprimtarget, min=0, max=(1048576), $
                           binsize=1)
set_plot, 'ps'
!p.multi=0
device, filename='SDSS_Quasar_TargetFlag.ps', $
        xsize=8, ysize=8, /inches, /color
plot, targ_flag_hist, $
 ;     xrange=[0,268435456], yrange=[0,45000], $
 ;    xrange=[1.00000,67108864.], yrange=[0,41000.], $
     xrange=[1.00000,1048576.], yrange=[0,41000.], $
      /xlog, $
;      /ylog, $
      xstyle=1, ystyle=1, $
      psym=4
;for i=0L, n_elements(data_Mpc)-1 do begin
;   oplot, /polar, data_Mpc[i], data_theta[i], $
;          psym=3, color=colour_int[i]
;endfor
device, /close






leq_sign = String(108B)
!p.multi=[0,2,2]
!p.font=-1
set_plot, 'ps'
device, filename='SDSS_Quasar_Ab_iMag_redshift.ps', $
        xsize=8, ysize=8, xoffset=0, $
        yoffset=0.2, /inches, /color
; position=[(x_0, y_0), (x_1,y_1)]
;plothist, data_full.z, bin=0.05, xrange=[-0.1, 5.8], $
;plothist, data_full.z, bin=0.05, xrange=[-0.1, 3.0],  $
plot, data_full[indx_HIZz].z, $
          xrange=[-0.1, 3.0],  yrange=[0,799], $
          xstyle=1, ystyle=1, $
          position=[0.30,0.12, 0.96,0.30], $
          thick=4.2, $
          xtitle='redshift, z', $
;          XTICKFORMAT="(A1)", color=0, $
          xcharsize=2.2, xthick=3.2, $
          color=0, /nodata
plothist,  data_full[indx_HIZz].z, bin=0.05,  $
           position=[0.30,0.12, 0.96,0.30], $
           color=192, /overplot

;plothist, data.z, bin=0.05, $
;          XTICKFORMAT="(A1)", /OVERPLOT, color=128
;plothist, data[indx_z_cut].z, bin=0.05, $
;          XTICKFORMAT="(A1)", /OVERPLOT, color=192
;
;plot, data_full.z, data_full.M_I, xrange=[-0.1, 5.8], $
;plot, data_full.z, data_full.M_I, xrange=[-0.1, 3.0], $
;plot,  data_full[indx_PRIz].z, data_full[indx_PRIz].M_I, xrange=[-0.1, 3.0], $
;plot,  data_full[indx_PRI].z, data_full[indx_PRI].M_I, xrange=[-0.1,;3.0], $
plot,  data_full[indx_HIZz].z, data_full[indx_HIZz].M_I, $
;plot, data[indx_z_cut].z, data[indx_z_cut].imag, xrange=[-0.1, 3.0], $
       xrange=[-0.1, 3.0], $
;       yrange=[-30.5, -21.5], $
       yrange=[-21.5, -30.7], $
       position=[0.30,0.30,0.96,0.96], $
;      position=[0.16,0.12,0.96,0.75], $
;      position=[0.16,0.12,0.96,0.95], $
       xstyle=1, ystyle=1, psym=3, $
       charsize=2.2, charthick=3.2, $
       xtickformat="(A1)", ytickformat="(A1)", color=0
;       xtitle='redshift, z' 
;      xtitle='redshift, z', ytitle='M!I i !N'  
;     !I or !D = subscript, !N = back to normal
;
;oplot, data.z, data.imag, psym=3, color=128
;oplot, data[indx_z_cut].z, data[indx_z_cut].imag, psym=3, color=192
;oplot, data_full[indx_QSO].z, data_full[indx_QSO].M_I, psym=3, color=192 
;oplot, data_full[indx_SEREN].z, data_full[indx_SEREN].M_I, psym=3,color=192
;oplot, data_full[indx_PRI].z, data_full[indx_PRI].M_I, psym=3, color=192  
;oplot, data_full[indx_PRIz].z, data_full[indx_PRIz].M_I, psym=3, color=192 
;oplot, data_full[indx_PRIs].z, data_full[indx_PRIs].M_I, psym=3, color=192 
oplot, data_full[indx_HIZz].z, data_full[indx_HIZz].M_I, psym=3, color=192 

;plothist, data.imag, bin=0.10, position=[0.7,0.08,0.95,0.7] 
;          ;this works but is not rotated.
;plothist, data.imag, bin=0.05, position=[0.7,0.7,0.95,0.1] 

plothist, data[indx_z_cut].imag, bin = 0.1, $
          thick = 3.0, peak = 0.50, xhist, yhist, /noplot, $
          position=[0.12,0.30,0.30,0.96]
;plothist, data[indx_z_cut].z, bin=0.05, $
;          XTICKFORMAT="(A1)", /OVERPLOT, color=192;;
print
help, xhist
help, yhist
print

;xhist = reverse(xhist)
plot, yhist,  xhist,  $
      xrange=[0.0,0.49], yrange=[-21.5, -30.7], $
      xstyle=1, ystyle=1, $
      ycharsize=2.2, ythick=3.2, $
      ytitle='M!I i !N', $  
      position=[0.12,0.30,0.30,0.96], $
      /nodata
;oplot,  yhist,  xhist,  color=192

for i=0L, n_elements(xhist) - 1L do begin
   if i eq 0L or i eq n_elements(xhist) - 1L then begin 
;  close the first/last      bin
      oplot, [0,yhist[i]], [xhist[i]+0.05, xhist[i]+0.05], $
             thick = 3, color = 192
      oplot, [yhist[i], yhist[i]], [xhist[i]-0.05, xhist[i]+0.05], $
             thick = 3, color = 192
;      http://www.dfanning.com/documents/programs.html#FSC_COLOR
   endif else begin
      oplot, [yhist[i-1], yhist[i]], [xhist[i]-0.05, xhist[i]-0.05], $
             thick = 3, color = 192
      oplot, [yhist[i],yhist[i]], [xhist[i]-0.05, xhist[i]+0.05], $
             thick = 3, color = 192
   endelse
endfor




;xyouts, 0.9, 0.9,    'DR5 Quasars',   color=0,   charsize=2.2, charthick=3.2
;xyouts, 1.6, -22.25, '77429 (full)',  color=0,   charsize=2.2, charthick=3.2
;xyouts, 1.6, -23.0,  '55577 (T_PRI)',  color=192, charsize=2.2, charthick=3.2
;xyouts, 1.6, -23.0,  '50062 (T_PRIz)',  color=192, charsize=2.2, charthick=3.2
xyouts, 1.2, -22.5,  '11 129 (T_HIZz)',  color=192, charsize=2.2, charthick=3.2



;xyouts, 1.1, -24.00, 'DR5Q Homog. z<2.9', color=192, charsize=2.2, charthick=3.2
;xyouts, 1.1, -23.25, '33 699 objects ', color=192, charsize=2.2, charthick=3.2
;xyouts, 1.1, -22.50, '-22.2 !9'+ leq_sign + '!X M!Ii!N !9'+ leq_sign
;+'!X -30.65', color=192, charsize=2.2, charthick=3.2







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Trying to add  apparent magnitude cuts (i=19.1) in order to
; see Yue Shen's selection(s).....
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;d_ten_pc = lumdist(data.z, H0=70.)
;m_limit = 19.1
;M_curve = 5. - (5. * alog10(d_ten_pc)) - m_limit + 8.
;oplot, data.z, M_curve, color=64, psym=3
;
;d_ten_pc = lumdist(data.z, H0=70.)
;d_ten_pc = d_ten_pc / (1+d_ten_pc)
;m_limit = 19.1
;M_curve = 5. - (5. * alog10(d_ten_pc)) - m_limit
;oplot, data.z, M_curve, color=100, psym=3
;

xyouts, 0.9, 0.9,    'DR5 Quasars', color=0, charsize=2.2
xyouts, -30.0, 2000, 'DR5 Quasars', color=0, charsize=2.2
xyouts, -30.0, 1900, '77429 (full)', color=0, charsize=2.2
xyouts, -30.0, 1800, '38208 (homog)', color=128, charsize=2.2

device, /close 
; for set_plot, 'ps'
;       device, filename='SDSS_Quasar_Ab_iMag_redshift.ps', $










; Make IDL's plotting area hold 2 columns and 3 rows of plots:  
; !p.multi=[0,2,3]
!p.multi=[0,1,4]
set_plot, 'ps'
device, filename='SDSS_Quasar_colours_redshift.ps', $
        xsize=8, ysize=8, xoffset=0, $
       yoffset=0.5+(10-8), /inches, /color
plot, data.z, (data.best_u[0] - data.best_g[0]), psym=3, xrange=[-0.1, 6.5],    $
      position=[0.1,0.1,0.9,0.3], xtitle='redshift', ytitle='g-i'
plot, data.z, (data.best_g[0] - data.best_i[0]), $
      position=[0.1,0.3,0.9,0.5], psym=3, ytitle='g-i'
plot, data.z, (data.best_g[0] - data.best_i[0]), $
      position=[0.1,0.5,0.9,0.7], psym=3, ytitle='g-i'
plot, data.z, (data.best_g[0] - data.best_i[0]), $
      position=[0.1,0.7,0.9,0.9], psym=3, ytitle='g-i'
device, /close
!p.multi=0
set_plot, 'X'


openw, 10, 'DR5_quasars_for_thumbnails.dat'
print
for i=0L, N_elements(data.z)-1 do begin
   
   if (data[i].z gt 0.099 and data[i].z lt 0.101) then printf, 10, data[i].sdss_name, data[i].ra, data[i].dec, data[i].z
   if (data[i].z gt 0.199 and data[i].z lt 0.201) then printf, 10, data[i].sdss_name, data[i].ra, data[i].dec, data[i].z
   if (data[i].z gt 0.299 and data[i].z lt 0.301) then printf, 10, data[i].sdss_name, data[i].ra, data[i].dec, data[i].z
   if (data[i].z gt 0.399 and data[i].z lt 0.401) then printf, 10, data[i].sdss_name, data[i].ra, data[i].dec, data[i].z
   if (data[i].z gt 0.499 and data[i].z lt 0.501) then printf, 10, data[i].sdss_name, data[i].ra, data[i].dec, data[i].z
   if (data[i].z gt 0.599 and data[i].z lt 0.601) then printf, 10, data[i].sdss_name, data[i].ra, data[i].dec, data[i].z
   if (data[i].z gt 0.699 and data[i].z lt 0.701) then printf, 10, data[i].sdss_name, data[i].ra, data[i].dec, data[i].z
   if (data[i].z gt 0.799 and data[i].z lt 0.801) then printf, 10, data[i].sdss_name, data[i].ra, data[i].dec, data[i].z
   if (data[i].z gt 0.899 and data[i].z lt 0.901) then printf, 10, data[i].sdss_name, data[i].ra, data[i].dec, data[i].z
   if (data[i].z gt 0.999 and data[i].z lt 1.001) then printf, 10, data[i].sdss_name, data[i].ra, data[i].dec, data[i].z
   
endfor
print
close, 10
close, /all

end

