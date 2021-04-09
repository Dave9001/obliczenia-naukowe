using Distributed
function f(x)
     if x == 1
        print("tak")
    else
        print("nie")
    end

end

@distributed for N in 1:5:20
    f(N)
end
