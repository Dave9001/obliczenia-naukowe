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
include("L3_T1.jl")
include("L3_T2.jl")
include("L3_T3.jl")
include("L3_T4.jl")
include("L3_T5.jl")
include("L3_T6.jl")

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
			L3_T1()			

		elseif arg == "2"			
			L3_T2()
		
		elseif arg == "3"
			L3_T3()
		
		elseif arg == "4"
			L3_T4()

		elseif arg == "5"
			L3_T5()

		elseif arg == "6"
			L3_T6()

		else
			println("This argument: ", arg, " was not expected as an input")
		end
	end #for arg in ARGS
end # function main()


function L3_T1()
	desc("< Zad. 1 >")

	#f(x) = x^3 - 4x^2 + 4x#-6x^3+2x^2-x#3x#x^2.0-2.0
	f(x) = exp(x) - 3
	r, v, it, err = mbisekcji(f,-10.0,10.0,2.0^-53,2.0^-53)
	println("r: ", r,"\n", "v: ", v, "\n", "it: ", it, "\n", "err: ", err, "\n")

	desc("</ Zad. 1 >")
end

function L3_T2()
	desc("< Zad. 2 >")

	f(x) = x^3 - 4x^2 + 4x
	pf(x) = 3x^2 - 8x + 4
	r, v, it, err = mstycznych(f, pf, 3.0, 2.0^-53, 2.0^-53, 100)
	#println("r: ", r,"\n", "v: ", v, "\n", "it: ", it, "\n", "err: ", err, "\n")

	desc("</ Zad. 2 >")
end

function L3_T3()
	desc("< Zad. 3 >")

	#f(x) = 3x#exp(x)*log(1+exp(-x))#x^2.0 - 2.0
	f(x) = x^3 - 4x^2 + 4x
	r, v, it, err = msiecznych(f, -0.5, 0.1, 2.0^-53, 2.0^-53, 10000)
	#println("r: ", r,"\n", "v: ", v, "\n", "it: ", it, "\n", "err: ", err, "\n")
	
	desc("</ Zad. 3 >")
end

function L3_T4()
	desc("< Zad. 4 >")
	
	f(x) = sin(x) - ((1.0 / 2.0) * x)^2.0
	pf(x) = cos(x) - (x / 2.0)
	maxit = 1000000

	x0 = 1.5; x1 = 2.0
	delta = (1.0 / 2.0) * 10.0^-5.0
	epsilon = delta
	args = [f, x0, x1, delta, epsilon, pf, maxit]
	printFunctionOutput(mbisekcji, args)

	x0 = 1.5;
	delta = (1.0 / 2.0) * 10.0^-5.0
	epsilon = delta
	args = [f, x0, x1, delta, epsilon, pf, maxit]
	printFunctionOutput(mstycznych, args)

	x0 = 1.0; x1 = 2.0
	delta = (1.0 / 2.0) * 10.0^-5.0
	epsilon = delta
	args = [f, x0, x1, delta, epsilon, pf, maxit]
	printFunctionOutput(msiecznych, args)

	desc("</ Zad. 4 >")
end

function L3_T5()
	desc("< Zad. 5 >")

	g(x) = 3x
	h(x) = exp(x)
	f(x) = g(x) - h(x)
	pf(x) = exp(x) - 3
		
	x0 = 0.0; x1 = 2.0
	delta =  10.0^-53.0
	epsilon = delta
	r, v, it, err = mbisekcji(pf, x0, x1, delta, epsilon)

	pf_r = r
	minus_Inf = floatmax(Float64) * (-1.0)
	plus_Inf  = floatmax(Float64) / 2^2

	x0 = minus_Inf; x1 = pf_r
	delta =  10.0^-4.0
	epsilon = delta

	args = [f, x0, x1, delta, epsilon, pf, 0]
	printFunctionOutput(mbisekcji, args)

	x0 = pf_r; x1 = plus_Inf
	delta =  10.0^-4.0
	epsilon = delta

	args = [f, x0, x1, delta, epsilon, pf, 0]
	printFunctionOutput(mbisekcji, args)

	desc("</ Zad. 5 >")
end

function L3_T6()
	desc("< Zad. 6 >")
	
	maxit = 1000000

	println("f1(x)  =  exp(1.0 - x) - 1.0")
	f1(x)  =  exp(1.0 - x) - 1.0
	pf1(x) = -exp(1.0 - x)

	x0 = 0.9; x1 = 2.0
	delta = 10.0^-5.0
	epsilon = delta
	args = [f1, x0, x1, delta, epsilon, pf1, maxit]
	printFunctionOutput(mbisekcji, args)

	x0 = 0.9;
	delta = 10.0^-5.0
	epsilon = delta
	args = [f1, x0, x1, delta, epsilon, pf1, maxit]
	printFunctionOutput(mstycznych, args)

	x0 = 0.9; x1 = 1.4
	delta = 10.0^-5.0
	epsilon = delta
	args = [f1, x0, x1, delta, epsilon, pf1, maxit]
	printFunctionOutput(msiecznych, args)

	println("f2(x)  =  exp(-x) * x")
	f2(x)  =  exp(-x) * x
	pf2(x) = -exp(-x) * (x - 1.0)

	x0 = -1.0; x1 = 3.0
	delta = 10.0^-5.0
	epsilon = delta
	args = [f2, x0, x1, delta, epsilon, pf2, maxit]
	printFunctionOutput(mbisekcji, args)

	x0 = -1.0;
	delta =10.0^-5.0
	epsilon = delta
	args = [f2, x0, x1, delta, epsilon, pf2, maxit]
	printFunctionOutput(mstycznych, args)

	x0 = 0.0; x1 = 1.0
	delta = 10.0^-5.0
	epsilon = delta
	args = [f2, x0, x1, delta, epsilon, pf2, maxit]
	printFunctionOutput(msiecznych, args)

	println("sprawdzic f1 x0 = 1.1")
	x0 = 1.1;
	delta = 10.0^-5.0
	epsilon = delta
	args = [f1, x0, x1, delta, epsilon, pf1, maxit]
	printFunctionOutput(mstycznych, args)

	println("sprawdzic f1 x0 = 7.0")
	x0 = 7.0
	delta = 10.0^-5.0
	epsilon = delta
	args = [f1, x0, x1, delta, epsilon, pf1, maxit]
	printFunctionOutput(mstycznych, args)

	println("sprawdzic f1 x0 = 1000.0")
	x0 = 1000.0
	delta = 10.0^-5.0
	epsilon = delta
	args = [f1, x0, x1, delta, epsilon, pf1, maxit]
	printFunctionOutput(mstycznych, args)

	println("sprawdzic f1 x0 = 10.0^20")
	x0 = 10.0^20
	delta = 10.0^-5.0
	epsilon = delta
	args = [f1, x0, x1, delta, epsilon, pf1, maxit]
	printFunctionOutput(mstycznych, args)

	println("sprawdzic f2 x0 > 1")
	x0 = 1.1;
	delta = 10.0^-5.0
	epsilon = delta
	args = [f2, x0, x1, delta, epsilon, pf2, maxit]
	printFunctionOutput(mstycznych, args)

	println("sprawdzic f2 x0 = 1")
	x0 = -1.0;
	delta = 10.0^-5.0
	epsilon = delta
	args = [f2, x0, x1, delta, epsilon, pf2, maxit]
	printFunctionOutput(mstycznych, args)

	desc("</ Zad. 6 >")
end

function desc(title)
	println()
	println("*********** ", title, " ***********")
	println()
end

main()
