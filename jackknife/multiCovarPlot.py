# Make a density plot using biggles.  Useful
# to plot normalized covariance matrices
# v1.0 Adam D. Myers, May 2006

def clipmatrix(covar,min,max):
    """clip square 2D matrix (w row and col headers)
    
    Reduce a 2-d matrix only to those entries that aren't commented and
    don't lie outside of a specified min, max range for the first entry.
    Retain the row and column headers.

    OUTPUTS: Also outputs min, max, nod for new matrix

    Adam D. Myers, May 2006
    """

    keepem  = [0]
    prelim = []
    prelim.append(covar[0].rstrip('\n').split())
    result = []
    for i in range(1,len(covar)):
        j = covar[i].rstrip('\n').split()
        if j[0][0] == '#':
            pass
        elif float(j[0]) < min or float(j[0]) > max:
            pass
        else:
            prelim.append(j)
            keepem.append(i)
    for i in prelim:
        temp = []
        for j in keepem:
            temp.append(i[j])
        result.append(temp)

    reassemble = []

    for line in result:
       reassemble.append(" ".join(line)+'\n')

    return reassemble
                       

import biggles
from Numeric import *
from math import log10        
from sys import argv

if __name__=='__main__':

# ALL ARGUMENTS ARE FILE NAMES
# EXCEPT THE FINAL ARG WHICH IS THE COLOR SCHEME ("blue","blue_inv",
# "green", "green_inv", "red" or "red_inv")
# AND any 2 numbers passed, which are assumed to be minimum scale,
# maximum scale, in that order.  If 1 number is passed or if the
# scale maximum is less than the minimum, an error is raised.

    scalelist = [0.05, 210.]

    chuckem = []

    for i in range(len(argv)):
        try:
            scalelist.append(float(argv[i]))
            chuckem.append(i)
        except ValueError:
            pass

    chuckem.reverse()
    for i in chuckem:
       argv.pop(i) 

    scalemin = scalelist[-2]
    scalemax = scalelist[-1]

    if len(scalelist)==3:
        print "ERROR: PASS 2 SCALES FOR MIN, MAX RANGE, OR NO"
        print "NUMBERS FOR DEFAULT BEHAVIOR"
        raise IOError

    if scalemin > scalemax:
        print "ERROR: SCALE RANGE HAS MAXIMUM LESS THAN MINIMUM"
        print "WHICH WOULD RETURN AN EMPTY MATRIX"
        raise IOError

    print "scale constrained from ::",scalemin,"to", scalemax

    color = False
    if argv[-1]=='blue' or argv[-1]=='green' or argv[-1]=='red' or argv[-1]=='blue_inv' or argv[-1]=='green_inv' or argv[-1]=='red_inv':
        color = argv.pop(-1)
        print "COLOR SCHEME:",color
    else:
        print "COLOR SCHEME: grey"

    count = 1
    plotseq = [[0,0],[0,1],[1,0],[1,1]] # TL to BR sequence
    labels = ["Resolution=$0.3^o$","Resolution=$1^o$","Resolution=$3^o$","Resolution=$10^o$"]
    iplot = 0

    T = biggles.Table( 2, 2 )
# These are used to make plot windows

    print len(argv)

    for file in range(1,len(argv)):
        covar = open(argv[file],'r').readlines()

        norm = []

        if not color:
# greyscale: default
            covarlim = clipmatrix(covar,scalemin,scalemax)
# get rid of header
            header = covarlim.pop(0)

            for i in covarlim:
                temp = []
                j = i.rstrip('\n').split()
                j.pop(0)
                for k in j:
# map from -1,1 to 0,1 (also invert via the 1.- so that
# black is correlated and white is anti-correlated)
                    a = 1.-((float(k)+1.)/2.)
                    temp.append([float(a),float(a),float(a)])
                norm.append(temp)
# Make a vertical color key
            key = []
            for i in range(11):
                temply = []
                for j in range(11):
                    temply.append(3*[1-(j/10.)])
                key.append(temply)
                    
        else:
# color version (blue-green) or (blue-red) or (green-red)
            rgb = [2,1]
            if color=='blue_inv': rgb = [1,2]
            if color=='red': rgb = [2,0]
            if color=='green': rgb = [1,0]
            if color=='red_inv': rgb = [0,2]
            if color=='green_inv': rgb = [0,1]

            covarlim = clipmatrix(covar,scalemin,scalemax)
# get rid of header

            header = covarlim.pop(0)

            for i in covarlim:
                temp = []
                j = i.rstrip('\n').split()
                j.pop(0)
                for k in j:
# 1.- here is whimsy because blue seems to better depict
# 'correlated' to us and green 'anti-correlated'
                    a = 1.-((float(k)+1.)/2.)
                    blah = [0,0,0]
                    blah[rgb[0]]=1.-float(a)
                    blah[rgb[1]]=float(a)
                    temp.append(blah)
# NOTE: The Three-arrays thus created are just RGB palettes
# The first value is the fraction of red color you want (0-1)
# The second value is the desired fraction of green etc.
# Obviously, values like [0.5,0.5,0.5] are grey with [0,0,0]
# being black and [1,1,1] being white.
                norm.append(temp)
# Make a color key
            key = []
            for i in range(11):
                temply = []
                for j in range(11):
                    pal = [0,0,0]
                    pal[rgb[0]] = j/10.
                    pal[rgb[1]] = 1.-(j/10.)
                    temply.append(pal)
                key.append(temply)

# Get some axis labels

        info = header.rstrip('\n').split()
        info.pop(0)
# number of bins per decade
        bins = round(1./log10(float(info[-1])/float(info[-2])))
# implied min/max values in log space
        min=10**((int((bins*log10(float(info[0])))+1000)-1000)/bins)
        max=10**((int((bins*log10(float(info[-1])))+1001)-1000)/bins)
# middle entry
        mid =10**((int((bins*log10(float(info[len(info)/2])))+1000)-1000)/bins)
# Clean up so that they're good-lookin' strings for labels
        if str(min).index(".")==1: min = round(min,2)
        else: min = int(round(min,0))
        if str(max).index(".")==1: max = round(max,0)
        else: max = int(round(max,0))
        if str(mid).index(".")==1: mid = round(mid,1)
        else: mid = int(round(mid,0))

        print "\nplot",iplot,"::"
        print "bin edges :: min",min,"max",max
        print bins,"bins per decade...mid",mid
        
        st = len(info)-1

        mat = array(norm)
        keymat = array(key)
# Now we have an nxn matrix that, for every value, has an RGB
# triplet defining the density for that matrix element.
# We'll plot this with biggles:

# Construct plot
        bluff = biggles.FramedPlot()
        bluff.frame.draw_axis = 0
#        bluff.draw_nothing = 1
#        bluff.frame.ticklabels_style["color"] = "white"
        bluff.frame.ticklabels = [" "]
# We want to shift the plots to the left to include a legend on the
# right, so we set up a fake, empty (well, hidden, as empty is
# tricky) plot and offset the real plot from it as an "inset". 
        plot = biggles.FramedPlot()
#        plot.xlabel = "$\\theta$ (arcmin)"
#        plot.ylabel = "$\\theta$ (arcmin)"
        plot.frame.ticks = [min,max]
        plot.frame.draw_ticks = 0
        plot.frame.draw_ticklabels = 0
        plot.x1.draw_axis = 0
        plot.y1.draw_axis = 0
        plot.x2.draw_axis = 0
        plot.frame.subticks = st
        d = biggles.Density(mat, [[min,min], [max,max]])
        plot.add(d)
        try:
            if color[-3:]=="inv":
                plot.add(biggles.PlotLabel(0.7,0.2,labels[iplot],size=4,color="white"))
            else:
                plot.add(biggles.PlotLabel(0.7,0.2,labels[iplot],size=4))
#        bluff.add(biggles.Inset((-3,-3),(-2,-2),plot))
        except TypeError:
            plot.add(biggles.PlotLabel(0.7,0.2,labels[iplot],size=4))

        xx, yy = 0.1,-0.04 
        if iplot == 0 or iplot == 2:
            xx = 0.23
            plot.add(biggles.PlotLabel(-.01,.496,str(mid),size=3.5))
            plot.add(biggles.PlotLabel(-.01,.06,str(min),size=3.5))
            plot.add(biggles.PlotLabel(-.01,.94,str(max),size=3.5))
            plot.add(biggles.PlotLabel(-0.09,.496,"$\\theta$ (arcmin)",angle=90,size=4))
#            bluff.frame.ticklabels = ["0.0"]
            
        if iplot > 1:
            yy = 0.09
            plot.add(biggles.PlotLabel(.496,0,str(mid),size=3.5))
            plot.add(biggles.PlotLabel(.08,0,str(min),size=3.5))
            plot.add(biggles.PlotLabel(.92,0,str(max),size=3.5))
            plot.add(biggles.PlotLabel(.496,-0.06,"$\\theta$ (arcmin)",size=4))
#            bluff.frame.ticklabels = ["0.0"]

# This if-else allows for a larger plot if only one file is passed
        if len(argv)==2:
            bluff.add(biggles.Inset((0.15,-1.1),(2.25,1.1),plot))
        else:
            bluff.add(biggles.Inset((xx,yy),(xx+1.05,yy+1.1),plot))

        if iplot == 0:
            keyplot = biggles.FramedPlot()
            keyplot.frame.draw_axis = 0
            keyplot.x.draw_ticklabels = 0
            keyplot.frame.ticklabels = [" "]
            keyplot.frame.draw_ticks = 0
            keyd = biggles.Density(keymat,[[0,0],[1,1]])
            keyplot.add(keyd)
            try:
                if color[-3:]=="inv":
                    keyplot.add(biggles.PlotLabel(0.5,0.08,"-1.0",color="white"))
                    keyplot.add(biggles.PlotLabel(0.5,0.25,"-0.6",color="white"))
                    keyplot.add(biggles.PlotLabel(0.5,0.41,"-0.2",color="white"))
                    keyplot.add(biggles.PlotLabel(0.5,0.58,"0.2"))
                    keyplot.add(biggles.PlotLabel(0.5,0.74,"0.6"))
                    keyplot.add(biggles.PlotLabel(0.5,0.91,"1.0"))
                else:
                    keyplot.add(biggles.PlotLabel(0.5,0.08,"-1.0"))
                    keyplot.add(biggles.PlotLabel(0.5,0.25,"-0.6"))
                    keyplot.add(biggles.PlotLabel(0.5,0.41,"-0.2"))
                    keyplot.add(biggles.PlotLabel(0.5,0.58,"0.2",color="white"))
                    keyplot.add(biggles.PlotLabel(0.5,0.74,"0.6",color="white"))
                    keyplot.add(biggles.PlotLabel(0.5,0.91,"1.0",color="white"))
            except TypeError:
                keyplot.add(biggles.PlotLabel(0.5,0.08,"-1.0"))
                keyplot.add(biggles.PlotLabel(0.5,0.25,"-0.6"))
                keyplot.add(biggles.PlotLabel(0.5,0.41,"-0.2"))
                keyplot.add(biggles.PlotLabel(0.5,0.58,"0.2",color="white"))
                keyplot.add(biggles.PlotLabel(0.5,0.74,"0.6",color="white"))
                keyplot.add(biggles.PlotLabel(0.5,0.91,"1.0",color="white"))
                
            keyplot.add(biggles.PlotLabel(-0.23,0.5,"Normalized Covariance",angle=90,size=20))
            bluff.add(biggles.Inset((-0.07,-0.75),(0.05,0.75),keyplot))
            

# Put plot in correct 2x2 window
        if len(argv)==2:
            T[0,0] = bluff
        else:   
            T[plotseq[iplot][0],plotseq[iplot][1]] = bluff

        iplot += 1

        if iplot == 4:
# If we've got a set of 4 plots, create 2x2 plot
# output plot
            T.write_img( 600, 600, "covar"+str(count)+".gif" )
            T.show()
            T.write_eps( "covar"+str(count)+".eps" )
# and reinitialize
            del(T)
            T = biggles.Table( 2, 2 )
            iplot = 0
            count += 1
    
# Output final set of plots if previous set wasn't complete...

    if iplot> 0:
        T.show()
        T.write_img( 600, 600, "covar"+str(count)+".gif" )
        T.write_eps( "covar"+str(count)+".eps" )

