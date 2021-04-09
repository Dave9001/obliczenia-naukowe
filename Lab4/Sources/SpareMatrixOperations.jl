using SparseArrays


function SpareMat_Mul(A::SparseMatrixCSC, B::SparseMatrixCSC)

end

#function SpareMat_Mul(
#    dim_Ai::Int, dim_Aj::Int,
#    dim_Bi::Int, dim_Bj::Int,
#    Ia::Array{Int64,1}, Ja::Array{Int64,1}, Va::Array{Float64,1},
#    Ib::Array{Int64,1}, Jb::Array{Int64,1}, Vb::Array{Float64,1}
#)
#
#    if dim_Aj != dim_Bi
#        println("Matrix multiplication has wrong dimensions")
#        println("Program terminated")
#        exit()
#    elseif length(Ia) != length(Ja) ||
#           length(Ib) != length(Jb) 
#
#        println("Matrix multiplication has wrong dimensions")
#        println("Program terminated")
#        exit()
#    end
#
#    dim_i = dim_Ai
#    dim_j = dim_Bj
#
 #   x = zeros(dim_i, dim_j)
#
 #   unique_i = unique(Ia) #wszystkie różne i z macierzy A
  #  unique_j = unique(Jb) #wszystkie różne j z macierzy B
#
 #   for ui in unique_i
#
 #       i_set = findall(x->x==ui, Ia)
#
 #       for (index_j, j) in enumerate(unique_j)
  #          
#end


function SpareMat_MulDens(
    dim_Ai::Int, dim_Aj::Int,
    Ai::Array{Int64,1}, Aj::Array{Int64,1}, Av::Array{Float64,1},
    B
)

    dim_Bi = size(B)[1]
    if 2 == size(B)
        dim_Bj = size(B)[2]
    else
        dim_Bj = 1
    end

    if dim_Aj != dim_Bi
        println("Matrix multiplication has wrong dimensions")
        println("Program terminated")
        exit()
    end 

    x = zeros(dim_Ai, dim_Bj)

    for index = 1:length(Ai)
        ai = Ai[index]
        aj = Aj[index]
        av = Av[index]

        for bj in [1:dim_Bj]
            x[ai, bj] += av * B[aj,bj]
        end
    end

    return x
end

