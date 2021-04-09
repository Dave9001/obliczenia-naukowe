###############################################################################
#
#	@brief:  	Source code for laboratory list number 1.
#
###############################################################################


include("../decorators/decor_L3_T2.jl")




function mstycznych(
    f::Function,
    pf::Function,
    x0::Float64,
    delta::Float64,
    epsilon::Float64,
    maxit::Int
)
    arg = [x0, delta, epsilon, maxit]
    if !correctRepresent(arg)
        println("Wrong number representation")
        exit()
    end
    errorMsg = 0
    
    fVal_x0 = f(x0)
    if abs(fVal_x0) < epsilon
        errorMsg = 1
        return x0, fVal_x0, 0, errorMsg
    end

    for iterration = 1:maxit
        if abs(pf(x0)) < eps(0.0) #!!!
            errorMsg = 2
            return x0, fVal_x0, 0, errorMsg
        end

        x1 = x0 - (fVal_x0 / pf(x0))
        fVal_x0 = f(x1)
        if abs(x1 - x0) < delta || abs(fVal_x0) < epsilon
            return x1, fVal_x0, iterration, errorMsg
        end
        x0 = x1
    end
end


function correctRepresent(arg)
    for i = 1:length(arg)
        if isinf(arg[i]) || isnan(arg[i])
            return false
        end
    end

    return true
end
