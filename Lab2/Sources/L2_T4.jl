###############################################################################
#
#	@brief:  	Source code for laboratory list number 1.
#
###############################################################################


include("../decorators/decor_L2_T4.jl")

function prodOutcomeRoots(P)

    factoredCoefficient = range(1.0, stop = 20.0, step = 1.0) #coeficient->_2_x^2 2 is an coeficient
    preciseRoots = factoredCoefficient

    NF = Poly(P) #NaturalForm  x^20 - 210x^19-...
    FF = poly(factoredCoefficient) #factoredForm (1-x)(2-x)...(20-x)

    NF_calcRoots = real(roots(NF))
    FF_calcRoots = real(roots(FF))

    NF_valueForRoots = Array{Float64}(undef,length(P)-1)
    FF_valueForRoots = Array{Float64}(undef,length(P)-1)

    NF_valueForCalcRoots = Array{Float64}(undef,length(P)-1)
    FF_valueForCalcRoots = Array{Float64}(undef,length(P)-1)
    
    for i = 1:length(NF_calcRoots)
        root = preciseRoots[i]
        NF_valueForRoots[i] = polyval(NF, root)

        calcRoot = NF_calcRoots[i]
        NF_valueForCalcRoots[i] = polyval(NF, calcRoot)
    end

    for i = 1:length(FF_calcRoots)
        root = preciseRoots[i]
        FF_valueForRoots[i] = polyval(FF, root)

        calcRoot = FF_calcRoots[i]
        FF_valueForCalcRoots[i] = polyval(FF, calcRoot)
    end

    for i = 1:length(preciseRoots)
        root = preciseRoots[i]
        println(root,"\t",abs(NF_calcRoots[i]),         "\t\t", abs(FF_calcRoots[i]), 
                "\t\t",   abs(NF_calcRoots[i] - root), "  \t\t", abs(FF_calcRoots[i] - root), 
                "\t\t",   abs(NF_valueForCalcRoots[i]),     "\t\t", abs(FF_valueForCalcRoots[i])
                )
    end

end
