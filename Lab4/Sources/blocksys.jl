

module blocksys

    include("readFile.jl")
    include("LU.jl")
    include("Gauss.jl")

    using SparseArrays

    export cmptGauss, cmptLU, cmptFromLU

    function cmptGauss(FileNameMatrixA::String, FileNameMatrixB::String, pivot::Bool)
        dim_A, dim_Ak, Ia, Ja, Aij = GatherDataForMatrixA(FileNameMatrixA)
        dim_b, B = GatherDataForMatrixB(FileNameMatrixB)

        if 0 == length(Ia) || 0 == length(Ja) || 0 == length(Aij) || 0 == length(dim_b)
            println("Error: empty (or full of zeros) matrix as argument")
            exit()
        end

        A = sparse(Ia, Ja, Aij)

        er, x = Gauss([A B], ones(dim_A), pivot)

        WriteX(x)

        return er, x
    end

    function cmptGauss(FileNameMatrixA::String, pivot::Bool)
        dim_A, dim_Ak, Ia, Ja, Aij = GatherDataForMatrixA(FileNameMatrixA)
        B = ones(dim_A)

        if 0 == length(Ia) || 0 == length(Ja) || 0 == length(Aij) || 0 == dim_A
            println("Error: empty (or full of zeros) matrix as argument")
            exit()
        end

        A = sparse(Ia, Ja, Aij)

        er, x = Gauss([A B], ones(dim_A), pivot)

        WriteX(B, x)

        return er, x
    end

    function cmptLU(FileNameMatrixA::String, pivot::Bool)
        dim_A, dim_Ak, Ia, Ja, Aij = GatherDataForMatrixA(FileNameMatrixA)

        if 0 == length(Ia) || 0 == length(Ja) || 0 == length(Aij)
            println("Error: empty (or full of zeros) matrix as argument")
            exit()
        end

        er, A, P = LU(dim_A, Ia, Ja, Aij, pivot)

        return er, A, P 
    end

    function cmptLU(A::SparseMatrixCSC, pivot::Bool)
        Ia, Ja, Aij = findnz(A)
        dim_A = size(A)[1]
  
        if 0 == length(Ia) || 0 == length(Ja) || 0 == length(Aij)
            println("Error: empty (or full of zeros) matrix as argument")
            exit()
        end

        er, Alu, P = LU(dim_A, Ia, Ja, Aij, pivot)

        return er, Alu, P    
    end

    function cmptFromLU(LU::SparseMatrixCSC, B::Array{Float64,1})
        x = LUXB(LU, B)

        return x
    end

    function cmptFromLU(LU::SparseMatrixCSC, P::SparseMatrixCSC, B::Array{Float64,1})
        x = LUXB(LU, P, B)

        return x
    end

    function cmptFromLU(LU::SparseMatrixCSC, FileNameMatrixB::String)
        dim_b, B = GatherDataForMatrixB(FileNameMatrixB)

        if 0 == length(dim_b)
            println("Error: empty matrix as argument from file $FileNameMatrixB")
            exit()
        end

        x = LUXB(LU, B)

        return x
    end

    function cmptFromLU(LU::SparseMatrixCSC, P::SparseMatrixCSC, FileNameMatrixB::String)
        dim_b, B = GatherDataForMatrixB(FileNameMatrixB)

        if 0 == length(dim_b)
            println("Error: empty matrix as argument from file $FileNameMatrixB")
            exit()
        end

        x = LUXB(LU, P, B)

        return x
    end

end