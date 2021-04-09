include("blocksys.jl")

using .blocksys
using SparseArrays


pivot = true
er, x = cmptGauss("A.txt", "b.txt", pivot)
println("Gauss (b from file). Pivot = $pivot")
print("error: ")
show(er)
println("\n", x, "\n\n")

pivot = false
er, x = cmptGauss("A.txt", "b.txt", pivot)
println("Gauss (b from file). Pivot = $pivot")
print("error: ")
show(er)
println("\n", x, "\n\n")

pivot = true
er, x = cmptGauss("A.txt", pivot)
println("Gauss (b = [1, ... , 1]^T). Pivot = $pivot")
print("error: ")
show(er)
println("\n", x, "\n\n")

pivot = false
er, x = cmptGauss("A.txt", pivot)
println("Gauss (b = [1, ... , 1]^T). Pivot = $pivot")
print("error: ")
show(er)
println("\n", x, "\n\n")

pivot = true
er, A, P = cmptLU("A.txt", pivot)
println("LU. Pivot = $pivot")
print("error: ")
show(er)
println("\n", A, "\n", P, "\n\n")

pivot = false
er, A, P = cmptLU("A.txt", pivot)
println("LU. Pivot = $pivot")
print("error: ")
show(er)
println("\n", A, "\n\n")

pivot = true
er, A, P = cmptLU("A.txt", pivot)
x = cmptFromLU(A, "b.txt")
println("x from LU (b from file). Pivot = $pivot")
print("error: ")
show(er)
println("\n", x, "\n\n")

pivot = false
er, A, P = cmptLU("A.txt", pivot)
x = cmptFromLU(A, "b.txt")
println("x from LU (b from file). Pivot = $pivot")
print("error: ")
show(er)
println("\n", x, "\n\n")

pivot = true
er, A, P = cmptLU("A.txt", pivot)
x = cmptFromLU(A, P,"b.txt")
println("x from LU (b from file). Pivot = $pivot")
print("error: ")
show(er)
println("\n", x, "\n", P, "\n\n")

#redundand
#pivot = false
#er, A, P = cmptLU("A.txt", pivot)
#x = cmptFromLU(A, P, "b.txt")
#println("x from LU (b from file). Pivot = $pivot")
#print("error: ")
#show(er)
#println("\n", x, "\n", "\n\n")

