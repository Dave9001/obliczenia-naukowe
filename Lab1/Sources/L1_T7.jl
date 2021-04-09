
 include("../decorators/decor_L1_T7.jl")
# (sin(x)+cos(3x))' = cos(x) - 3 sin(3*x)

function f(x)
    result = sin(x) + cos(3*x)
    return result
end

function derivativeApproximation(funct, x::Float64, h::Float64)
    result = (funct(x+h) - funct(x)) / h
    return result
end

function retExactValOfDerivate(x::Float64)
    if x == 1.0
        return value::Float64 = 0.116942281688538051098702199018645764191510627861125475214
    else
        return nothing
    end
end

function calcAbsError(exactValue, approximatedValue)
    result = abs(exactValue - approximatedValue)
    return result
end

function prodOutcomeDerivativeApproximation()
    #dec
    derivativeForEachExponent, derivativeAbsError = calcDerivativeApproximation()

    decoratorCompareDerivateCalc(derivativeForEachExponent, derivativeAbsError)
end

function calcDerivativeApproximation()
    minExponent = 0
    maxExponent = 54 + 1
    resultsForEachExponent = Array{Float64}(undef, maxExponent)
    for i = 1:maxExponent
        h = 2.0^(-minExponent)
        resultsForEachExponent[i] = derivativeApproximation(f, 1.0, h)
        minExponent +=1
    end

    exactValOfDerivate = retExactValOfDerivate(1.0) 
    resultAbsError =  Array{Float64}(undef, maxExponent)
    for i = 1:maxExponent
        resultAbsError[i] = calcAbsError(exactValOfDerivate, resultsForEachExponent[i])
    end

    return resultsForEachExponent, resultAbsError
end
