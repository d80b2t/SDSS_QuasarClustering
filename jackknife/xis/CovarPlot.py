# Make a density plot using biggles.  Useful
# to plot normalized covariance matrices
# THE FIRST ARGUMENT IS THE FILE NAME
# SECOND ARG IS THE COLOR SCHEME ("blue", "green" or "red")
# if no second argument is supplied it defaults to B&W
# v1.0 Adam D. Myers May 2006

import biggles
from Numeric import *
from math import log10

if __name__=='__main__':

        from sys import argv

        covar = open(argv[1],'r').readlines()
        header = covar.pop(0)
# get rid of header

        norm = []
# change everything to floats

        if len(argv)==2:
# greyscale: default
                for i in covar:
                        temp = []
                        j = i.rstrip('\n').split()
                        j.pop(0)
                        for k in j:
# map from -1,1 to 0,1 (also invert via the 1.- so that
# black is correlated and white is anti-correlated)
                                a = 1.-((float(k)+1.)/2.)
                                temp.append([float(a),float(a),float(a)])
                        norm.append(temp)
        else:
# color version (blue-green) or (blue-red) or (green-red)
                rgb = [2,1]
                if argv[2]=='red': rgb = [2,0]
                if argv[2]=='green': rgb = [1,0]

                for i in covar:
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
        if str(max).index(".")==1: max = round(max,2)
        else: max = int(round(max,0))
        if str(mid).index(".")==1: mid = round(mid,2)
        else: mid = int(round(mid,0))

        print min, max, mid
        
        st = len(info)-1

        mat = array(norm)

# Now we have an nxn matrix that, for every value, has an RGB
# triplet defining the density for that matrix element.
# We'll plot this with biggles:

# Construct plot
        plot = biggles.FramedPlot()
        plot.xlabel = "$\\theta$ (arcmin)"
        plot.ylabel = "$\\theta$ (arcmin)"
        plot.frame.ticks = [min,max]
        plot.frame.subticks = st
        d = biggles.Density(mat, [[min,min], [max,max]])
        plot.add(d)
        plot.add(biggles.PlotLabel(-.05,.496,str(mid)))
        plot.add(biggles.PlotLabel(.496,-.05,str(mid)))
# Create plot
        plot.write_img( 600, 600, "covar.gif" )
        plot.show()
        plot.write_eps( "covar.eps" )
