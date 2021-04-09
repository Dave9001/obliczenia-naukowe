

function decoratorTableNaming_L1_T3()

    println(" ----------------------------------------------------------------------------------")
    println("| ", "TYPE", "\t     ", "RANGE", "\t\t ", "DELTA", "\t\t\t", "MEMDUMP", "\t\t ", "EXPONENT", "  |")
    println(" ----------------------------------------------------------------------------------")
end


function decoratorDistributionInRange(minRange, maxRange, delta, deltaIsKnown, exponent)
    print(eltype(minRange), "   ", "[", minRange, ", ", maxRange, "]")
    
    if true == deltaIsKnown
        if exponent < 1
            binaryStr = bitstring(delta)
            intBin = parse(UInt64, binaryStr, base = 2)
            hexStr = string(intBin, base = 16)

            print("\t", delta, "\t   ", "0x", hexStr, "\t   ", exponent)
        else
            print("\t", "delta is not constant in that range")
        end
    else
        print("not found")
    end

    println()
end

