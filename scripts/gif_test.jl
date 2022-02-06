using Plots
gr()

p = plot(
    1,
    xlim=(0,7),
    ylim=(-1.5,1.5),
)
x = collect(0:2π:500)

@gif for i=1:100
    ω = 1/(101-i)
    y = sin.(ω * x)
    plot(x,y)
end every 5