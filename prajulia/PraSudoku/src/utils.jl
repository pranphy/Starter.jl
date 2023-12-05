#!/usr/bin/env julia
# -*- coding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4 ft=julia

# author : Prakash [प्रकाश]
# date   : 2022-02-05 14:43
#
using Plots

function print(A::Sudoku)
    # onine = [1,2,3,4,5,6,7,8,9]
    cnt = 0
    for i in 1:9
        for j in 1:9
            cnt = cnt + (length(A.val[i,j])  > 1 ? 0 : 1)
            v = length(A.val[i,j]) > 1 ? " " : A.val[i,j][1]
            Base.print(" $v ")
        end
        Base.print("\n")
    end
    Base.print(" $cnt filled out of 81 \n")
end

function get_grid()
    plot(;size=(400,400),xlims=(0.,9.0),ylims=(0.,9.0),axis=nothing,legend=nothing)
end

function show(A::Sudoku,p)
    vline!(p,[0],lw=3,color=:black)
    hline!(p,[0],lw=3,color=:black)
    T = A.val

    for i= 1:9, j = 1:9
        vline!(p,[i],lw= i%3 == 0 ? 3 : 1,color=:black)
        hline!(p,[i],lw= i%3 == 0 ? 3 : 1,color=:black)
        val = length(T[j,i]) > 1 ? " " : T[j,i][1]
        txt = text("$(val==0 ? " " : val)",14,:red,:center)
        plot!(p,annotations=(10-j-.5,i-.5,txt))
        #txt = text("$(val==0 ? " " : val)",14,:red,:center)
        #plot!(p,annotations=(10-i-.5,j-.5,txt))
    end
    return p
end

# (1,1) -> (9,1)
# (1,2) -> (8,1)
# (1,3) -> (7,1)
# (2,1) -> (9,2)
# (3,1) -> (9,3)
# (1,3) -> (7,1)
