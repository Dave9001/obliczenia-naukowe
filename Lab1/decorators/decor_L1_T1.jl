

function decoratorTableNaming_L1_T1()
	#expects that there will be used 64 bit value representation
	println(" -------------------------------------------------------------------------------------------------------------------------------------------------------------------")
	println("|", "\t\t   ", "ETA", "\t\t       ","|", "\t\t\t       ", "MACHEPS", "\t\t\t    ", "|", "\t\t\t\t      ", "MAX", "\t\t\t    ", "|")
	
	println(" -------------------------------------------------------------------------------------------------------------------------------------------------------------------")
	println("| TYPE  ", "  NAME ","\t","    VALUE ","","    MEMDUMP ","\t", "  TYPE  ", "  NAME ","\t\t","VALUE ","\t\t","    MEMDUMP\t  ", "\t", "  TYPE  ", "  NAME ","\t\t","VALUE ","\t\t","       MEMDUMP      |")
	println(" -------------------------------------------------------------------------------------------------------------------------------------------------------------------")
end

function decoratorBuildInEpsilon(epsilon)
	binaryStr = bitstring(epsilon)
	intBin = parse(UInt, binaryStr, base = 2)
	hexStr = string(intBin, base = 16)

	argType = eltype(epsilon)

	print(argType, " epsilon: ", epsilon)
		
	if argType == Float64
		print("  0x", hexStr)
	elseif argType == Float32
		print("\t\t0x", hexStr)
	else# argType == Float16
		print("\t\t0x", hexStr)
	end
end

function decoratorBuildInEta(eta)
	binaryStr = bitstring(eta)
	intBin = parse(UInt, binaryStr, base = 2)
	hexStr = string(intBin, base = 16)

	print("Julia:", "\t", "nextfloat", " ")
	print(eta, "\t", "0x" , hexStr, "\t")
end

function decoratorJuliaBuildInNotSupp(variableToCalc)
	argType = eltype(variableToCalc)
	print("--------------------------------------Julia-build-in-",argType,"-----not-supported----------------------------")
end

function decoratorIterativeEpsilon(epsilon)
	
	binaryStr = bitstring(epsilon)
	intBin = parse(UInt, binaryStr, base = 2)
	hexStr = string(intBin, base = 16)

	epsilonType = eltype(epsilon)
	print(epsilonType, " ",  "eta:", "\t  ",  epsilon, "\t0x", hexStr)
end

function decoratorNonFloat(variableToCalc)
	argType = eltype(variableToCalc)
	if 	argType == Int64 ||
		argType == Int32 ||
		argType == Int16 ||
		argType == Int8 ||
		argType == UInt64 ||
		argType == UInt32 ||
		argType == UInt16 ||
		argType == UInt8

		println("    ", "1", "\t\t0x01", "\t\t\t", argType, "  macheps: ", " ", "1", "\t\t\t", "0x01")
	else
		println("-------------------wrong-input-expect-arguments-of-Float-type------------------------")
	end
end

function decoratorIterativeMacheps(macheps)
	binaryStr = bitstring(macheps)
	intBin = parse(UInt, binaryStr, base = 2)
	hexStr = string(intBin, base = 16)
	
	machepsType = eltype(macheps)
	print(" \t", machepsType, " ", "macheps: ", macheps, "  ")

	if machepsType == Float32
		print("\t\t")
	elseif 	machepsType == Float16
		print("\t\t")
	end

		print("0x", hexStr)
end

function decoratorIterativeMax(max)
	binaryStr = bitstring(max)
	intBin = parse(UInt, binaryStr, base = 2)
	hexStr = string(intBin, base = 16)
	
	maxType = eltype(max)
	
	if maxType == Float64
		print("\t")
		print(maxType, "   ", "max:  ", max, "   ")
	elseif maxType == Float32
		print("\t\t")
		print(maxType, "   ", "max:  ", max, "\t         ")
	elseif 	maxType == Float16
		print("\t\t\t")
		print(maxType, "   ", "max:  ", max,  "\t\t         ")
	end
	
		print("0x", hexStr)
end

function decratorBuildInMax(max)
	binaryStr = bitstring(max)
	intBin = parse(UInt, binaryStr, base = 2)
	hexStr = string(intBin, base = 16)

	maxType = eltype(max)

	if maxType == Float64
		print("\t")
	elseif maxType == Float32
		print("\t\t")
	elseif 	maxType == Float16
		print("\t\t\t")
	end

	print("", "Julia:", "\t  ", "max:", "  ")

	if maxType == Float64
		print(max, "\t ", "0x" , hexStr, "\t")
	elseif maxType == Float32
		print(max, "\t\t ", "0x" , hexStr, "\t")
	elseif 	maxType == Float16
		print(max, "\t\t\t ", "0x" , hexStr, "\t")
	end

	
end

