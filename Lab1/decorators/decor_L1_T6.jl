
function decoratorFunctions(domain, gResults, fResults)
	println("pow 8:     ", domain)
	println("g(x): ", gResults)
	println("f(x): ", fResults)
end


function decoratorAbsDistance(absDistOfResults)
	println("abs(g(x)-f(x): ", absDistOfResults)
end

function decoratorBitFunctions(domain, gResults, fResults)
	println()
	
	lenResults = length(gResults)
	for i = 1:lenResults
		println("bit g(8^", i * (-1), "): ", bitstring(gResults[i]) )
		println("bit f(8^", i * (-1), "): ", bitstring(fResults[i]) )
		println()
	end
end