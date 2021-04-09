###############################################################################
#
#	@brief:  	Source code for laboratory list number 1.
#
###############################################################################
using Plots

include("../decorators/decor_L2_T2.jl")

function calcLimit()
    d = range(10.0,step=1,stop=45)
	f(x) = exp(x)*log2(1+exp(-x))
	for i in d
		println("x: f(", i,") = ",f(i))
    end

    println("\nReal limit = 1")
end

function plotGraph()
	f(x) = exp(x)*log2(1+exp(-x))
	plot(f,-10,45)
end


