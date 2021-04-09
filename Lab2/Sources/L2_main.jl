###############################################################################
#
#	@brief:  	Source code for laboratory list number 1.
#	@usage:	 	Expects that program julia is installed, and "seen".
#			 	To start program simply type: 
#			 	~$: julia L1_main.jl [numbers of tasks to show results for.
#									  Separated by space]
#	@usageExample: 	~$: julia L1_main.jl 4 2 3 6
#
###############################################################################


###############################################################################
#
#	Including files with specified for the tasks functions
#
###############################################################################
include("L2_T1.jl")
include("L2_T2.jl")
include("L2_T3.jl")
include("L2_T4.jl")
include("L2_T5.jl")
include("L2_T6.jl")

###############################################################################
#
#	@name: 	main
#	@brief:	allows
#	@param[in]: no direct parameters, although main uses ARGS, where ARGS are numbers of exercises
#	@param[out]: none
#	@usage:	predicted to used once during callout of the file L1_main.jl
#	@usageExample: ~$: julia L1_main.jl 1 2 3 
#
###############################################################################
function main()
	for arg in ARGS
		if 	arg == "1"			
			L2_T1()			

		elseif arg == "2"			
			L2_T2()
		
		elseif arg == "3"
			L2_T3()
		
		elseif arg == "4"
			L2_T4()

		elseif arg == "5"
			L2_T5()

		elseif arg == "6"
			L2_T6()

		else
			println("This argument: ", arg, " was not expected as an input")
		end
	end #for arg in ARGS
end # function main()


function L2_T1()
	desc("< Zad. 1 >")

	decoratorTableNaming_L2_T1()

	exactScalarProduct::Float64 = -1.00657107000000e-11

	vectorX_F32_Lab1 = Float32[2.718281828, -3.141592654,  1.414213562,  0.5772156649,  0.3010299957]
	vectorY_F32_Lab1 = Float32[1486.2497,    878366.9879,  -22.37492,    4773714.647,   0.000185049 ]
	vectorX_F64_Lab1 = Float64[2.718281828, -3.141592654,  1.414213562,  0.5772156649,  0.3010299957]
	vectorY_F64_Lab1 = Float64[1486.2497,    878366.9879,  -22.37492,    4773714.647,   0.000185049 ]

	vectorX_F32_Lab2 = Float32[2.718281828, -3.141592654,  1.414213562,  0.577215664,  0.301029995 ]
	vectorY_F32_Lab2 = Float32[1486.2497,    878366.9879,  -22.37492,    4773714.647,   0.000185049]
	vectorX_F64_Lab2 = Float64[2.718281828, -3.141592654,  1.414213562,  0.577215664,  0.301029995 ]
	vectorY_F64_Lab2 = Float64[1486.2497,    878366.9879,  -22.37492,    4773714.647,   0.000185049]

	vectorsF32_Lab1  = [vectorX_F32_Lab1, vectorY_F32_Lab1]
	vectorsF64_Lab1  = [vectorX_F64_Lab1, vectorY_F64_Lab1]

	vectorsF32_Lab2  = [vectorX_F32_Lab2, vectorY_F32_Lab2]
	vectorsF64_Lab2  = [vectorX_F64_Lab2, vectorY_F64_Lab2]

	println("Lab1:")
	prodOutcomeScalarProduct(cptForward, vectorsF32_Lab1, exactScalarProduct)
	prodOutcomeScalarProduct(cptBackward, vectorsF32_Lab1, exactScalarProduct)
	prodOutcomeScalarProduct(cptBiggestToSmallest, vectorsF32_Lab1, exactScalarProduct)
	prodOutcomeScalarProduct(cptSmallestToBiggest, vectorsF32_Lab1, exactScalarProduct)
	println("Lab2:")
	prodOutcomeScalarProduct(cptForward, vectorsF32_Lab2, exactScalarProduct)
	prodOutcomeScalarProduct(cptBackward, vectorsF32_Lab2, exactScalarProduct)
	prodOutcomeScalarProduct(cptBiggestToSmallest, vectorsF32_Lab2, exactScalarProduct)
	prodOutcomeScalarProduct(cptSmallestToBiggest, vectorsF32_Lab2, exactScalarProduct)
	
	println()
	
	println("Lab1:")
	prodOutcomeScalarProduct(cptForward, vectorsF64_Lab1, exactScalarProduct)
	prodOutcomeScalarProduct(cptBackward, vectorsF64_Lab1, exactScalarProduct)
	prodOutcomeScalarProduct(cptBiggestToSmallest, vectorsF64_Lab1, exactScalarProduct)
	prodOutcomeScalarProduct(cptSmallestToBiggest, vectorsF64_Lab1, exactScalarProduct)
	println("Lab2:")
	prodOutcomeScalarProduct(cptForward, vectorsF64_Lab2, exactScalarProduct)
	prodOutcomeScalarProduct(cptBackward, vectorsF64_Lab2, exactScalarProduct)
	prodOutcomeScalarProduct(cptBiggestToSmallest, vectorsF64_Lab2, exactScalarProduct)
	prodOutcomeScalarProduct(cptSmallestToBiggest, vectorsF64_Lab2, exactScalarProduct)

	desc("</ Zad. 1 >")
end

function L2_T2()
	desc("< Zad. 2 >")

	calcLimit()
	plotGraph()

	desc("</ Zad. 2 >")
end

function L2_T3()
	desc("< Zad. 3 >")

	vectMatrixCond = [1.0, 10.0, 1000.0, 10000000.0, 1000000000000.0, 10000000000000000.0]
	vectMatrixSize = [5, 10, 20]

	decoratorTableNaming_L2_T3()
	prodOutcomeLinearEquation("Hilb", "Gauss", vectMatrixSize, vectMatrixCond)
	println()
	prodOutcomeLinearEquation("Rand", "Gauss", vectMatrixSize, vectMatrixCond)
	println()
	prodOutcomeLinearEquation("Hilb", "Inv", vectMatrixSize, vectMatrixCond)
	println()
	prodOutcomeLinearEquation("Rand", "Inv", vectMatrixSize, vectMatrixCond)

	desc("</ Zad. 3 >")
end

function L2_T4()
	desc("< Zad. 4 >")

	P	=  [1, -210.0, 20615.0,-1256850.0,
			53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
			11310276995381.0, -135585182899530.0,
			1307535010540395.0,     -10142299865511450.0,
			63030812099294896.0,     -311333643161390640.0,
			1206647803780373360.0,     -3599979517947607200.0,
			8037811822645051776.0,      -12870931245150988800.0,
			13803759753640704000.0,      -8752948036761600000.0,
			2432902008176640000.0
		   ]

	println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
	println("k","\t\t","P:Zk", "\t\t\t\t", "p:Zk",
                "\t\t\t\t","P:Zk - k", "\t\t\t", "p:Zk - k", 
                "\t\t\t", "P(P:Zk)", "\t\t\t", "p(p:Zk)")
	println("------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
	prodOutcomeRoots(P)

	Pmod	=  [1, -210.0-2^(-23), 20615.0,-1256850.0,
			53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
			11310276995381.0, -135585182899530.0,
			1307535010540395.0,     -10142299865511450.0,
			63030812099294896.0,     -311333643161390640.0,
			1206647803780373360.0,     -3599979517947607200.0,
			8037811822645051776.0,      -12870931245150988800.0,
			13803759753640704000.0,      -8752948036761600000.0,
			2432902008176640000.0
		   ]
	println("")
	prodOutcomeRoots(Pmod)
	
	desc("</ Zad. 4 >")
end

function L2_T5()
	desc("< Zad. 5 >")

	println("64bit")
	recursion(40,3.0,0.01)
	println("64bit z obcieciem")
	recursionWithTrimm(40,11,3.0,0.01)

	println("32bit")
	recursion32(Int64(40), Float32(3.0), Float32(0.01))
	println("32bit z obcieciem")
	recursionWithTrimm32(Int64(40), Int64(11), Float32(3.0), Float32(0.01))

	desc("</ Zad. 5 >")
end

function L2_T6()
	desc("< Zad. 6 >")

	#1.
	c = -2.0
	x_0 = 1.0
	#recurEquation(c, x_0)

	#2.
	c = -2.0
	x_0 = 2.0
	#recurEquation(c, x_0)

	#3.
	c = -2.0
	x_0 = 1.99999999999999
	#recurEquation(c, x_0)

	#4.
	c = -1.0
	x_0 = 1.0
	#recurEquation(c, x_0)

	#5.
	c = -1.0
	x_0 = -1.0
	#recurEquation(c, x_0)

	#6.
	c = -1.0
	x_0 = 0.75
	#recurEquation(c, x_0)

	#7.
	c = -1.0
	x_0 = 0.25
	recurEquation(c, x_0)
	
	desc("</ Zad. 6 >")
end

function desc(title)
	println()
	println("*********** ", title, " ***********")
	println()
end

main()
