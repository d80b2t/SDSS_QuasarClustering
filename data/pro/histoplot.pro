;
;
;+
; NAME:
;       HISTOPLOT
;
; PURPOSE:
;
;       This program is used to draw a histogram in an IDL direct
;       graphics window.
;
; AUTHOR:
;
;       FANNING SOFTWARE CONSULTING
;       David Fanning, Ph.D.
;       1645 Sheely Drive
;       Fort Collins, CO 80526 USA
;       Phone: 970-221-0438
;       E-mail: davidf@dfanning.com
;       Coyote's Guide to IDL Programming: http://www.dfanning.com
;
; CATEGORY:
;
;       Graphics
;
; CALLING SEQUENCE:
;
;      HistoPlot, dataToHistogram
;
; ARGUMENTS:
;
;       dataToHistogram:  The data from which the histogram is created.
;
; KEYWORDS:
;
;       AXISCOLORNAME:    The name of the axis color. Default: "Red".
;
;       BACKCOLORNAME:    The name of the background color. Default: "White".
;
;       BINSIZE:          The binsize of the histogram. By default the data range, divided
;                         by 128. If the data is an integer, the binsize is rounded to the
;                         nearest integer. If the data is BYTE type, the binsize is 1. The
;                         binsize, if supplied, must have the same data type as the data.
;
;       DATACOLORNAME:    The name of the data color. Default: "Navy".
;
;       FILLPOLYGON:      Set this keyword to fill the histogram polygons. If this keyword
;                         is set, the following keyword can also be used.
;
;                         POLYCOLOR:    The name, or vector of names, of polygon colors.
;                                       If a vector, the names are cycled though, as needed.
;
;       LINE_FILL:        If set, the polygons are filled with lines instead of solid color. If
;                         this keyword is set, the following keywords can also be used.
;
;                         ORIENTATION:  The orientation of the lines in line-filled polygons in degrees.
;                         PATTERN:      Set to rectangular array of pixel giving fill pattern.
;                         POLYCOLOR:    The name, or vector of names, of line colors.
;                                       If a vector, the names are cycled though, as needed.
;                         SPACING:      The spacing, in centimeters, between parallel lines.
;
;       MAX_VALUE:        The maximum data value to plot. Default: 5000.
;
;       MIN_VALUE:        The minimum data value to plot. Default: 0.
;
;       OPLOT:            Set this keyword if you want to overplot data on already established axes.
;
;       The user may also enter any other keywords suitable for the HISTOGRAM, PLOT, and POLYFILL commands in IDL.
;
; EXAMPLES:
;
;      IDL> Histoplot, Dist(256)
;      IDL> Histoplot, Fix(RandomU(seed, 200)*20), POLYCOLOR=['charcoal', 'steel blue'], /FILLPOLYGON
;      IDL> Histoplot, Fix(RandomU(seed, 200)*20), POLYCOLOR=['navy', 'forest green'], /LINE_FILL, ORIENTATION=[45,-45]
;
; REQUIRES:
;
;     Requires ERROR_MESSAGE and FSC_COLOR from the Coyote Library:
;
;        http://www.dfanning.com/programs/error_message.pro
;        http://www.dfanning.com/programs/fsc_color.pro
;
; MODIFICATION HISTORY:
;
;       Written by:  David W. Fanning, 14 November 2007.
;       Modified to work with !P.MULTI. 20 Nov 2007. DWF.
;       Slight problem with extra space at the right end of the plot resolved. 20 Nov 2007. DWF.
;-
;###########################################################################
;
; LICENSE
;
; This software is OSI Certified Open Source Software.
; OSI Certified is a certification mark of the Open Source Initiative.
;
; Copyright  2007 Fanning Software Consulting
;
; This software is provided "as-is", without any express or
; implied warranty. In no event will the authors be held liable
; for any damages arising from the use of this software.
;
; Permission is granted to anyone to use this software for any
; purpose, including commercial applications, and to alter it and
; redistribute it freely, subject to the following restrictions:
;
; 1. The origin of this software must not be misrepresented; you must
;    not claim you wrote the original software. If you use this software
;    in a product, an acknowledgment in the product documentation
;    would be appreciated, but is not required.
;
; 2. Altered source versions must be plainly marked as such, and must
;    not be misrepresented as being the original software.
;
; 3. This notice may not be removed or altered from any source distribution.
;
; For more information on Open Source Software, visit the Open Source
; web site: http://www.opensource.org.
;
;###########################################################################
PRO HistoPlot , $                   ; The program name.
   dataToHistogram, $               ; The data to draw a histogram of.
   AXISCOLORNAME=axisColorName, $   ; The axis color.
   BACKCOLORNAME=backcolorName, $   ; The background color.
   BINSIZE=binsize, $               ; The histogram bin size.
   DATACOLORNAME=datacolorName, $   ; The data color.
   _REF_EXTRA=extra, $              ; For passing extra keywords.
   FILLPOLYGON=fillpolygon, $       ; Set if you want filled polygons
   LINE_FILL=line_fill, $           ; Set if you want line-filled polygons.
   MAX_VALUE=max_value, $           ; The maximum value to plot.
   MIN_VALUE=min_value, $           ; The minimum value to plot.
   ORIENTATION=orientation, $       ; The orientation of the lines.
   OPLOT=overplot, $                ; Set if you want overplotting.
   PATTERN=pattern, $               ; The fill pattern.
   POLYCOLOR=polycolor, $           ; The name of the polygon draw/fill color.
   SPACING=spacing                  ; The spacing of filled lines.

   ; Catch any error in the HistoPlot program.
   Catch, theError
   IF theError NE 0 THEN BEGIN
      Catch, /Cancel
      ok = Error_Message(!Error_State.Msg + '. Returning...')
      RETURN
   ENDIF

   ; Check for positional parameter.
   IF N_Elements(dataToHistogram) EQ 0 THEN Message, 'Must pass data to histogram.'

   ; Check for histogram keywords.
   IF N_Elements(binsize) EQ 0 THEN BEGIN
      range = Max(dataToHistogram) - Min(dataToHistogram)
      CASE Size(DataToHistogram, /TNAME) OF
         'BYTE': binsize = 1
         'FLOAT': binsize = range / 128.0
         'DOUBLE': binsize = range / 128.0
         ELSE: binsize = Round(range / 128.0) > 1
      ENDCASE
   ENDIF ELSE BEGIN
       IF Size(binsize, /TYPE) NE Size(dataToHistogram, /TYPE) THEN $
         Message, 'The BINSIZE type is not the same as DATA type.'
   ENDELSE

   ; Check for keywords.
   IF N_Elements(dataColorName) EQ 0 THEN dataColorName = "Red"
   IF N_Elements(axisColorName) EQ 0 THEN axisColorName = "Navy"
   IF N_Elements(backColorName) EQ 0 THEN backColorName = "White"
   IF N_Elements(polycolor) EQ 0 THEN polycolor = dataColorName
   line_fill = Keyword_Set(line_fill)
   IF line_fill THEN fillpolygon = 1
   IF Keyword_Set(fillpolygon) THEN BEGIN
      fillpolygon = Keyword_Set(fillpolygon)
      IF N_Elements(orientation) EQ 0 THEN orientation = 0
      IF N_Elements(spacing) EQ 0 THEN spacing = 0
   ENDIF
   IF N_Elements(min_value) EQ 0 THEN min_value = 0

   ; Load plot colors.
   TVLCT, r, g, b, /GET
   axisColor = FSC_Color(axisColorName)
   dataColor = FSC_Color(datacolorName)
   backColor = FSC_Color(backColorName)

  ; Calculate the histogram.
   histdata = Histogram(dataToHistogram, Binsize=binsize, Max=Max(dataToHistogram), Min=Min(dataToHistogram), _EXTRA=extra)

   ; Have to fudge the bins and histdata variables to get the
   ; histogram plot to make sense.
   npts = N_Elements(histdata)
   halfbinsize = binsize / 2.0
   bins = Findgen(N_Elements(histdata)+1) * binsize + Min(dataToHistogram)
   binsToPlot = [bins[0], bins[0:npts-1] + halfbinsize, bins[npts-1] + binsize]
   histdataToPlot = [histdata[0], histdata, histdata[npts-1]]
   ytitle = 'Histogram Density'
   ytickformat = '(I)'
   IF N_Elements(max_value) EQ 0 THEN max_value = Max(histdataToPlot) * 1.05
   yrange = [min_value, max_value]

   ; Set up data coordinate space by drawing plot without anything showing.
   IF ~Keyword_Set(overplot) THEN BEGIN

      ; Trouble doing this with !P.MULTI, so check and save variables.
      IF Total(!P.MULTI) NE 0 THEN BEGIN
         bangp = !P
         bangx = !X
         bangy = !Y
         bangmap = !MAP
      ENDIF
      Plot, binsToPlot, histdataToPlot, $            ; The fudged histogram and bin data.
            Background=backcolor, $                  ; The background color of the display.
            NoData=1, $                              ; Draw the axes only. No data.
            XStyle=5, $                              ; Exact axis scaling. No autoscaled axes.
            YRange=yrange, $                         ; The Y data range.
            YStyle=5, $                              ; Exact axis scaling. No autoscaled axes.
            _Extra=extra, $                          ; Pass any extra PLOT keywords.
            XTICKFORMAT='(A1)', YTICKFORMAT='(A1)'
      IF Total(!P.MULTI) NE 0 THEN BEGIN
         bangAfterp = !P
         bangAfterx = !X
         bangAftery = !Y
         bangAftermap = !MAP
      ENDIF
   ENDIF

   ; Do we need to have things be filled?
   IF N_Elements(fillpolygon) NE 0 THEN BEGIN

       ncolors = N_Elements(polycolor)

      ; Are we line filling?
      IF line_fill THEN BEGIN

         norient = N_Elements(orientation)
         nspace = N_Elements(spacing)

         FOR j=0L,N_Elements(bins)-2 DO BEGIN
            x = [bins[j], bins[j], bins[j+1],  bins[j+1], bins[j]]
            y = min_value > [!Y.CRange[0], histDataToPlot[j+1], $
               histDataToPlot[j+1], !Y.CRange[0], !Y.CRange[0]] < max_value
            fillcolor = polycolor[j MOD ncolors]
            orient = orientation[j MOD norient]
            space = spacing[j MOD nspace]
            PolyFill, x, y, COLOR=FSC_Color(fillcolor), /LINE_FILL, ORIENTATION=orient, $
               PATTERN=pattern, SPACING=space, _Extra=extra
         ENDFOR

      ENDIF ELSE BEGIN ; Normal polygon color fill.

         FOR j=0L,N_Elements(bins)-2 DO BEGIN
            x = [bins[j], bins[j], bins[j+1],  bins[j+1], bins[j]]
            y = min_value > [!Y.CRange[0], histDataToPlot[j+1], histDataToPlot[j+1], $
                             !Y.CRange[0], !Y.CRange[0]] < max_value
            fillcolor = polycolor[j MOD ncolors]
            PolyFill, x, y, COLOR=FSC_Color(fillcolor), _Extra=extra
         ENDFOR

      ENDELSE
   ENDIF

   ; Plot the histogram of the display dataToHistogram. Do this after to repair
   ; damage to plot from POLYFILL.
   IF ~Keyword_Set(overplot) THEN BEGIN
      IF Total(!P.MULTI) NE 0 THEN BEGIN
         !P = bangp
         !X = bangx
         !Y = bangy
         !MAP = bangmap
      ENDIF
      Plot, binsToPlot, histdataToPlot, $            ; The fudged histogram and bin data.
            Color=axiscolor, $                       ; The color of the axes.
            NoData=1, $                              ; Draw the axes only. No data.
            XStyle=1, $                              ; Exact axis scaling. No autoscaled axes.
            XTitle='Data Value', $                   ; The title of the X axis.
            YMinor=1, $                              ; No minor tick mark on X axis.
            YRange=yrange, $                         ; The Y data range.
            YStyle=1, $                              ; Exact axis scaling. No autoscaled axes.
            YTickformat=ytickformat, $               ; The format of the Y axis annotations.
            YTitle=ytitle, $                         ; The title of the Y axis.
            /NOERASE, $                              ; Don't want to erase now!
            _Strict_Extra=extra                      ; Pass any extra PLOT keywords.
      IF Total(!P.MULTI) NE 0 THEN BEGIN
         !P = bangAfterp
         !X = bangAfterx
         !Y = bangAftery
         !MAP = bangAftermap
      ENDIF
   ENDIF

   ; Make histogram boxes by drawing lines in data color.
   FOR j=0L, N_Elements(bins)-1 DO BEGIN
         PlotS, [bins[j], bins[j]], min_value > [!Y.CRange[0], histDataToPlot[j]] < max_value, $
            Color=dataColor
   ENDFOR

   ; Overplot the histogram data in the data color.
   OPlot, binsToPlot, histdataToPlot, PSym=10, Color=dataColor

   ; Clean up.
   TVLCT, r, g, b
END


