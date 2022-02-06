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

    for i= 9:-1:1, j = 9:-1:1
        vline!(p,[i],lw= i%3 == 0 ? 3 : 1,color=:black)
        hline!(p,[i],lw= i%3 == 0 ? 3 : 1,color=:black)
        val = length(A.val[j,i]) > 1 ? " " : A.val[j,i][1]
        txt = text("$(val==0 ? " " : val)",14,:red,:center)
        plot!(p,annotations=(i-.5,j-.5,txt))[1]
        txt = text("$(val==0 ? " " : val)",14,:red,:center)
        plot!(p,annotations=(i-.5,j-.5,txt))
    end
    return p
end
