###############################################################################
#
#	@brief:  	Source code for laboratory list number 1.
#
###############################################################################


include("../decorators/decor_L3_T1.jl")



function mbisekcji(
    f::Function, a::Float64,b::Float64, delta::Float64, epsilon::Float64
)
    arg = [a, b, delta, epsilon]
    if !correctRepresent(arg)
        println("a: ", a, "\n", "b: ", b, "\n", "delta: ", delta, "\n", "epsilon: ",epsilon,"\n")
        println("Wrong number representation")
        exit()
    end
    errorMsg = 0
    
    if a < b
        tmp = a
        a   = b
        b   = tmp
    end
        
    fVal_a = f(a)
    fVal_b = f(b)
    intervalWidth = b - a

    if sign(fVal_a) == sign(fVal_b)
        errorMsg = 1
        return a, fVal_a, 0, errorMsg
    end

    maxNumOfIterations = typemax(eltype(Int))
    for iterration = 1:maxNumOfIterations
        intervalWidth  = intervalWidth / 2
        intervalCenter = a + intervalWidth
        fVal_center    = f(intervalCenter)

        if abs(intervalWidth) < delta || abs(fVal_center) < epsilon
            return intervalCenter, fVal_center, iterration, errorMsg
        end

        if sign(fVal_center) != sign(fVal_a)
            b = intervalCenter
            fVal_b = fVal_center
        else
            a = intervalCenter
            fVal_a = fVal_center
        end
    end
end

function correctRepresent(arg)
    for i = 1:length(arg)-1
        println("ten jest zly: ", arg[i] )
        if isinf(arg[i]) || isnan(arg[i])
            
            #return false
        end
    end

    return true
end
