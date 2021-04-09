###############################################################################
#
#	@brief:  	Source code for laboratory list number 1.
#
###############################################################################

function decorator_L3_T4_printOutFunctionsOutput(functionName, output)
    println("metoda: ", functionName,   "\n",
            "r:   ",    output[1],      "\n",
            "v:   ",    output[2],      "\n",
            "it:  ",    Int(output[3]), "\n",
            "err: ",    Int(output[4]), "\n")
end
