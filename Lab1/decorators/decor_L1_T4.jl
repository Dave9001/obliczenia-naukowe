

function decoratorTableNaming_L1_T4()

    println(" ---------------------------------------------------------------------------------------------------")
    println("| ", "TYPE", "\t\t\t   ", "RANGE", "\t\t\t      ", "FAILED VAL.", "\t      ", "MEMDUMP","       |")
    println(" ---------------------------------------------------------------------------------------------------")
end

function decoratorValueThatBadlyCalculates(foundCrashingValue::Bool, crashingValue, sizeSorter, range)
    minRange, maxRange = sizeSorter(range[1], range[2])

    print(eltype(minRange), "   ", "[", minRange, ", ", maxRange, "]")

    rangeStr = string("[", minRange, ", ", maxRange, "]")

    if length(rangeStr) < 37 && length(rangeStr) >= 33
        print("\t ")
    elseif length(rangeStr) <= 32 && length(rangeStr) >= 21
        print("\t  ")
    elseif length(rangeStr) <= 20 && length(rangeStr) >= 13
        print("\t\t\t ")
    elseif length(rangeStr) <= 12
        print("\t\t\t\t ")
    end

    if true == foundCrashingValue
        binaryStr = bitstring(crashingValue)
        intBin = parse(UInt64, binaryStr, base = 2)
        hexStr = string(intBin, base = 16)

        print("\t", crashingValue)

        rangeCrashingVal = string(crashingValue)
        if length(rangeCrashingVal) < 10
            print("\t")
        elseif length(rangeCrashingVal) < 3
            print("\t\t")
        end

        print("\t", "0x", hexStr)
    else
        print("\t", "value that crash calculations wasn't found in given range")

    end
  
    println()


end 