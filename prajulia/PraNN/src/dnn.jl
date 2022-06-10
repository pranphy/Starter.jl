using Distributions
export NN
export feed!, fit!, train!,loss
struct NN
    W::Vector{Matrix{Float64}}
    b::Vector{Vector{Float64}}
    z::Vector{Vector{Float64}} # for speeding things up
    a::Vector{Vector{Float64}} # for speeding things up
    function NN(idim::Int64,odim::Int64;hl=[2])
        Wt,bt = [],[]
        p = idim 
        for l in vcat(hl,odim)
            d = Normal(0,1/l)
            Wl = rand(d,p,l) .* 0.1
            bl = vec(rand(Normal(0,1),l)) .* 0.1
            push!(Wt,Wl)
            push!(bt,bl)
            p = l
        end
        zt = Vector{Vector{Float64}}(undef,length(bt))
        at = Vector{Vector{Float64}}(undef,length(bt)+1)
        new(Wt,bt,zt,at)
      end
     function NN(Ws::Vector,Bs::Vector)
        zs = Vector{Vector{Float64}}(undef,length(bs))
        as = Vector{Vector{Float64}}(undef,length(bs)+1)
        new(Ws,bs,zs,as)
    end
end 

Base.show(io::IO, t::NN) = print(io,"NN $(length(t.W)-1) hidden layers" )


function feed!(nn::NN,x::Vector{Float64},σ=S)
    #print(x,W,b)
    nn.a[1] = x
    for ly in 1:length(nn.W)
        nn.z[ly] = nn.W[ly]' * nn.a[ly] + nn.b[ly]
        nn.a[ly+1] = σ(nn.z[ly])
    end
    return nn.a[end]
end


function backprop!(nn::NN,x,y,β,σ′=S′) 
    ∇L = (nn.a[end] - y)
    δp = ∇L 
    for lr = length(nn.W):-1:1
        δc = δp .* σ′(nn.z[lr])
        nn.W[lr] -= β .*  nn.a[lr] * δc'
        nn.b[lr] -= β .* δc
        δp =  nn.W[lr] * δc
    end
end

function train!(nn::NN,x,y,β) 
    feed!(nn,x)  
    # Calculate error
    backprop!(nn,x,y,β)
    ŷ = feed!(nn,x)
    return ŷ
end


function fit!(tnn,X,y;β=9e-3,epoch=50)
    errs = []
    for n in 1:epoch
        for (i,(x,y)) ∈ enumerate(zip(X,y))
            ŷ = train!(tnn,x,y,β)
            cerror = diffsq(y,ŷ)
            push!(errs,cerror)
        end
    end
    return errs
end
