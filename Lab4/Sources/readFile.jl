

using LinearAlgebra
#using SparseArrays

export GatherDataForMatrixA, GatherDataForMatrixB, WriteX

function GatherDataForMatrixA(fileName::String)

    lines = collect(eachline(fileName))

    words = split(lines[1])

    dim_A::Int  = 0
    dim_Ak::Int = 0

    try
        dim_A, dim_Ak = ReadMatricesDimensions(words[1], words[2])
    catch exception
        if exception isa BoundsError
            println("Expecting 2 arguments in first line\n",
                    "1st line should look like:\n\n",
                    "number[space, or tab]number\n\n",
                    "Where number ∈ ℕ and number > 0"
            )
            exit()
        else
            println("Wrong format of data in first line\n",
                    "1st line should look like:\n\n",
                    "number[space, or tab]number\n\n",
                    "Where number ∈ ℕ and number > 0"
            )
            exit()
        end
    end

    I::Array{Int}   = []
    J::Array{Int}   = []
    Aij::Array{Float64} = []

    for (lineNo, line) in enumerate(lines[2 : length(lines)])
        words = split(line)
        try
            i, j, aij = ReadDataOfInnerMatricesMatrixA(words[1], words[2], words[3], lineNo, fileName)
            push!(I, i)
            push!(J, j)
            push!(Aij, aij)
        catch exception
            if exception isa BoundsError
                println("Expecting 3 arguments in ", lineNo + 1, " line of file: ", fileName, "\n",
                        "Format of this line is:\n\n",
                        "number[space, or tab]number[space, or tab]realNumber\n\n",
                        "Where number ∈ ℕ, number > 0, and realNumber ∈ ℝ")
                exit()
            else
                println("Wrong format of data in in ", lineNo + 1, " line of file: ", fileName, "\n",
                        "Format of this line is:\n\n",
                        "number[space, or tab]number[space, or tab]realNumber\n\n",
                        "Where number ∈ ℕ, number > 0, and realNumber ∈ ℝ")
                exit()
            end
        end
    end

    return dim_A, dim_Ak, I, J, Aij
end

function ReadMatricesDimensions(N, L)
    
    dim_A::Int = 0
    dim_Ak::Int = 0

    try 
        dim_A = parse(UInt, N)
    catch exception
        if exception isa ArgumentError
            return "Dimension of matrix A should be ℕ type and bigger than zero"
        else
            return "Error occurred: Reading dimension of matrix A"
        end
    end

    try 
        dim_Ak = parse(UInt, L)
    catch exception
        if exception isa ArgumentError
            return "Dimension of inner matrices should be ℕ type and bigger than zero"
        else
            return "Error occurred: Reading dimension of inner matrices"
        end
    end

    if dim_A <= 0 || dim_Ak <= 0
        println("Error: Dimension of matrix A should be > 0")
        exit()
    end
    
    return dim_A, dim_Ak
end

function ReadDataOfInnerMatricesMatrixA(I, J, Ak, lineNo, fileName)
    try
        i = parse(UInt, I)
        j = parse(UInt, J)
        Aij = parse(Float64, Ak)

        return i, j, Aij
    catch exception
        if exception isa ArgumentError
            println("Wrong format of data in ", lineNo + 1, " line of file: ", fileName, "\n",
                    "Format of inner matrices data sets is:\n\n",
                    "number[space, or tab]number[space, or tab]realNumber\n\n",
                    "Where number ∈ ℕ, number > 0, and realNumber ∈ ℝ"
            )
            exit()
        else
            println("Error occurred: Reading value of matrix A element", Ak," is of wrong type")
            exit()
        end

    end
end

function GatherDataForMatrixB(fileName::String)

    lines = collect(eachline(fileName))

    words = split(lines[1])

    dim_b::Int64 = 0

    try
        dim_b = ReadBDime(words[1], fileName)

        if length(lines) - 1 != dim_b
            println("Number of lines of parameters in Matrix b,",
                    "should be equal to argument in first line",
                    "in file: ", fileName
            )
            exit()
        end

    catch exception
        if exception isa BoundsError
            println("Expecting 1 argument in first line of file ", fileName ,"\n",
                    "1st line should look like:\n\n",
                    "number\n\n",
                    "Where number ∈ ℕ and number > 0"
            )
            exit()
        else
            println("Wrong format of data in first line of file ", fileName ,"\n",
                    "1st line should look like:\n\n",
                    "number\n\n",
                    "Where number ∈ ℕ and number > 0"
            )
            exit()
        end
    end

    B::Array{Float64} = []

    for (lineNo, line) in enumerate(lines[2 : length(lines)])
        words = split(line)
        try
            if length(words) != 1
                println("Wrong format of data in ", lineNo + 1, " line of file ", fileName ,"\n",
                        "line should look like:\n\n",
                        "realNumber\n\n",
                        "Where realNumber ∈ ℝ"
                )
                exit()
            end

            bi = ReadDataOfMatrixB(words[1], lineNo, fileName)
            push!(B, bi)

        catch exception
            if exception isa BoundsError
                println("Expecting 1 argument in ", lineNo + 1, " line of file: ", fileName, "\n",
                        "Format of this line is:\n\n",
                        "realNumber\n\n",
                        "Where realNumber ∈ ℝ")
                exit()
            else
                println("Wrong format of data in ", lineNo + 1, " line of file: ", fileName, "\n",
                        "Format of this line is:\n\n",
                        "realNumber\n\n",
                        "Where realNumber ∈ ℝ")
                exit()
            end
        end
    end

    return dim_b, B
end

function ReadBDime(N, fileName)
    try
        n = parse(UInt, N)

        if n <= 0
            println("Wrong data in first line of file ", fileName ,"\n",
                    "line should look like:\n\n",
                    "number\n\n",
                    "Where number ∈ ℕ and number > 0"
            )
            exit()
        end

        return n
    catch exception
        if exception isa ArgumentError
            println("Wrong format of data in first line\n",
                    "1st line should look like:\n\n",
                    "number\n\n",
                    "Where number ∈ ℕ and number > 0"
            )
            exit()
        else
            println("Error occurred: Reading Matrix b dimension")
            exit()
        end

    end
end

function ReadDataOfMatrixB(Bi, lineNo, fileName)
    try
        bi = parse(Float64, Bi)

        return bi
    catch exception
        if exception isa ArgumentError
            println("Wrong format of data in ", lineNo + 1, " line of file: ", fileName, "\n",
                    "Format data set is:\n\n",
                    "realNumber\n\n",
                    "realNumber ∈ ℝ"
            )
            exit()
        else
            println("Error occurred: Reading data set of matrix b element", Bi, " is of wrong type")
            exit()
        end

    end
end

function WriteX(x::Array{Float64}, cx::Array{Float64}, fileName::String="cx.txt")
    if isempty(x)
       println("Writing to ", fileName, " terminated.\nMatrix x is empty")
       exit()
    end

    if isempty(cx)
        println("Writing to ", fileName, " terminated.\nMatrix calculatedX is empty")
        exit()
    end

    
    normX::Float64 = norm(x)
    if 0.0 == normX
        approxError = "norm(x) is 0.0"
    else
        try
            approxError = norm(x - cx) / norm(x)
        catch exception
            if exception isa DimensionMismatch
                println("Dimension of matrix calulatedX differ from x = [1..1]Transposed (dim(x) = ", length(x))
                exit()
            end
        end
    end

    stream = open(fileName, "w")

    write(stream, string(approxError))
    write(stream, "\n")
    for CXi in cx
        write(stream, string(CXi))
        write(stream, "\n")
    end

    close(stream)
end

function WriteX(x::Array{Float64}, fileName::String="cx.txt")
    if isempty(x)
       println("Writing to ", fileName, " terminated.\nMatrix x is empty")
       exit()
    end
  
    stream = open(fileName, "w")

    for Xi in x
        write(stream, string(Xi))
        write(stream, "\n")
    end

    close(stream)
end

#dim_A, dim_Ak, I, J, Aij = GatherDataForMatrixA("A.txt");

#dim_b, B = GatherDataForMatrixB("b.txt");

#WriteX([1.0,2.0,3.0])

