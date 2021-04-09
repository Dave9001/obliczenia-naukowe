


include("../decorators/decor_L1_T4.jl")


function prodOutcomeValueThatBadlyCalculates(range)
    
    foundCrashingValue, valueThatBadlyCalculates = computeValueThatBadlyCalculates(range)

    decoratorValueThatBadlyCalculates(foundCrashingValue, valueThatBadlyCalculates, sizeSorter, range)
end

function computeValueThatBadlyCalculates(range)
    minRange, maxRange = sizeSorter(range[1] ,range[2])
    foundCrashingValue = false 

    currentValue = minRange
    while currentValue <= maxRange
         if false == isMultiplicInverseIrrelevant(currentValue)
            foundCrashingValue = true
            break
         end
        currentValue = nextfloat(currentValue)
    end
    return foundCrashingValue, currentValue
end

function isMultiplicInverseIrrelevant(x::Float64)
    if x == 0.0
        return false
    end
    
    backFromMultipInverse::Float64 = (1.0 / x) * x
    if backFromMultipInverse == Float64(1.0)
        isIrrelevant = true
    else
        isIrrelevant = false
    end
    
    return isIrrelevant
end

function sizeSorter(val1, val2)
    min = val1
    max = min

    if val1 > val2
        min = val2
        max = val1
    else
        min = val1
        max = val2
    end

    return min, max
end
