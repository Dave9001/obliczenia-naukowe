###############################################################################
#
#	@brief:  	Source code for laboratory list number 1.
#
###############################################################################


include("../decorators/decor_L2_T5.jl")

function recursion(n::Int, r::Float64, n_0::Float64)
	if (n == 0)
		return n_0
	else     
		p = (recursion(n-1, r, n_0));
		println("p: ", p, "  n: ", n)
	 	return (p + r*p*(1-p))
	end
end

function recursionWithTrimm(n::Int, stop::Int, r::Float64, n_0::Float64)
	if n == 0
		return n_0
    elseif n == stop 
		p = (recursionWithTrimm(n-1, stop, r, n_0));
		println("--p: ", p, "  n: ", n)	
        for i = 1:length(string(p))
            if string(p)[i] == '.'
                p = parse(Float64, string(p)[1:i+3])
                break;
            end
        end

	 	return (p + r*p*(1-p))
    else     
		p = recursionWithTrimm(n-1, stop, r, n_0);
		println("p: ", p, "  n: ", n)		
	 	return (p + r*p*(1-p))
	end
end


function recursion32(n::Int64, r::Float32, n_0::Float32)
	p::Float32 = 0.0
	if (n == 0)
		return n_0
	else     
		p = Float32((recursion32(n-1, r, n_0)))
		println("p: ", p, "  n: ", n)
	 	return (p + r*p*(1-p))
	end
end

function recursionWithTrimm32(n::Int64, stop::Int, r::Float32, n_0::Float32)
	p::Float32 = 0.0
	if n == 0
		return n_0
    elseif n == stop 
		p = Float32(recursionWithTrimm32(n-1, stop, r, n_0));
		println("--p: ", p, "  n: ", n)	
        for i = 1:length(string(p))
            if string(p)[i] == '.'
                p = Float32(parse(Float64, string(p)[1:i+3]))
                break;
            end
        end

	 	return (p + r*p*(1-p))
    else     
		p = Float32(recursionWithTrimm32(n-1, stop, r, n_0))
		println("p: ", p, "  n: ", n)		
	 	return (p + r*p*(1-p))
	end
end
