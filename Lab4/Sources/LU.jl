
using SparseArrays
using LinearAlgebra

export LU, LUXB

function LUolder(dim::Int, I::Array{Int64,1}, J::Array{Int64,1}, V::Array{Float64,1})
    error = nothing

    A = sparse(I, J, V)
    dropzeros!(A)
    epsilon = eps(0.0)

    for k = 1:(dim-1)
        if abs(A[k,k]) < epsilon
            error = "division by zero at: [$k,$k]"
            break
        end

        #normalization of column A[i,k]
        indexRows = findall(x->x==k, J) #indexRows contains indexes of occurence
        indexRows = view(I, indexRows) #indexRows conatins real -> written indexes (not indexes in array) 
        indexRows = filter(x->x>k, indexRows) #bigger than current

        for i in indexRows
            A[i, k] = A[i,k] / A[k,k]
        end

        innerNonZeroIndexes = findall(!iszero, A)
        boundRule = t->(t[1] > k && t[2] > k)
        filter!(boundRule, innerNonZeroIndexes) #innerNonZeroIndexes is CartesianIndex type
        
        for index in innerNonZeroIndexes
            i = index[1]
            j = index[2]

            A[i,j] = A[i,j] - A[i,k] * A[k,j]
        end
    end

    return error, A
end

#er, A = LU(4, [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4], [1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4], [12.0,2,0,0,2,35,15477,0,0,10000,2,5555555,0,0,0,232323])
#show(er)
#println(A)

function LUold(dim::Int, Ia::Array{Int64,1}, Ja::Array{Int64,1}, Va::Array{Float64,1}, pivot::String)
    error = nothing

    A = sparse(Ia, Ja, Va)
    dropzeros!(A)
    epsilon = eps(0.0)

    P = spzeros(dim, dim)
    for i = 1:dim
        P[i,i] = 1
    end

    for k = 1:(dim-1)
        if abs(A[k,k]) < epsilon
            error = "division by zero at: [$k,$k]"
            break
        end

        if "full" == pivot
            
        elseif "partial" == pivot  
 
            indexRM = findall(x->x==k, Ja) #indexRows contains indexes of occurence
            indexRM = view(Ia, indexRM)
            indexRM = filter(x->x>=k, indexRM)

            maxV::Float64 = 0.0
            maxV, rowOfMaxIndex = findmax(broadcast(abs, A[indexRM, k]))
            
            rowOfMax = indexRM[rowOfMaxIndex]

            tmpRow = A[k,1:dim]
            A[k,1:dim] = A[rowOfMax,1:dim]
            A[rowOfMax,1:dim] = tmpRow

            Ia, Ja, Va = findnz(A)

            tmpRow = P[k,1:dim]
            P[k,1:dim] = P[rowOfMax,1:dim]
            P[rowOfMax,1:dim] = tmpRow

        else
            error = "pivot method unknown"
            break
        end

        indexRows = findall(x->x==k, Ja)
        indexRows = view(Ia, indexRows)
        indexRows = filter(x->x>k, indexRows) #bigger than current
 
        for i in indexRows
            A[i, k] = A[i,k] / A[k,k]
        end

        #innerNonZeroIndexes = findall(!iszero, A)
        #boundRule = t->(t[1] > k && t[2] > k)
        #filter!(boundRule, innerNonZeroIndexes) #innerNonZeroIndexes is CartesianIndex type

        #for index in innerNonZeroIndexes
        #    i = index[1]
        #    j = index[2]

        #    A[i,j] = A[i,j] - (A[i,k] * A[k,j])
            
        #end

        #nonZeroPos = findall(x->x!=0.0,A)
        #nonZeroPos = filter(x->(x[1] > k && x[2] > k), nonZeroPos)
        #sort!(nonZeroPos, by = x->x[1]) # by index i

        #A[k,j] nie moze byc 0
        #A[i,k] nie moze byc 0

        #nzKJ    = findall(x->x != 0.0, A[k,:])
        #nzKJpos = findall(x->x != 0.0, A)
        #nzKJpos = filter(x->x[2] ∈ nzKJ && x[1] == k, nzKJpos[:])

        #nzIK    = findall(!iszero, A[:,k])
        #nzIKpos = findall(!iszero, A)
        #nzIKpos = filter(x->x[1] ∈ nzIK && x[2] == k, nzIKpos[:])

        #for posI in nzIKpos
        #    for posJ in nzKJpos
        #        i = posI[1]
        #        j = posJ[2]
        #        println(i," ", j, " ", k)
        #        A[i,j] = A[i,j] - (A[i,k] * A[k,j])
        #    end
        #end
        #println()
        for i = k+1:dim
            for j = k+1:dim
                println(i," ", j, " ", k)
                A[i,j] = A[i,j] - (A[i,k] * A[k,j])
            end
        end
        
        #for ik in nzIKpos
        #    i = ik[1]
        #    for kj in nzKJpos
        #        j = kj[2]
        #        println(i," ", j, " ", k)
        #        A[i,j] = A[i,j] - (A[ik] * A[kj])
        #    end
        #end

        #rowIdindex = findall(x->x>k, Ia)
        #columnId   = view(Ja, rowIdindex)
        #columnId   = filter(x->x>k, columnId)
    
        #rowId      = view(Ia, rowIdindex)
        #rowId   = filter(x->x>k, rowId)

        #for i in rowId
        #    for j in columnId
        #       A[i,j] = A[i,j] -(A[i,k] * A[k,j])
        #    end
        #end

    end

    return error, A, P
end

#er, A, P = LU(4, [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4], [1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4], [12.0,2,0,0,2,35,15477,0,0,10000,2,5555555,0,0,0,232323], "partial")
#println(A)
#println(P)

function LUhalfopt(dim::Int, Ia::Array{Int64,1}, Ja::Array{Int64,1}, Va::Array{Float64,1}, pivot::Bool)
    error = nothing

    A = sparse(Ia, Ja, Va)
    dropzeros!(A)
    epsilon = eps(0.0)

    P = spzeros(dim, dim)
    for i = 1:dim
        P[i,i] = 1
    end

    for k = 1:(dim-1)
        if  true == pivot  
            indexRM = findall(x->x==k, Ja) #indexRows contains indexes of occurence
            indexRM = view(Ia, indexRM)
            indexRM = filter(x->x>=k, indexRM)

            maxV::Float64 = 0.0
            maxV, rowOfMaxIndex = findmax(broadcast(abs, A[indexRM, k]))
            
            rowOfMax = indexRM[rowOfMaxIndex]

            tmpRow = A[k,1:dim]
            A[k,1:dim] = A[rowOfMax,1:dim]
            A[rowOfMax,1:dim] = tmpRow

            tmpRow = P[k,1:dim]
            P[k,1:dim] = P[rowOfMax,1:dim]
            P[rowOfMax,1:dim] = tmpRow
        end

        if abs(A[k,k]) < epsilon
            error = "division by zero at: [$k,$k]"
            break
        end

        indexRows = findall(x->x==k, Ja)
        indexRows = view(Ia, indexRows)
        indexRows = filter(x->x>k, indexRows) #bigger than current
 
        for i in indexRows
            A[i, k] = A[i,k] / A[k,k]
        end

        for i = k+1:dim
            for j = k+1:dim
                A[i,j] = A[i,j] - (A[i,k] * A[k,j])
            end
        end
    end

    return error, A, P
end
#er, A, P = LU(4, [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4], [1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4], [12.0,2,0,0,2,35,15477,0,0,10000,2,5555555,0,0,0,232323], true)
#println(A)
#println(findnz(P))

#opt ok
function LU(dim::Int, Ia::Array{Int64,1}, Ja::Array{Int64,1}, Va::Array{Float64,1}, pivot::Bool)
    error = nothing

    A = sparse(Ia, Ja, Va)
    dropzeros!(A)
    epsilon = eps(0.0)

    P = spzeros(dim, dim)
    for i = 1:dim
        P[i,i] = 1
    end

    for k = 1:(dim-1)
        if  true == pivot  
            indexRM = findall(x->x==k, Ja) #indexRows contains indexes of occurence
            indexRM = view(Ia, indexRM)
            indexRM = filter(x->x>=k, indexRM)

            maxV::Float64 = 0.0
            maxV, rowOfMaxIndex = findmax(broadcast(abs, A[indexRM, k]))
            
            rowOfMax = indexRM[rowOfMaxIndex]

            tmpRow = A[k,1:dim]
            A[k,1:dim] = A[rowOfMax,1:dim]
            A[rowOfMax,1:dim] = tmpRow

            tmpRow = P[k,1:dim]
            P[k,1:dim] = P[rowOfMax,1:dim]
            P[rowOfMax,1:dim] = tmpRow
        end

        if abs(A[k,k]) < epsilon
            error = "division by zero at: [$k,$k]"
            break
        end

        indexRows = findall(x->x==k, Ja)
        indexRows = view(Ia, indexRows)
        indexRows = filter(x->x>k, indexRows) #bigger than current
 
        for i in indexRows
            A[i, k] = A[i,k] / A[k,k]
        end

        dropzeros!(A)
        I_a, J_a, V_a = findnz(A)
        nzIndices = collect(zip(I_a, J_a))
        nzIndices = filter(x->x[:][1] > k && x[:][2] > k, nzIndices)

        nz_i = unique(broadcast(x->x[:][1], nzIndices))
        nz_j = unique(broadcast(x->x[:][2], nzIndices))

        for i in nz_i
            for j in nz_j
                A[i,j] = A[i,j] - (A[i,k] * A[k,j])
            end
        end
    end

    return error, A, P
end
#er, A, P = LU(4, [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4], [1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4], [12.0,2,0,0,2,35,15477,0,0,10000,2,5555555,0,0,0,232323], true)
#println(A)

#opt ok
function backward(U::SparseMatrixCSC, y::Array{Float64,1})
    dim::Int64 = size(U)[1]

    x = ones(Float64, dim)
    x[dim] = y[dim] / U[dim, dim]

    dropzeros!(U)
    I_u, J_u, V_u = findnz(U)
    nzIndices = collect(zip(I_u, J_u))
    nzIndices = filter(x->x[:][2] > x[:][1], nzIndices)

    for i = (dim-1):-1:1
        s = y[i]

        nz_j = unique(broadcast(x->x[:][2], filter(x->x[:][2] > i , nzIndices)))
        for j in nz_j
            s = s - (U[i, j] * x[j])
        end

        x[i] = s / U[i, i]
    end

    return x
end

#opt ok
function forward(L::SparseMatrixCSC, Pb::Array{Float64,1})
    dim::Int64 = size(L)[1]

    x = ones(Float64, dim)
    x[1] = Pb[1]
    
    dropzeros!(L)
    I_l, J_l, V_l = findnz(L)
    nzIndices = collect(zip(I_l, J_l))
    nzIndices = filter(x->x[:][2] < x[:][1], nzIndices)

    for i = 2:dim
        s = Pb[i]

        nz_j = unique(broadcast(x->x[:][2], filter(x->x[:][2] < i , nzIndices)))
        for j in nz_j
            s = s - L[i, j] * x[j]
        end

        x[i] = s
    end

    return x
end

#opt ok
function LUXB(LU::SparseMatrixCSC, P::SparseMatrixCSC, b::Array{Float64,1})

    dim = size(LU)[1]
    L   = spzeros(dim, dim)
    U   = spzeros(dim, dim)

    for i = 1:dim
        for j = 1:dim
            if i > j
                L[i,j] = LU[i,j]
            elseif i <= j 
                U[i,j] = LU[i,j]
            end
        end
    end

    for i = 1:dim
        L[i,i] = 1.0
    end

    Pb = P * b
	#println(L)

	println("tu:\n", P*(L*U))

    z = forward(U, Pb)
    x = backward(L, z)
    
    return x
end
#println("Z pivotem dziala=============================")
# = LUXB(A, P, ones(Float64, 4))
#println(x)

#opt ok
function LUXB(LU::SparseMatrixCSC, b::Array{Float64,1})

    dim = size(LU)[1]
    L   = spzeros(dim, dim)
    U   = spzeros(dim, dim)

    for i = 1:dim
        for j = 1:dim
            if i > j
                L[i,j] = LU[i,j]
            elseif i <= j 
                U[i,j] = LU[i,j]
            end
        end
    end

    for i = 1:dim
        L[i,i] = 1.0
    end

    z = forward(L, b)
    x = backward(U, z)
    
    return x
end
#println("WTFFF 4444==========================")
#x = LUXB(A, ones(Float64, 4))
#println(x)

#dziala nie opt LUXB jest tym samym i dziala i opt
function LUXB2(LU::SparseMatrixCSC, b::Array{Float64,1})
    error = nothing

    dim = size(LU)[1]
    epsilon = eps(0.0)

    x = zeros(Float64, dim)
    x[1] = b[1]

    dropzeros!(LU)
    I_lu, J_lu, V_lu = findnz(LU)
    nzIndices = collect(zip(I_lu, J_lu))
    nzIndices = filter(x->x[2] < x[1], nzIndices)

    nz_j = []
    for index in nzIndices
        if !(index[2] in nz_j)
            push!(nz_j, index[2])
       end
    end

    for i = 2:dim
        s = 0.0
        for j in nz_j
            s = s + LU[i,j] * x[j]
        end
        
        x[i] = b[i] - s
    end

    if abs(LU[dim, dim]) < epsilon
        error = error = "division by zero at: [$dim,$dim]"
        return x, error
    end

    x[dim] = x[dim] / LU[dim, dim]

    for i = (dim-1):-1:1
        s = 0.0
        for j = (i+1):dim
            s = s + LU[i,j] * x[j]
        end

        if abs(LU[i, i]) < epsilon
            error = error = "division by zero at: [$dim,$dim]"
            return x, error
        end

        x[i] = (x[i] - s) / LU[i,i]
    end

    return x, error
end
#println("bez PIVOTA stare dziala=============================")
#x, er = LUXB2(A, ones(Float64, 4))
#println(x)
