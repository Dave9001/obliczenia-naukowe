include("blocksys.jl")


using .blocksys
using SparseArrays


#pivot = false
#er, x = cmptGauss("a.txt", pivot)
#println("Gauss (b = [1, ... , 1]^T). Pivot = $pivot")
#print("error: ")
#show(er)
#println("\n", x, "\n\n")





# ZADANIE NA 5
pivot = true
#er, ALU, P = cmptLU("A81.txt", pivot)
A = sparse([1,1,1,2,2,2,3,3,3],[1,2,3,1,2,3,1,2,3],[2.0,4,3,-1,-2,7,9,2,-3])

er, ALU, P = cmptLU(A, pivot)
println("ddd\n",A)
#println(A)
#println("LUggg:\n", ALU)

b = [2.0,3.0,2.0002]
#Pb = P*b
#b = [1.0, 2.002, 3.0012, 1.0, 321.2, 456.2, 0.0001, 10.111]
x = cmptFromLU(ALU, P, b)
#x = cmptFromLU(ALU, "b81.txt")
println("x from LU (b from file). Pivot = $pivot")
print("error: ")
show(er)
println("\n", x)
println(P*b)
