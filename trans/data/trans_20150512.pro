pro trans
;; Code for Transitionary QSO paper plots

readpath  = './'
writepath = './'

form='(D,F,F,F,F,F,'+$
  ;'F7.3,F8.3,F8.3,F7.3,F7.3,F6.3,F7.3,F6.3,F7.3,F6.3,'+$
  ' X,   X,   X,   X,   X,   X,   X,   X,   X,   X,'+$
  'I,I,D'
readcol,readpath+'dm_2obs.dat',$
  f=form,skipline=8,$
  SDR7ID    ,$
  M_i       ,$
  redshift  ,$
  mbh       ,$
  lbol      ,$
  A_u       ,$
;  FIRST       ,$
;  SN_FIRST    ,$
;  logX        ,$
;  SN_X        ,$
;   Jmag       ,$
;  e_Jmag      ,$
;  Hmag        ,$
;  e_Hmag      ,$
;  Kmag        ,$
;  e_Kmag      ,$
  nobs       ,$
  s82flag    ,$
  mjd_r      ,$    ; Primary observation
  U_PSF ,$
  U_ERR ,$
  G_PSF ,$
  G_ERR ,$
  R_PSF ,$
  R_ERR ,$
  I_PSF ,$
  I_ERR ,$
  Z_PSF ,$
  Z_ERR

form=' X, X,   X,   X,   X,   X,   '+$
  ' X,   X,   X,   X,   X,   X,   X,   X,   X,   X,'+$
  'X,X,X,X,X,X,X,X,X,X,X,X,X,D'
readcol,readpath+'dm_2obs.dat',$
  f=form,skipline=8,$
 mjd_r2 ,$  ;latest secondary observation
  U_PSF2 ,$
  U_ERR2 ,$
  G_PSF2 ,$
  G_ERR2 ,$
  R_PSF2 ,$
  R_ERR2 ,$
  I_PSF2 ,$
  I_ERR2 ,$
  Z_PSF2 ,$
  Z_ERR2

readcol,readpath+'master_2obs.dat',f='X,D',ra,dec,skipline=127
readcol,readpath+'DB_QSO_S82.dat', f='A,D,D,A,D',$
  dbID, ras, decs, SDR5ID, M_is, M_i_corr, redshifts, mass_bh, lum_bol,$
  u,g,r,i,z,Aus,skipline=2

dt    = MJD_R2 - MJD_R ; Obs. time lag in days
dm_u  = u_PSF2 - u_PSF
dm_g  = g_PSF2 - g_PSF
dm_ge = sqrt(g_err2^2. + g_err^2.)
dm_r  = r_PSF2 - r_PSF
dm_i  = i_PSF2 - i_PSF
dm_z  = z_PSF2 - z_PSF

if (where(dt lt 0))[0] ne -1 then dm_u[where(dt lt 0)] = (u_PSF - u_PSF2)[where(dt lt 0)]
if (where(dt lt 0))[0] ne -1 then dm_g[where(dt lt 0)] = (g_PSF - g_PSF2)[where(dt lt 0)]
if (where(dt lt 0))[0] ne -1 then dm_r[where(dt lt 0)] = (r_PSF - r_PSF2)[where(dt lt 0)]
if (where(dt lt 0))[0] ne -1 then dm_i[where(dt lt 0)] = (i_PSF - i_PSF2)[where(dt lt 0)]
if (where(dt lt 0))[0] ne -1 then dm_z[where(dt lt 0)] = (z_PSF - z_PSF2)[where(dt lt 0)]
if (where(dt lt 0))[0] ne -1 then dt  [where(dt lt 0)] = (MJD_R - MJD_R2)[where(dt lt 0)]

here = where(g_psf eq 0 or g_psf2 eq 0); or abs(mjd_r2 - mjd_r) lt 300)
remove, here, g_psf2, g_psf, g_err,g_err2, s82flag, mjd_r,mjd_r2, SDR7ID,ra,dec,$
        dt, dm_u, dm_g, dm_r, dm_i, dm_z,dm_ge
here = where(g_err gt .15 or g_err2 gt .15)
remove, here, g_psf2, g_psf,g_err,g_err2,s82flag,mjd_r,mjd_r2, SDR7ID,ra,dec,$
        dt, dm_u, dm_g, dm_r, dm_i, dm_z,dm_ge
s82all = where( s82flag eq 1 or (abs(dec) le 1.27 and (ra ge 336 or ra lt 62)) ) 
; S82 >1mag variable quasars (to include La Massa obj):
s82big = where(abs(dm_g) ge 1 and ( s82flag eq 1 or (abs(dec) le 1.27 and (ra ge 336 or ra lt 62)) ) )

biggies0 = SDR7ID[s82big]
mchg0    = dm_g  [s82big]
mechg0   = dm_ge [s82big]
tchg0    = dt    [s82big]

readcol,writepath+'outliers.txt',f='D',dr7ido,skipline=2
match,biggies0,dr7ido,m1o,m2o
remove,m1o,biggies0,mchg0,mechg0,tchg0
biggies0 = biggies0 - 1 ;since IDL indexing is from 0, while SDR7ID is from 1


; -----------------------------------

readcol,readpath+'biggish_DR10_new.txt',f='A,A,D,D,D,D,A,D',DR7ID,dbID,ra,dec,redshift,mjds,sdssjid,mchg,mechg,tchg,skipline=1
readcol,readpath+'DB_QSO_S82_radio.dat', f='A,D',$
dbidr             ,$
rar               ,$
decr              ,$
first_flux       ,$
first_peak_flux  ,$
nvss_flux        ,$
gb6_flux         


match, dbid, dbidr, m1, m2

radio = (dbidr[m2])[where(first_flux     [m2] ne -99 or $
                         first_peak_flux [m2] ne -99 or $
                         nvss_flux       [m2] ne -99 or $
                         gb6_flux        [m2] ne -99)]

dbidrad = strarr(n_elements(dbid))
match, radio, dbid, m1r, m2r
if m2r[0] ne -1 then dbidrad[m2r] = 'Radio Source'


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Setting up the plotting...
;;
set_plot,'ps'
loadct,13
!p.charthick=3
!p.charsize=1.5;2.3
!p.thick=3
!x.thick=3
!y.thick=3 
dr12spec = mrdfits(readpath+'DR7QSOcrossmatchDR12.fit',1) ; DR12 Spec MJDs
common dr12, radr12,decdr12,mjdsdr12,iddr12
radr12 = dr12spec.ra
decdr12 = dr12spec.dec
mjdsdr12 = dr12spec.mjd
iddr12 = dr12spec.id  ; should be row of schneider, ie DR7ID

;;
;; Looping...
mjdlast = dblarr(n_elements(dbid))
dmspmax = dblarr(n_elements(dbid))
dtspmax = dblarr(n_elements(dbid))
for ibig=0,n_elements(dbid)-1 do begin
   grp = where(iddr12 eq dr7id[ibig],ngrp)
   if ngrp eq 0 then continue
   mjdgrp = mjdsdr12[grp]
   mjdlast[ibig] = max(mjdgrp)
; Take largest mag change spanned by spectral epochs:
   readcol,readpath+'QSO_S82+DR10/'+dbid[ibig],$
           f='X,X,X,D',mjd1,mag1,err1,/silent
; Append PS data
   filename = readpath+'s82/'+strtrim(dbid[ibig],1)
   spawn, '[ -f '+filename+' ] && echo "1" || echo "0"', result
   if result eq '1' then begin
      readcol,filename,f='D,D,D,A', mjddvo,  dvo, dvoerr, fildvo,  /silent
      gfildvo = where(fildvo eq 'g',ng)
      if gfildvo[0] ne -1 then mjdgdvo = mjddvo[gfildvo]
      if gfildvo[0] ne -1 then dvog    =    dvo[gfildvo]
      if gfildvo[0] ne -1 then dvogerr = dvoerr[gfildvo]
      if gfildvo[0] ne -1 then mjd1 = [ mjd1 , mjdgdvo  ] 
      if gfildvo[0] ne -1 then mag1 = [ mag1 ,dvog      ]
      if gfildvo[0] ne -1 then err1 = [ err1 ,dvogerr   ]
   endif
   sorted = sort(mjd1)
   mjd1  = mjd1[sorted]
   mag1  = mag1[sorted]
   err1  = err1[sorted]
   ; Calculate running median (med) and remove S82 points with |g-med|>outthresh mag
   outthresh=0.5
   smoothed = medsmooth(mag1,3)
   outliers = where(abs(mag1 - smoothed) gt outthresh, noutlier)
   if noutlier ge 1 then remove,outliers,mjd1, mag1, err1
   maggrp = fltarr(ngrp)
   for igrp=0,ngrp-1 do begin
      specep = where(abs(mjd1-mjdgrp[igrp]) eq min(abs(mjd1-mjdgrp[igrp])),nse)
      if nse gt 1 then specep = specep[where(err1[specep] eq min(err1[specep]),nse)]
      specep = specep[0]
      maggrp[igrp] = mag1[specep]
   endfor
   wmax = (where(maggrp eq max(maggrp),nwmax))[0]
   wmin = (where(maggrp eq min(maggrp),nwmin))[0]
   dmspmax[ibig] = max(maggrp) - min(maggrp)
   dtspmax[ibig] = mjdgrp[wmax] - mjdgrp[wmin]
endfor
newspec = where(mjdlast gt 5.5d4)
lucky = where(dmspmax ge .9)
luckylong = where(dmspmax ge .9 and mjdlast gt 5.5d4,nluck)
match,lucky,luckylong,m1l,m2l
remove,m1l,lucky
print,dbid[lucky]
;choose = lucky & iobj=0 ; obj (6008.eps) which is lucky w/o BOSS
;; see
;; http://skyserver.sdss.org/dr12/en/tools/explore/Summary.aspx?sid=457166801894139904

print,'Number of objects with >0.9 mag diff between SDSS and BOSS spectral epochs: ',nluck

; To just plot those with BOSS spec:
choose = newspec

; Just those changing-look qsos:
trans = [$
'2121523'      ,$
;'216689'       ,$
'410232'       ,$
;'1735533'      ,$
'1801540'      ,$
'missing/5048' ,$
'missing/6181' ,$
'2652671'      ,$
'4072331'      ,$
;'missing/6253' ,$
;'1401716'      ,$ ;false positive
;'2049364'      ,$ ;false positive
;'2579102'      ,$ ;false positive
'2024309']
  
match,trans,dbid,m1f,choose
nboss = n_elements(choose)


device,filename=writepath+'hist_dg.eps'
xr=[0,2.25]
plot,mchg0,/nodata,xr=xr,yr=[0,2000],ytit='#',xtit=textoidl('|\Deltag| (mag)'),xstyle=1
binsize = .1
yhist = histogram(abs(dm_g[s82all]),bin=binsize,min=xr[0],max=xr[1],locations=xhist);
xhist = xhist + binsize/2
loadct,0
for ih = 1,n_elements(xhist)-2 do $
  polyfill,xhist[ih] + [-binsize/2,binsize/2,binsize/2,-binsize/2],[yhist[ih],yhist[ih],0,0],color=150,/data
loadct,13
binsize = .1
gtzero = where(dmspmax gt 0)
yhist = histogram(abs(dmspmax[gtzero]),bin=binsize,min=xr[0],max=xr[1],locations=xhist);
xhist = xhist + binsize/2
oplot, xhist,yhist*10,psym=10
axis,xaxis=0,xr=xr,xstyle=1,ticklen=.05
xyouts,0.05,1200,'spec*10'
xyouts,0.5,1750,'phot'

plotsym,0,.5;,/fill
device,filename=writepath+'dt_dg.eps'
plot,      abs(dt[s82all])  , abs(dm_g[s82all]), psym=3, ytit=textoidl('|\Deltag| (mag)'),xtit=textoidl('|\Deltat| (days)')
oploterror,abs(dt[s82all])  , abs(dm_g[s82all]), dm_ge[s82all],psym=3;,color=250,errcolor=250
oplot,     abs(dtspmax)     , abs(dmspmax)     , psym=8,color=250
oploterror,abs(tchg[choose]), abs(mchg[choose]), mechg[choose],psym=7,color=100,errcolor=100
device,/close


openw,3,writepath+'biggish_DR10_new_trans_table.txt'
printf,3,'# ID name ra dec z Delta(g) Err_Delta(g) Delta(t)'
for iobj=0,nboss-1 do printf,3, f='(A16,2x,A,2x,F10.6,2x,F10.6,2x,F5.3,2x,F5.2,2x,F5.2,2x,I4)',dbid[choose[iobj]],sdssjid[choose[iobj]],ra[choose[iobj]],dec[choose[iobj]],redshift[choose[iobj]],mchg[choose[iobj]],mechg[choose[iobj]],tchg[choose[iobj]]
close,3


stop

readcol,'schneiderDR7.dat',skipline=135,f= $
  'A,D ,D ,D  ,'+$
  'D  ,D  ,D  ,D  ,D  ,D  ,D  ,D  ,D  ,D  ,D  ,'+$
  'X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,D,X,X,X,X,X,X,X,X,X,X,X,X,X,X,D',$
 SDSSJID,$    
  ra    ,$
  dec   ,$
  z     ,$
  upsf  ,$
  uerr  ,$
  gpsf  ,$
  gerr  ,$
  rpsf  ,$
  rerr  ,$
  ipsf  ,$
  ierr  ,$
  zpsf  ,$
  zerr  ,$
  Au    ,$
  Mi
device,filename=writepath+'zdist.eps',/color
plothist,redshift,bin=.1,line=1,xtit='Redshift',ytit='Number',ticklen=.05
plothist,redshift[choose],/over,color=250,bin=.1,peak=20,thick=6
plothist,z,color=75,/over,peak=80,bin=.1
legend,['Changing-look * 4',textoidl('All |\Deltag|>1 mag'),textoidl('All DR7 \div 75')],line=[0,1,0],col=[250,0,75],/right,box=0,thick=[6,3,3]
device,/close


stop
end
