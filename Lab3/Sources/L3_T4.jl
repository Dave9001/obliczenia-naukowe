###############################################################################
#
#	@brief:  	Source code for laboratory list number 1.
#
###############################################################################


include("../decorators/decor_L3_T4.jl")


function printFunctionOutput(functionName, args)
    f       = args[1]
    x0      = args[2]
    x1      = args[3]
	delta   = args[4]
    epsilon = args[5]
    pf      = args[6]
    maxit   = args[7]
    
    if mbisekcji == functionName
        r, v, it, err = functionName(f, x0, x1, delta, epsilon)

    elseif mstycznych == functionName
        r, v, it, err = functionName(f, pf, x0, delta, epsilon, maxit)

    elseif msiecznych == functionName
        r, v, it, err = functionName(f, x0, x1, delta, epsilon, maxit)
    
    else
        println("Nieznana funkcja")
        exit()
    end

    output = [r, v, it, err]
    decorator_L3_T4_printOutFunctionsOutput(functionName, output)
end

    
