
function a()
    br = [-0.1, -12, -3, -32]

    b(br, sor)

    println("in a: ", br)
end

function b(vect, sorter)
    sor(vect)
    println("in b: ", vect)
end

function sor(vect)
    sort!(vect)
    println("in sor: ", vect)
end



function relation(s)
    return true
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

function test()
    tab = retCollectionInRelation(relation, [1.0, 2.0, 3.0, 4.0])

end


test()


#a()