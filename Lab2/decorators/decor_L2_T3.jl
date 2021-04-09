###############################################################################
#
#	@brief:  	Source code for laboratory list number 1.
###############################################################################

function decoratorTableNaming_L2_T3()
    println("--------------------------------------------------------------------")
    println("Metoda\t   Blad wzgledny\tc\tn\t      cond(A)\t\tMatrix")
	println("--------------------------------------------------------------------")
end

function L2_T3_decoratorPrint(matrixA, solver, approxError, matrixSize, matrixCond, matrixType)
    println(solver, "\t", approxError, "\t", matrixCond, "\t", matrixSize, "\t", cond(matrixA),"\t",matrixType)
end
