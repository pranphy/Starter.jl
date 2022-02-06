module PraSudoku

include("solve.jl")
include("utils.jl")

export Sudoku, display, construct, solveiterate!
export show # from utils depends on plots

end # module
