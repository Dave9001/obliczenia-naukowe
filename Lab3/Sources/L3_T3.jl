###############################################################################
#
#	@brief:  	Source code for laboratory list number 1.
#
###############################################################################


include("../decorators/decor_L3_T3.jl")


function msiecznych(
    f::Function,
    x0::Float64,
    x1::Float64,
    delta::Float64,
    epsilon::Float64,
    maxit::Int
)
    arg = [x0, x1, delta, epsilon, maxit]
    if !correctRepresent(arg)
        println("Wrong number representation")
        exit()
    end
    errorMsg = 0
    it = 0

    fVal_x0 = f(x0)
    fVal_x1 = f(x1)

    for iterration = 1:maxit
        it = iterration
        if abs(fVal_x0) > abs(fVal_x1)
            tmp = x0
            x0 = x1
            x1 = tmp

            tmp = fVal_x0
            fVal_x0 = fVal_x1
            fVal_x1 = tmp
        end

        invDerivativeAprox = (x1 - x0)/(fVal_x1 - fVal_x0) #derivative -> f'(x) '
        x1 = x0
        fVal_x1 = fVal_x0
        x0 = x0 - (fVal_x0 * invDerivativeAprox)
        fVal_x0 = f(x0)

        if abs(x1 - x0) < delta || abs(fVal_x0) < epsilon
            return x0, fVal_x0, iterration, errorMsg
        end
    end

    errorMsg = 1
    return x0, fVal_x0, it, errorMsg
end


function correctRepresent(arg)
    for i = 1:length(arg)
        if isinf(arg[i]) || isnan(arg[i])
            return false
        end
    end

    return true
end
