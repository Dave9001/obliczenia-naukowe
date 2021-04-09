
function decoratorTableNaming_L1_T5()
	#expects that there will be used 64 bit value representation
	println(" ----------------------------------------------------------------------------------- ")
    println("|", " ", "TYPE", "\t        ", "NAME", "\t         ", "CALC. SCALAR PROD.", "\t    ", "ABS DIST TO EXACT VALUE",  " |")
	println(" ----------------------------------------------------------------------------------- ")
end

function decoratorWrongVectorLength()
    println("Vector have to be the same length/dimmension")
end

function decoratorInputScalarProductType(vectors, cptFunction)
    algorithmName = replace(string(cptFunction), "cpt" => "")

    print(eltype(vectors[1]), "\t ", algorithmName, "    ")

    if length(algorithmName) < 9
        print("\t      ")
    end
end

function  decoratorWrongVectorDimension()
        println("Vector cannot be smaller than wanted dimension")
end

function decoratorScalarProductCmp(scalarProduct, exactScalarProduct)

    strScalarProduct = string(scalarProduct)

    print(scalarProduct)
    if length(strScalarProduct) <= 10
        print("\t")
    end

    if length(strScalarProduct) <= 8
        print("\t")
    end

    absDistToExactScalarProduct::Float64 = abs(Float64(exactScalarProduct) - Float64(scalarProduct))

    println("\t     ", absDistToExactScalarProduct)
end