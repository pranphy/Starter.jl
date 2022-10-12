using Plots
using StatsBase
using LsqFit

export plot!, plot, fit_func

function gaussian(x,p)
    A,μ,σ = p[1],p[2],p[3]
    A .* exp.( .- 0.5 * ((x .- μ) ./ σ ) .^ 2)
end

const Hist1D = Histogram{T,1} where T<:Real
const Hist2D = Histogram{T,2} where T<:Real

const defaultsize = (600,400)

# 1D histogram plot
function get_steps(hist::Hist1D)
    he = collect(hist.edges[1])
    hv = collect(hist.weights)
    X = collect(Iterators.flatten([(he[i],he[i+1])  for i in 1:(length(he)-1)]))
    Y = collect(Iterators.flatten(map(x-> (x,x),hv)))
    return X,Y
end

function get_xy(hist::Hist1D)
    he = collect(hist.edges[1])
    hc = ( he[2:end] + he[1:end-1] ) ./ 2
    hv = collect(hist.weights)
    return hc,hv
end

function fit_func(hist::Hist1D;func=gaussian,p0=[1.0,0.0,1.0])
    x,y = get_xy(hist)
    p = curve_fit(func,x,y,p0)
    xgrid = range(minimum(x),maximum(x),100)
    fity  = func(xgrid,p.param)
    return xgrid,fity, p
end

#function plot!(hist::Hist1D;label=nothing,steps=true,ebar=false,xlabel=nothing,ylabel=nothing,title=nothing,filled=false)
function Plots.plot!(hist::Hist1D;label=nothing,steps=true,ebar=false,filled=false)
    X,Y = get_steps(hist)
    fr =  filled ? zeros(size(Y)) : nothing
    p = Plots.plot!(X,Y,fillrange=fr,label=label)
    if ebar
        hc,hv = get_xy(hist)
        error = hv ./ sqrt(length(hv))
        scatter!(hc,hv,yerr=error,label=nothing)
    end
    return p
end

function Plots.plot(hist::Hist1D;size=defaultsize,kwargs...)
    p = Plots.plot(size=size,label=nothing)
    Plots.plot!(hist;kwargs...)
end

# 2D histogram plotting
function Plots.plot!(hist::Hist2D;cbarlabel=nothing,kwargs...)
    xe = collect(hist.edges[1])
    ye = collect(hist.edges[2])
    mid(x) = (x[2:end] + x[1:end-1])/2.0
    Plots.heatmap!(mid(xe),mid(ye),hist.weights';kwargs...)
end

function Plots.plot(hist::Hist2D;size=defaultsize,kwargs...)
    p = Plots.plot(size=size,label=nothing)
    Plots.plot!(hist;kwargs...)
end
