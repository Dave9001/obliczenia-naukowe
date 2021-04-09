
include("../decorators/decor_L1_T3.jl")



function prodOutcomeDistributionInRange(minRange::Float64, maxRange::Float64)
    precise = false
    delta, deltaIsKnown, exponent = calcDistributionInRange(minRange, maxRange, precise)

    decoratorDistributionInRange(minRange, maxRange, delta, deltaIsKnown, exponent)

end

function calcDistributionInRange(minRange::Float64, maxRange::Float64, precise::Bool)
    exponent::Int64 = calcExponentForF64() - 1 #-1 bc. we enter next loop with incrementation first
    delta::Float64 = 2.0^(exponent)
    maxExponent = calcMaxExponentForF64()

    deltaIsKnown::Bool = false
    
    #starting from the lowest possible exponent
    while false == deltaIsKnown && exponent < maxExponent
        exponent += 1

        delta = 2.0^Float64(exponent)
        deltaIsKnown = distributionForRange(minRange, maxRange, delta, precise)
    end

    return delta, deltaIsKnown, exponent
end

function distributionForRange(minRange::Float64, maxRange::Float64, delta::Float64, preciseCheck::Bool)
    calcRepresent::Float64 = minRange
    iterator::UInt64 = 1

    prevCalcRepresent = calcRepresent
    calcRepresent = minRange + iterator * delta

    success::Bool = true

    while calcRepresent < maxRange
        if calcRepresent != nextfloat(prevCalcRepresent)  #   prevCalcRepresent + eps(  prevCalcRepresent) # nextfloat(  prevCalcRepresent) ==   prevCalcRepresent + eps(  prevCalcRepresent) is the next representable value
            success = false
            break
        end

        if true == preciseCheck
            iterator += 1
            prevCalcRepresent = calcRepresent
        else
            iterator *= 2^22 + 1
            prevCalcRepresent = minRange + (iterator-1) * delta
        end
        
        calcRepresent = minRange + iterator * delta
    end

    return success
end

function calcExponentForF64()
    numBitsInByte = 8
    signSize = 1
    exponentSize = (sizeof(Float64) * numBitsInByte) - precision(Float64) - signSize
   
    exponent = -1 * (2^exponentSize)

    return exponent
end


function calcMaxExponentForF64()
    signSize = 1
    numBitsInByte = 8
    exponentSize = (sizeof(Float64) * numBitsInByte) - precision(Float64) - signSize
   
    maxExponent = 2^exponentSize

    return maxExponent
end