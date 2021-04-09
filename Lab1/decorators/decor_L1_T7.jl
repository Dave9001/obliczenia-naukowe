
function decoratorCompareDerivateCalc(derivativeForEachExponent, derivativeAbsError)

    println("   h","\t\t  ", "Approximation", "\t\t", "Abs(f'(x) - ~f'(x))", "\t\t\t    ", "bits(Approximation)", "\n")

    lenArgs = length(derivativeAbsError)
    exponent = 0
    for i = 1:lenArgs
        print("h: 2^(-", exponent, ")", "\t", derivativeForEachExponent[i])
        print("\t")
        if 16 > length(string(derivativeForEachExponent[i]))
            print("\t" )
            if 8 > length(string(derivativeForEachExponent[i]))
                print("\t")
            end
        end
        println(derivativeAbsError[i], "\t", bitstring(derivativeForEachExponent[i]))
        exponent += 1
    end
    
end