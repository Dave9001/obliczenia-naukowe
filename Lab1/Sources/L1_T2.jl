
include("../decorators/decor_L1_T2.jl")


function prodOutcomeKahanTest(dataType)

    kahanMacheps = kahanEquationDataTypeConverter(dataType)
    juliaMacheps = eps(dataType)

    decoratorKahanTest(kahanMacheps, juliaMacheps)
end

function kahanEquationDataTypeConverter(dataType)
    return (dataType(3.0) * (dataType(4.0) / dataType(3.0) -dataType(1.0)) - dataType(1.0))
end



