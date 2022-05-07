#!/usr/bin/env julia
# -*- coding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4 ft=julia

# author : Prakash [प्रकाश]
# date   : 2022-02-05 14:43
#
using Plots

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
