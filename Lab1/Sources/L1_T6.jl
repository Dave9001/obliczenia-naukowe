


include("../decorators/decor_L1_T6.jl")

function g(x::Float64)
    pow2X = x^2
    result = pow2X / (sqrt(pow2X + 1.0) + 1.0)
    return result
end

function f(x::Float64)
    pow2X = x^2
    result = sqrt(pow2X + 1.0) - 1.0
    return result
end

function prodOutcomeFunctionsDifference(domainSize::UInt64)
    domain, gResults, fResults = calcFunctions(domainSize)
    absDistOfResults = calcAbsDistOfResults(gResults, fResults)

    decoratorFunctions(domain, gResults, fResults)
    decoratorAbsDistance(absDistOfResults)
    decoratorBitFunctions(domain, gResults, fResults)
end

function calcFunctions(domainSize::UInt64)
    domain = fillFunctionDomainPow8(domainSize)

    gResults = cptFunction(g, domain)
    fResults = cptFunction(f, domain)

    return domain, gResults, fResults
end

function calcAbsDistOfResults(gResults, fResults)
    lenResults = length(gResults)
    absDist = Array{Float64}(undef, lenResults)

    for i = 1:lenResults
        absDist[i] = abs(gResults[i] - fResults[i])
    end
    return absDist
end

function fillFunctionDomainPow8(domainSize::UInt64)
    arrayOfXValues = Array{Float64}(undef, domainSize)

    power::Int64 = -1
    lenArrayOfXValues = length(arrayOfXValues)
    for i = 1:lenArrayOfXValues
        arrayOfXValues[i] = 8.0^power
        power -= 1
    end

    return arrayOfXValues
end


function cptFunction(funct, domain)
    results = Array{Float64}(undef, length(domain))

    lenDomain = length(domain)
    for i = 1:lenDomain
        results[i] = funct(domain[i])
    end
    return results
end


