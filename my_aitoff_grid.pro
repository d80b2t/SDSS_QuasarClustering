;+
;
;Date: Fri, 23 May 2008 15:50:56 -0400 (EDT)
;From: Yue Shen <yshen@astro.princeton.edu>
;To: Nic Ross <npr@astro.psu.edu>
;Subject: Re: IDL Aitoff projection, Equatorial coords
;Parts/Attachments:
;   1 Shown     40 lines  Text
;   2   OK    ~6.1 KB     Text, ""
;----------------------------------------;
;
;Hi Nic,
;
;Yes, I used IDL to make fig. 1 in Shen et al. (2007). For (ra,dec) points, I used AITOFF in Goddard library and AITOFF_GRID to overplot the gird. However, I believe I
;modified AITOFF_GRID to get around the problem you described. See my attached my_aitoff_grid.pro, which added an offset option to change the marking of RA. I am using
;offset=120 for fig. 1 in Shen et al. (2007). It's been a while, and I hope it still works.
;
;BTW, I will PROBABLY go to the SDSS assembly meeting in Chicago in Auguest too. Hope to see you there, and look forward to your talk.
;
;-- 
;Yue Shen
;Astrophysical Sciences
;Peyton Hall (609-258-8057)
;Princeton University
;Princeton, NJ 08544
;
;    [ Part 2, ""  Text/PLAIN (Name: "my_aitoff_grid.pro")  132 lines. ]
;    [ Not Shown. Use the "V" command to view or save this part. ];
;


; NAME:
;       AITOFF_GRID
;
; PURPOSE:
;       Produce an overlay of latitude and longitude lines over a plot or image
; EXPLANATION:
;       The grid is plotted on the current graphics device. AITOFF_GRID 
;       assumes that the ouput plot coordinates span the x-range of 
;       -180 to 180 and the y-range goes from -90 to 90.
;
; CALLING SEQUENCE:
;
;       AITOFF_GRID [,DLONG,DLAT, LABEL=, /NEW, CHARTHICK=, CHARSIZE=, _EXTRA=]
;
; OPTIONAL INPUTS:
;
;       DLONG   = Optional input longitude line spacing in degrees. If left
;                 out, defaults to 30.
;       DLAT    = Optional input latitude line spacing in degrees. If left
;                 out, defaults to 30.
;
; OPTIONAL INPUT KEYWORDS:
;
;       LABEL           = Optional keyword specifying that the latitude and
;                         longitude lines on the prime meridian and the
;                         equator should be labeled in degrees. If LABELS is
;                         given a value of 2, i.e. LABELS=2, then the longitude
;                         labels will be in hours instead of degrees.
;        CHARSIZE       = If /LABEL is set, then CHARSIZE specifies the size
;                         of the label characters (passed to XYOUTS)
;        CHARTHICK     =  If /LABEL is set, then CHARTHICK specifies the 
;                         thickness of the label characters (passed to XYOUTS)
;       /NEW          =   If this keyword is set, then AITOFF_GRID will create
;                         a new plot grid, rather than overlay an existing plot.
;
;       Any valid keyword to OPLOT such as COLOR, LINESTYLE, THICK can be 
;       passed to AITOFF_GRID (though the _EXTRA facility) to to specify the
;       color, style, or thickness of the grid lines.
; OUTPUTS:
;       Draws grid lines on current graphics device.
;
; EXAMPLE:
;       Create a labeled Aitoff grid of the Galaxy, and overlay stars at 
;       specified Galactic longitudes, glong and latitudes, glat
;
;       IDL> aitoff_grid,/label,/new        ;Create labeled grid
;       IDL> aitoff, glong, glat, x,y      ;Convert to X,Y coordinates
;       IDL> plots,x,y,psym=2              ;Overlay "star" positions
;
; PROCEDURES USED:
;       AITOFF
; NOTES:
;       If labeling in hours (LABEL=2) then the longitude spacing should be
;       a multiple of 15 degrees
;
; AUTHOR AND MODIFICATIONS:
;
;       J. Bloch        1.2     6/2/91
;       Converted to IDL V5.0   W. Landsman   September 1997
;       Create default plotting coords, if needed   W. Landsman  August 2000
;       Added _EXTRA, CHARTHICK, CHARSIZE keywords  W. Landsman  March 2001
;       Several tweaks, plot only hours not minutes W. Landsman January 2002
;-

PRO MY_AITOFF_GRID,DLONG,DLAT,LABEL=LABEL, NEW = new, _EXTRA= E, $
                   CHARSIZE = charsize, CHARTHICK =charthick, color = color, $
                   iplot = iplot, offset = offset
  
  print, 'gth1'
  
  if (NOT keyword_set(lng_min)) then lng_min = -180.0
  lng_max = 360.0 + lng_min        
  
  if  N_elements(dlong) EQ 0 then dlong = 30.0
  if  N_elements(dlat) EQ 0 then dlat = 30.0
  
; If no plotting axis has been defined, then create a default one
  
  new = keyword_set(new)
  if not new then new =  (!X.crange[0] EQ 0) and (!X.crange[1] EQ 0)
  if new then plot,[-180,180],[-90,90],/nodata,xsty=5,ysty=5
;
;       Do lines of constant longitude
;
  lat=findgen(181)-90
  lng=fltarr(181,/nozero)
;lng=fltarr(361, /nozero)
  lngtot = long(180.0/dlong)
;lngtot = long(360.0/dlong)
  
  print, 'gth2'
  for i=0,lngtot do begin
     replicate_inplace, lng, lng_min + (i*dlong)
     aitoff,lng,lat,x,y
     oplot,x,y,_extra=e, color = color
     oplot,-x,y,_extra=e, color = color
  endfor
;
;       Do lines of constant latitude
;
  lng = findgen(361)-180.0
  lat = fltarr(361,/nozero)
  lattot=long(180.0/dlat)
  for i=1,lattot do begin
     replicate_inplace, lat, -90. + (i*dlat)
     aitoff,lng,lat,x,y
     oplot,x,y,_extra=e, color = color
  endfor
;
;       Do labeling if requested
;
  if keyword_set(label) then begin
     
     print, 'gth3'
;
;       Label equator
;
     if (!d.name eq 'PS') and (!p.font eq 0) then hr = '!Uh!N' else hr='h'
     xoff = 2*dlong/30.
     for i=0,2*lngtot-1 do begin
        lng =  (180 + (i*dlong)) mod 360
        if (lng ne 150.0) and (lng ne 90.0) and (lng ne 30.0) and (lng ne 330.0) and (lng ne 270.0) and (lng ne 210.0) then begin
           aitoff,lng,0.0,x,y
           if label eq 1 then  xyouts,x[0]+5,y[0]-15,$
                                      strcompress(string((lng+offset) mod 360,format="(I4)"),/remove_all), $
                                      charsize = charsize, charthick = charthick, color = 0
           print, 'gth4'
;           else begin
;              tmp = lng/15.
;              xyouts,round(x[0])+xoff,round(y[0])+1,string(tmp[0],$
;                                                           format='(I2)') + hr, ;$
;                     charsize = charsize, charthick = charthick, color = 0
;              print, 'gth5'
;           endelse
        endif
     endfor
;
;       Label prime meridian
;
     
     print, 'gth6' 
     lat = -90 + (indgen(lattot-1)+1)*dlat
     aitoff,fltarr(lattot-1),lat,x,y
     slat = strtrim(round(lat),2)
     pos = where(lat GT 0, Npos)
     if Npos GT 0 then slat[pos] = slat[pos] 
     for i=0,lattot-2 do begin
        if slat[i] ne 0 then begin
           xyouts,x[i]-5,y[i]-2, slat[i], $
                  charsize = charsize, charthick = charthick, color = 0
           print, 'gth7'   
        endif
     endfor
     
  endif
  
  print, 'gth8' 
  return
end
