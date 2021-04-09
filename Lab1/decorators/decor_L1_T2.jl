
function decoratorTableNaming_L1_T2()
	#expects that there will be used 64 bit value representation
	println(" ----------------------------------------------------------------------------------- ")
    println("|", " ", "TYPE", "\t      ", "NAME", "\t       ", "VALUE", "\t\t      ", "NAME", "\t      ", "VALUE", "\t    ", "|")
	println(" ----------------------------------------------------------------------------------- ")
end


function decoratorNonFloat_T2()
	println("-------------------wrong-input-expect-arguments-of-Float-type------------------------")
end

function decoratorKahanTest(kahanMacheps, juliaMacheps)
    print(eltype(kahanMacheps), "  ", "kachanMacheps: ", kahanMacheps) 
    
    argType = eltype(kahanMacheps)

    if Float16 == argType
        print("\t\t")
    elseif Float32 == argType
        print("\t\t")
    elseif Float64 == argType
        print("\t")
    end
    
    print("macheps julia: ", juliaMacheps)

    println()
end