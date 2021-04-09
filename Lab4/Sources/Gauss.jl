using SparseArrays

export Gauss

#opt ok
function Gauss(AB::SparseMatrixCSC, x::Array{Float64,1}, pivot::Bool)
    error = nothing
    
	dim = minimum(size(AB))
    epsilon = eps(0.0)

    Iab, Jab, Vab = findnz(AB)

    for i = 1:(dim-1)
        if  true == pivot  
            indexRM = findall(x->x == i, Jab) #indexRows contains indexes of occurence
            indexRM = view(Iab, indexRM)
            indexRM = filter(x->x >= i && x <= dim, indexRM)

            maxV::Float64 = 0.0
            maxV, rowOfMaxIndex = findmax(broadcast(abs, AB[indexRM, i]))
            
            rowOfMax = indexRM[rowOfMaxIndex]

            tmpRow = AB[i, 1:(dim+1)]
            AB[i, 1:(dim+1)] = AB[rowOfMax, 1:(dim+1)]
            AB[rowOfMax, 1:(dim+1)] = tmpRow
        end

        #dropzeros!(AB)
        #Iab, Jab, Vab = findnz(AB)
        nzIndices = collect(zip(Iab, Jab))
        nzIndices = filter(x->x[:][1] > i && x[:][2] > i, nzIndices)

        nz_i = unique(broadcast(x->x[:][1], nzIndices))
        nz_j = unique(broadcast(x->x[:][2], nzIndices))

        #for j = (i+1):dim
        for j in nz_i
            if abs(AB[i,i]) < epsilon
                error = "division by zero at: [$i,$i]"
                return error, x
            end

            m = -(AB[j, i] / AB[i,i])

            #for k = (i+1):(dim+1)
            for k in nz_j
                AB[j, k] = AB[j, k] + m * AB[i, k]
            end
        end
    end

    dropzeros!(AB)
    Iab, Jab, Vab = findnz(AB)
    nzIndices = collect(zip(Iab, Jab))

    for i = dim:-1:1
        s = AB[i, dim+1]

        cpnzIndices = filter(x->x[:][1] == i && x[:][2] > i && x[:][2] <= dim, nzIndices)
  
        nz_j = unique(broadcast(x->x[:][2], cpnzIndices))
        sort!(nz_j, rev = true)
       
        #for j = dim:-1:(i+1)
        for j in nz_j
            s = s - AB[i,j] * x[j]
        end

        if abs(AB[i,i]) < epsilon
            error = "division by zero at: [$i,$i]"
            return error, x            
        end

        x[i] = s / AB[i, i]
    end

    return error, x
end
#A = sparse([1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4], [1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4], [12.0,2,0,0,2,35,15477,0,0,10000,2,5555555,0,0,0,232323])
#B = ones(4)
#x = ones(4)
#er, x = Gauss([A B], x, true)
#println(x)



