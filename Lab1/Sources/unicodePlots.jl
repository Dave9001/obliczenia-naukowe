using Pkg
#Pkg.install("Plots")
#kg.install("UnicodePlots")

Pkg.add("Plots")
Pkg.add("UnicodePlots")

using UnicodePlots
using Plots

stairs([1, 2, 4, 7, 8], [1, 3, 4, 2, 7], color = :red, style = :post, title = "My Staircase Plot")
x = 1:10; y = rand(10,2) # 2 columns means two lines
plot(x,y)