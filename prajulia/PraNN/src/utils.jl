export S, S′, squish, diffsq
S(x) = 1 ./ (1 .+ exp.(-x))
S′(x) = exp.(-x) ./ ( 1 .+ exp.(-x)).^2
#S(x) = 1.0*x
#S′(x) = 1.0

×(x1,x2) = [[i;j] for i in x1 for j in x2]

function diffsq(y,ŷ)
    sum((y - ŷ) .^2)
end


function squish(nn)
    Wc = nn.W[2]' * nn.W[1]'
    bc = nn.W[2]' * nn.b[1] + nn.b[2]
    Wc,bc
end
