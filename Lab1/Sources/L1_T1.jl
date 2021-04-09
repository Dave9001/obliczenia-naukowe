

include("../decorators/decor_L1_T1.jl")

function iterativeCalcEpsilon( variableToCalc )
	epsilon = variableToCalc
	macheps = epsilon

	if true == isStandardNumType(epsilon)
		# represents minimal (right) shift of bits in type by one bit
		minBitMove::Int64 = 2

		currentEpsilon = epsilon
		previousEpsilon = epsilon
		step::Int64 = minBitMove

		while step != 0
			previousEpsilon = currentEpsilon
			currentEpsilon = currentEpsilon / step

			if currentEpsilon == 0
				if previousEpsilon / minBitMove != 0
					step = minBitMove
					currentEpsilon = previousEpsilon / step
				else
					step = 0 #instead of break
				end
			else
				if 1 + currentEpsilon > 1
					macheps = currentEpsilon
				elseif 1 + previousEpsilon > 1
					step = minBitMove
					currentEpsilon = previousEpsilon / step
					
					if 1 + currentEpsilon > 1
						macheps = currentEpsilon
					end
				end
				step = step * minBitMove	#speeds up calc.
			end #if currentEpsilon == 0
		end #while step != 0
		epsilon = previousEpsilon #previousEps. bc. currentEps. is equal to 0
	else
		#nothing to be done this even is hendled by outputFormater()
	end	#if true == isStandardNumType(variableToCalc)
	#printIterative(epsilon, macheps)
	return epsilon, macheps
end

function prodOutcomeIterative(variableToCalc)
	if false == isStandardNumType( eltype(variableToCalc) )
		decoratorNonFloat(variableToCalc)
	else
		# initialize given type to 1 allows to ommit
		# substraction part of calculations
		variableToCalc  = assignToOne(variableToCalc)

		epsilon, macheps = iterativeCalcEpsilon(variableToCalc)
		decoratorIterativeEpsilon(epsilon)
		decoratorIterativeMacheps(macheps)

		max = iterativeCalcMax(variableToCalc)
		decoratorIterativeMax(max)

		println()
	end
end

function iterativeCalcMax(variableToCalc)
	maxValOfType = assignToZero(variableToCalc)
	nextVal = nextfloat(maxValOfType)
	round = 0

	while true == isRepresentableInType(nextVal)
		maxValOfType = nextVal
		if true == isRepresentableInType(maxValOfType + nextVal)
			nextVal = maxValOfType + nextfloat(nextVal)
		else
			round +=1
			nextVal = maxValOfType + eps(nextVal) * vectMantissa(variableToCalc, round)
			#printOutMaxCalcMech(variableToCalc, nextVal)
		end
	end

	return maxValOfType
end

function printOutMaxCalcMech(variableToCalc, nextVal)
	println(eltype(variableToCalc), "\t", bitstring(nextVal))
end

function vectMantissa(variableToCalc, round)
	mantissa = precision(variableToCalc) - 1 - round

	if mantissa < 0
		vect = 1
	else
		vect = 2^(mantissa)
	end
	
	return vect
end

function isRepresentableInType(nextVal)
	argType = eltype(nextVal)
	if  true != isinf(argType(nextVal)) &&
		true != isnan(argType(nextVal))
		#then this addition can be represent and not been seen as Inf
		return true
	else
		return false
	end
end

function isStandardNumType(variableToCheck)
	argType = eltype(variableToCheck)
	if  argType == Float16 ||
		argType == Float32 ||
		argType == Float64
		
		return true
	else
		return false
	end
end

function assignToOne(variableToCalc)
	argType = eltype(variableToCalc)

	if argType == Float64
		retValue = parse(Float64, "1.0")
	elseif argType == Float32
		#retValue = 1.0f32 # this did not work for 1.0f64
		retValue = parse(Float32, "1.0")
	elseif argType == Float16
		retValue = parse(Float16, "1.0")
	else
		retValue = parse(Float64, "1.0")
	end
	
	return retValue
	
end

function assignToZero(variableToCalc)
	argType = eltype(variableToCalc)

	if argType == Float64
		retValue = parse(Float64, "0.0")
	elseif argType == Float32
		#retValue = 1.0f32 # this did not work for 1.0f64
		retValue = parse(Float32, "0.0")
	elseif argType == Float16
		retValue = parse(Float16, "0.0")
	else
		retValue = parse(Float64, "0.0")
	end
	
	return retValue
	
end

function prodOutcomeJuliaBuildIn(variableToCalc)
	argType = eltype(variableToCalc)

	if false == isStandardNumType(argType)
		decoratorJuliaBuildInNotSupp(variableToCalc)
	else
		eta = nextfloat(argType(0.0))
		decoratorBuildInEta(eta)

		epsilon = eps(argType)
		decoratorBuildInEpsilon(epsilon)

		max = prevfloat(typemax(argType))
		decratorBuildInMax(max)

		println()
	end
end

function printFloatHeader()
	print("\n")
	
	println("/* The difference between 1 and the least value greater than 1 that is")
	println("   representable in the given floating point type, b**1-p.  */")
	println("#define FLT_EPSILON	1.19209289550781250000000000000000000e-7F")
	println("#define DBL_EPSILON	((double)2.22044604925031308084726333618164062e-16L")
	println("#define LDBL_EPSILON	1.08420217248550443400745280086994171e-19L")
	
	println()

	println("/* Maximum representable finite floating-point number,")
	println()
	println("(1 - b**-p) * b**emax")
	println("*/")
	println("#define FLT_MAX		3.40282346638528859811704183484516925e+38F_")
	println("#define DBL_MAX		((double)1.79769313486231570814527423731704357e+308L")
	println("#define LDBL_MAX	1.18973149535723176502126385303097021e+4932L")
end

function printFloatHeaderToOutput(variableToCalc)
	argType = eltype(variableToCalc)

	if false == isStandardNumType(argType)
		#nothing to be done
	else
		epsilon = 0.0
		if argType == Float64
			epsilon = 2.22044604925031308084726333618164062e-16
			max = 1.79769313486231570814527423731704357e+308
		elseif argType == Float32
			epsilon = Float32(1.19209289550781250000000000000000000e-7)
			max = Float32(3.40282346638528859811704183484516925e+38)
		else
			#nothing to be done
		end

		if argType == Float64 || argType == Float32

			binaryStr = bitstring(epsilon)
			intBin = parse(Int, binaryStr, base = 2)
			hexStr = string(intBin, base = 16)

			print("Float.h:", "\t\t\t\t")
			print("", argType, " macheps: ", epsilon)
			
			if argType == Float64
				print("  0x", hexStr, "\t", "Float.h", "   ", "max:  ", max)
			else# argType == Float32
				print("\t\t0x", hexStr, "\t\t", "Float.h", "   ", "max:  ", max)
			end

			binaryStr = bitstring(max)
			intBin = parse(Int, binaryStr, base = 2)
			hexStr = string(intBin, base = 16)

			if argType == Float64
				print("   0x", hexStr)
			else# argType == Float32
				print("\t\t 0x", hexStr)
			end

		else
			print("-------------------------------------------------------------------Float.h-",argType,"-----not-supported-----------------------------------------------------------------")
		end
		println()
	end
end

