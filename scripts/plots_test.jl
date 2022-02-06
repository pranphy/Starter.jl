using Plots
gr()
theme(:juno)
medium = [
    6 0 0 4 0 5 9 9 9;
    0 0 2 0 7 0 5 0 0;
    5 7 0 2 0 1 0 3 4;
    0 0 0 0 0 0 0 0 0;
    3 0 9 0 5 0 8 0 7;
    0 0 0 0 4 0 0 0 0;
    4 3 7 0 0 0 6 0 3;
    0 3 0 0 9 0 0 2 0;
    0 0 0 8 0 7 0 0 0;
    ]

function plotit()
    p = plot(xlims=(0,9),ylims=(0,9),axis=nothing,size=(400,400),legend=nothing)
    vline!(p,[1],color=:black)
    for i= 1:9, j = 1:9
        vline!(p,[i],color=:black)
        hline!(p,[i],color=:black)
        if i % 3 == 0
            vline!(p,[i],lw=3,color=:black)
            hline!(p,[i],lw=3,color=:black)
        end
        val = medium[i,j]
        txt = Plots.text("$(val==0 ? " " : val)",14,:red,:center)
        plot!(p,annotations=(i-.5,j-.5,txt))
    end
end
plotit()
savefig("images/Terau.png")
