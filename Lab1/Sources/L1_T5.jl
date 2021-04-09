

include("../decorators/decor_L1_T5.jl")


function prodOutcomeScalarProduct(cptFunction, vectors, exactScalarProduct)
    decoratorInputScalarProductType(vectors, cptFunction)

    dimension = length(vectors[1])
    scalarProduct = cptFunction(vectors, dimension)

    decoratorScalarProductCmp(scalarProduct, exactScalarProduct)
end

function cptForward(vectors, dimension)
    if false == isRightDimension(vectors, dimension)
        return NaN
    end
    vectorX = vectors[1]
    vectorY = vectors[2]

    sum::eltype(vectorX) = 0.0
    for i = 1:dimension
        sum = sum + vectorX[i] * vectorY[i]
    end

    return sum
end

function cptBackward(vectors, dimension)
    if false == isRightDimension(vectors, dimension)
        return NaN
    end
    vectorX = vectors[1]
    vectorY = vectors[2]

    sum::eltype(vectorX) = 0.0
    for i = dimension:-1:1
        sum = sum + vectorX[i] * vectorY[i]
    end

    return sum
end

function cptBiggestToSmallest(vectors, dimension)
    if false == isRightDimension(vectors, dimension)
        return NaN
    end

    vectorX = vectors[1]
    vectorY = vectors[2]

    partialSumsStorage = zeros(eltype(vectorX), 1, length(vectorX)) #fill array with 0.0
    for i = 1:dimension
        partialSumsStorage[i] = vectorX[i] * vectorY[i]
    end

    #BiggestPositive, SmallestPositive, BiggestNegative, SmallestNegative,
    sum::eltype(vectorX) = sumInSortedOrderPosNeg(partialSumsStorage, sortBigToSmall, sortSmallToBig)

    return sum
end

function sumInSortedOrderPosNeg(partialSumsStorage, sortPositive, sortNegative)
    positiveSumsCollection = retCollectionInRelation(lessThanZero, partialSumsStorage)
    negativeSumsCollection = retCollectionInRelation(moreThanAndZero, partialSumsStorage)

    #sort!() sorts in place
    #sort!(positiveSumsCollection, rev=true)
    #sort!(negativeSumsCollection)

    sortPositive(positiveSumsCollection)
    sortNegative(negativeSumsCollection)

    lenNegativeSumsCollection = length(negativeSumsCollection)
    lenPositiveSumsCollection = length(positiveSumsCollection)

    sum::eltype(partialSumsStorage[1]) = 0.0
    for i = 1:lenPositiveSumsCollection
        sum = sum + positiveSumsCollection[i]
    end

    for i = 1:lenNegativeSumsCollection
        sum = sum + negativeSumsCollection[i]
    end

    return sum
end

function cptSmallestToBiggest(vectors, dimension)
    if false == isRightDimension(vectors, dimension)
        return NaN
    end

    vectorX = vectors[1]
    vectorY = vectors[2]

    partialSumsStorage = zeros(eltype(vectorX), 1, length(vectorX)) #fill array with 0.0
    for i = 1:dimension
        partialSumsStorage[i] = vectorX[i] * vectorY[i]
    end

    #BiggestPositive, SmallestPositive, BiggestNegative, SmallestNegative,
    sum::eltype(vectorX) = sumInSortedOrderPosNeg(partialSumsStorage, sortSmallToBig, sortBigToSmall)
    
    return sum
end

function sortBigToSmall(collection)
    sort!(collection, rev=true)
end

function sortSmallToBig(collection)
    sort!(collection)
end

function retCollectionInRelation(relation, storageArray)
    lenStorageArray = length(storageArray)
    if lenStorageArray <= 0
        return nothing
    end

    firstInRelation = true # flag to initialize collection at index 1 with real argument
    collection = zeros(eltype(storageArray[1]), 1) #initialize collection with 0 of given type
    for i = 1:lenStorageArray
        if true == relation(storageArray[i])
            if true == firstInRelation
                firstInRelation = false
                collection[1] = storageArray[i]

            else
                append!(collection, storageArray[i])

            end
        end
    end

    return collection
end

function lessThanZero(argument)
    relation = false
    if argument < 0.0
        relation = true
    end

    return relation
end

function moreThanAndZero(argument)
    relation = false
    if argument >= 0.0
        relation = true
    end

    return relation
end

function isRightDimension(vectors, dimension)
    rightDimension = true
    
    lenX = length(vectors[1])
    lenY = length(vectors[2])

    if lenX != lenY
        decoratorWrongVectorLength()
        rightDimension = false 
    end

    if  lenX < dimension || lenY < dimension
        decoratorWrongVectorDimension()
        rightDimension = false
    end

    return rightDimension
end