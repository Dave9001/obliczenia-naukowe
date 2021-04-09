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
include("L1_T1.jl")
include("L1_T2.jl")
include("L1_T3.jl")
include("L1_T4.jl")
include("L1_T5.jl")
include("L1_T6.jl")
include("L1_T7.jl")

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
		if 	   arg == "1"			
			L1_T1()			

		elseif arg == "2"			
			L1_T2()
		
		elseif arg == "3"
			L1_T3()
		
		elseif arg == "4"
			L1_T4()

		elseif arg == "5"
			L1_T5()

		elseif arg == "6"
			L1_T6()

		elseif arg == "7"
			L1_T7()

		else
			println("This argument: ", arg, " was not expected as an input")
		end
	end #for arg in ARGS
end # function main()


function L1_T1()
	desc("< Zad. 1 >")

	decoratorTableNaming_L1_T1()

	F64::Float64 = 1.0
	prodOutcomeIterative(F64)
	prodOutcomeJuliaBuildIn(F64)
	printFloatHeaderToOutput(F64)
	println()

	F32::Float32 = 1.0
	prodOutcomeIterative(F32)
	prodOutcomeJuliaBuildIn(F32)
	printFloatHeaderToOutput(F32)
	println()

	F16::Float16 = 1.0
	prodOutcomeIterative(F16)
	prodOutcomeJuliaBuildIn(F16)
	printFloatHeaderToOutput(F16)
	println()

	printFloatHeader()

	desc("</ Zad. 1 >")
end

function L1_T2()
	desc("< Zad. 2 >")

	decoratorTableNaming_L1_T2()

	prodOutcomeKahanTest(Float16)
	prodOutcomeKahanTest(Float32)
	prodOutcomeKahanTest(Float64)

	desc("</ Zad. 2 >")
end

function L1_T3()
	desc("< Zad. 3 >")

	decoratorTableNaming_L1_T3()

	prodOutcomeDistributionInRange(0.5, 1.0)
	prodOutcomeDistributionInRange(1.0, 2.0)
	prodOutcomeDistributionInRange(2.0, 4.0)
	prodOutcomeDistributionInRange(8.0, 10.0)

	desc("</ Zad. 3 >")
end

function L1_T4()
	desc("< Zad. 4 >")

	decoratorTableNaming_L1_T4()

	range = [nextfloat(1.0), prevfloat(2.0)]
	prodOutcomeValueThatBadlyCalculates(range)

	#upper limit(1.0) is known from prev. computing:
	#in range 1.0 - 2.0 is at least one number that works poorly in calculations 

	#if "the smallest" number means the biggest negative,
	#then it's in range (-Inf64, 1.0]
	rangeForTheBigestMin = [nextfloat(-Inf64), 1.0]
	prodOutcomeValueThatBadlyCalculates(rangeForTheBigestMin)

	#if "the smallest" number means closest to zero, then we know it allraedy
	#(if it was found in (1.0, 2.0) [and it was]),
	#if not it should be in range (0.0, 1.0]
	rangeForMin = [nextfloat(0.0), 1.0]
	prodOutcomeValueThatBadlyCalculates(rangeForMin)

	desc("</ Zad. 4 >")
end

function L1_T5()
	desc("< Zad. 5 >")

	decoratorTableNaming_L1_T5()

	vectorX_F32 = Float32[2.718281828, -3.141592654,  1.414213562,  0.5772156649,  0.3010299957]
	vectorY_F32 = Float32[1486.2497,    878366.9879,  -22.37492,    4773714.647,   0.000185049 ]
	
	vectorX_F64 = Float64[2.718281828, -3.141592654,  1.414213562,  0.5772156649,  0.3010299957]
	vectorY_F64 = Float64[1486.2497,    878366.9879,  -22.37492,    4773714.647,   0.000185049 ]

	exactScalarProduct::Float64 = -1.00657107000000e-11

	vectorsF32 = [vectorX_F32, vectorY_F32]
	prodOutcomeScalarProduct(cptForward, vectorsF32, exactScalarProduct)
	prodOutcomeScalarProduct(cptBackward, vectorsF32, exactScalarProduct)
	prodOutcomeScalarProduct(cptBiggestToSmallest, vectorsF32, exactScalarProduct)
	prodOutcomeScalarProduct(cptSmallestToBiggest, vectorsF32, exactScalarProduct)

	println()

	vectorsF64 = [vectorX_F64, vectorY_F64]
	prodOutcomeScalarProduct(cptForward, vectorsF64, exactScalarProduct)
	prodOutcomeScalarProduct(cptBackward, vectorsF64, exactScalarProduct)
	prodOutcomeScalarProduct(cptBiggestToSmallest, vectorsF64, exactScalarProduct)
	prodOutcomeScalarProduct(cptSmallestToBiggest, vectorsF64, exactScalarProduct)

	desc("</ Zad. 5 >")
end

function L1_T6()
	desc("< Zad. 6 >")

	prodOutcomeFunctionsDifference(UInt64(13))

	desc("</ Zad. 6 >")
end

function L1_T7()
	desc("< Zad. 7 >")

	prodOutcomeDerivativeApproximation()

	#z numerycznego punktu widzenia pryzbliza sie pochodna za pomoca ilorazow roznicowych 
	#f'(x0) = lim h->0 (f(x0+h)-f(x0))/h)
	#w zadaniu robimy to przyblizajac

	#jest tabelka i tlumaczycie dklatego tak sie zadzialo
	#tu jest pewne bardzo niebezpieczne zjawisko, ktore caly czasy powtarzalem
	# omowione w pt na cwiczeniach
	# na wykladzie x+y = x jest szokujace ale nie niebezpieczne
	desc("</ Zad. 7 >")
end


function desc(title)
	println()
	println("*********** ", title, " ***********")
	println()
end

main()
