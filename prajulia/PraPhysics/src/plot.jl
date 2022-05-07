using Plots
using StatsBase

function get_steps(hist::Histogram)
    he = collect(hist.edges[1])
    hv = collect(hist.weights)
    X = collect(Iterators.flatten([(he[i],he[i+1])  for i in 1:(length(he)-1)]))
    Y = collect(Iterators.flatten(map(x-> (x,x),hv)))
    return X,Y
end

function plot!(hist::Histogram;label=nothing,steps=true,ebar=false,xlabel="",ylabel="",title="")
    X,Y = get_steps(hist)
    p = Plots.plot!(X,Y,label=label,xlabel=xlabel,ylabel=ylabel,title=title)
    if ebar
        he = collect(hist.edges[1])
        hv = collect(hist.weights)
        xc = (he[2:end] .+ he[1:end-1]) ./2
        error = hv ./ sqrt(length(hv))
        scatter!(xc,hv,yerr=error,label=nothing)
    end
    return p
end

function plot(hist::Histogram;label=nothing,steps=true,ebar=false,xlabel="",ylabel="",title="")
    p = Plots.plot(size=(600,400),label=nothing)
    plot!(hist;label,steps,ebar,xlabel,ylabel,title)
end


