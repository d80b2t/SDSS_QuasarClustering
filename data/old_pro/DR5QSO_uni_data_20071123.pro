; Just a wee .pro program to manipulate and record some of the
; interesting numbers of the Shen DR5 Homogeneous sample.
; 
; npr
; 21 nov 2007


data_full = mrdfits('/Volumes/Bulk/npr/cos_pc19a_npr/programs/quasars/data/dr5qso.fits', 1)
data      = mrdfits('/Volumes/Bulk/npr/cos_pc19a_npr/programs/quasars/data/DR5QSO_uni_data.fits', 1)

;http://deep.berkeley.edu/DR1/photo.primer.html
;
;        IDL> help, photo, /str;
;
; which will list the tags and their values for the first object in 
; the photo structure. Another option is to use the tag_names command like so:
;
;        IDL> print, tag_names(photo)
;


help, data_full
print
print, 'minimun redshift = ', min(data_full.z)
print, 'maximum redshift = ', max(data_full.z)
print


help, data
print
print, 'minimun redshift (Shen) = ', min(data.z)
print, 'maximum redshift (Shen) = ', max(data.z)
print




indx_z_cut = where(data.z le 2.500, N_z_cut)
help, indx_z_cut
print, 'N_z_cut', N_z_cut
print

indx_midz_cut = where(data.z ge 2.501 and data.z le 3.5, N_midz_cut)
help, indx_midz_cut
print, 'N_midz_cut', N_midz_cut
print

indx_flag = where(data.uni_flag_yue_new ne 1, N_flag)
help, indx_flag
print, 'N_flag', N_flag
print


loadct, 6

!p.multi=[0]
!p.multi=[0,2,2]
set_plot, 'ps'
device, filename='SDSS_Quasar_Nofz.ps', $
        xsize=8, ysize=8, xoffset=0, $
       yoffset=0.5+(10-8), /inches, /color
plothist, data.z, bin=0.05, xrange=[-0.05, 6.6], position=[0.05,0.05,0.95,0.95]
device, /close


!p.multi=[0,2,2]
set_plot, 'ps'
device, filename='SDSS_Quasar_ra_dec.ps', $
        xsize=8, ysize=8, xoffset=0, $
        yoffset=0.5+(10-8), /inches, /color
plot, data.ra, data.dec, psym=3,  position=[0.05,0.05,0.95,0.95]
device, /close


!p.multi=[0,2,2]
set_plot, 'ps'
device, filename='SDSS_Quasar_Ab_iMag_redshift.ps', $
        xsize=8, ysize=8, xoffset=0, $
       yoffset=0.5+(10-8), /inches, /color

;plothist, data_full.z, bin=0.05, xrange=[-0.2, 6.6], $
plothist, data_full.z, bin=0.05, xrange=[-0.2, 3.0],  $
          position=[0.08,0.7,0.7,0.95], $
          XTICKFORMAT="(A1)", color=0
plothist, data.z, bin=0.05, XTICKFORMAT="(A1)", color=128, /OVERPLOT

;plot, data_full.z, data_full.M_I, xrange=[-0.2, 6.6], $
plot, data_full.z, data_full.M_I, xrange=[-0.2, 3.0], $
      yrange=[-30.5, -21.5], $
      position=[0.08,0.08,0.7,0.7], psym=3, $
      xstyle=1, ystyle=1, $
      xtitle='redshift, z', ytitle='M!I i !N'  ;!I or !D = subscript, !N = back to normal
oplot, data.z, data.imag, psym=3, color=128


d_ten_pc = lumdist(data.z, H0=70.)
;d_ten_pc = d_ten_pc / (1+d_ten_pc)
m_limit = 19.1
M_curve = 5. - (5. * alog10(d_ten_pc)) - m_limit
oplot, data.z, M_curve, color=64, psym=3
M_curve = 5. - (5. * alog10(d_ten_pc)) - m_limit + 5.0
oplot, data.z, M_curve, color=64, psym=3


d_ten_pc = lumdist(data.z, H0=70.)
d_ten_pc = d_ten_pc / (1+d_ten_pc)
m_limit = 19.1
M_curve = 5. - (5. * alog10(d_ten_pc)) - m_limit
oplot, data.z, M_curve, color=100, psym=3



plothist, data.imag, bin=0.10, position=[0.7,0.08,0.95,0.7] ; this works but is not rotated.
;plothist, data.imag, bin=0.05, position=[0.7,0.7,0.95,0.1] 


xyouts, 0.9, 0.9,    'DR5 Quasars', color=0, charsize=2.2
xyouts, -30.0, 2000, 'DR5 Quasars', color=0, charsize=2.2
xyouts, -30.0, 1900, '77429 (full)', color=0, charsize=2.2
xyouts, -30.0, 1800, '38208 (homog)', color=128, charsize=2.2


device, /close


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


!p.multi=[0]



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


