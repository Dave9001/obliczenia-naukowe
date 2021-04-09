###############################################################################
#
#	@brief:  	Source code for laboratory list number 1.
#
###############################################################################


include("../decorators/decor_L2_T3.jl")

using LinearAlgebra
using Polynomials

function prodOutcomeLinearEquation(matrixAGenerator, solver,vectMatrixSize, vectMatrixCond)

    for sizeIndex = 1:length(vectMatrixSize)
        for condIndex = 1:length(vectMatrixCond)

            matrixSize = vectMatrixSize[sizeIndex]
            matrixCondition = vectMatrixCond[condIndex]
            
            matrixA = generateMatrixA(matrixAGenerator, matrixSize, matrixCondition)
        
            approxError = calcApproxError(matrixA, solver)

            L2_T3_decoratorPrint(matrixA, solver, approxError, matrixSize, matrixCondition,matrixAGenerator)
        end
    end


end

function calcApproxError(matrixA, solver)

    dim = size(matrixA)
    x = ones(dim[1], 1)

    b = matrixA * x

    if  solver == "Gauss" ||
        solver == "gauss"

        result = matrixA \ b

    elseif solver == "Inv" ||
           solver == "inv"

        result = inv(matrixA) * b
    else
        pritln("Wrong solver")
        return nothing
    end

    #approxError = cond(matrixA)norm(x - result) / norm(x)
    approxError = norm(x - result) / norm(x)
    

    return approxError
end


function generateMatrixA(matrixAGenerator, matrixSize::Int, matrixCondition)
    if  matrixAGenerator == "Hilb" ||
        matrixAGenerator == "hilb"

        matrixA =  hilb(matrixSize)
    elseif matrixAGenerator == "Rand" ||
            matrixAGenerator == "rand"

        matrixA = matcond(matrixSize, matrixCondition)#matcond(matrixSize, matrixCondition)
    end

    return matrixA
end




function matcond(n::Int, c::Float64)
    # Function generates a random square matrix A of size n with
    # a given condition number c.
    # Inputs:
    #	n: size of matrix A, n>1
    #	c: condition of matrix A, c>= 1.0
    #
    # Usage: matcond (10, 100.0);
    #
    # Pawel Zielinski
            if n < 2
             error("size n should be > 1")
            end
            if c< 1.0
             error("condition number  c of a matrix  should be >= 1.0")
            end
            (U,S,V)=svd(rand(n,n))
            #return U*diagm(0 => range(1.0, step = (c-1.0)/(n-1), length = n))*V'
            return U*diagm(0 => range(1.0,length=n,stop=c))*V'
end
        

function hilb(n::Int)
    # Function generates the Hilbert matrix  A of size n,
    #  A (i, j) = 1 / (i + j - 1)
    # Inputs:
    #	n: size of matrix A, n>=1
    #
    #
    # Usage: hilb (10)
    #
    # Pawel Zielinski
            if n < 1
             error("size n should be >= 1")
            end
            return [1 / (i + j - 1) for i in 1:n, j in 1:n]
    end
    
