###############################################################################
#
#	@brief:  	Source code for laboratory list number 1.
#
###############################################################################


include("../decorators/decor_L2_T6.jl")


function recurEquation(c, x_0)
    recur(40, c, x_0)
end

function recur(n, c, x_0)
    if n == 0
        return x_0
    else
        x_n = recur(n-1, c, x_0)
        x_n1 = (x_n^2.0) + c

        println(n, ": ", x_n1)
        return x_n1
    end
end

function rekurencja(n::Int, c::Float64, x0::Float64)
	if (n == 0)
		x0
	else     
		x = (rekurencja(n-1, c, x0))^2 + c;		
	 	println(n, " ",	x)	
		x
	end
end
