using PraSudoku
#using Plots
#gr()

medium1 = [
    0 0 0 3 0 0 1 6 0;
    0 1 7 0 0 6 0 0 9;
    0 9 0 0 0 0 0 0 0;
    0 8 0 0 0 1 4 3 0;
    0 0 9 8 0 3 6 0 0;
    0 6 0 0 0 2 9 1 0;
    0 7 0 0 0 0 0 0 0;
    0 3 5 0 0 8 0 0 1;
    0 0 0 4 0 0 8 7 0;
]
medium = [
    6 0 0 4 0 5 0 0 1;
    0 0 2 0 7 0 5 0 0;
    5 7 0 2 0 1 0 3 4;
    0 0 0 0 0 0 0 0 0;
    3 0 9 0 5 0 8 0 7;
    0 0 0 0 4 0 0 0 0;
    4 0 7 0 0 0 6 0 9;
    0 3 0 0 9 0 0 2 0;
    0 0 0 8 0 7 0 0 0;
]
easy = [
    2 0 4 0 0 0 0 0 7;
    0 0 0 4 1 0 0 0 2;
    6 3 0 0 0 0 4 0 0;
    0 4 0 9 0 0 2 0 0;
    8 0 0 7 6 0 0 0 3;
    0 7 0 2 0 0 9 0 0;
    7 6 0 0 0 0 1 0 0;
    0 0 0 3 8 0 0 0 6;
    5 0 3 0 0 0 0 0 4;
]
initial = easy
#p = plot(xlims=(0,9),ylims=(0,9),axis=false,size=(400,400),legend=false)

A = construct(initial)
PraSudoku.display(A)
#PraSudoku.show(A,p)

solveiterate!(A)
PraSudoku.display(A)
#PraSudoku.show(A,p)
print(" ################## \n")

#anim = @animate for i ∈ 1:8
for i ∈ 1:8
    solveiterate!(A)
    PraSudoku.display(A)
end
#gif(anim, "images/jl_anim_sudoku.gif", fps = 1)

