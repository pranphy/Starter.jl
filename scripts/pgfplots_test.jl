using PGFPlots

x = [1,2,3,4,5,6]
y = sin.(x)
#plot(x,y)
#print(tikzCode(x,y))
#xlabel!("Hello")
#save("first_julia_tex.tex")
pushPGFPlotsOptions("scale=1.5")
a = Axis(PGFPlots.Linear(x, y, legendentry="My Plot"), xlabel="X", ylabel="Y", title="My Title")
save("../images/second_julia_tex.tex",a)