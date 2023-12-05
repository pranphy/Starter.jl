#!/usr/bin/env julia
# -*- coding: utf-8 -*-
# vim: ai ts=4 sts=4 et sw=4 ft=julia

# author : Prakash [प्रकाश]
# date   : 2020-08-08 23:03

struct Sudoku
    val::Array{Array{Int64,1},2}
end


function construct(A::Array{Int64,2})
    onine = [1,2,3,4,5,6,7,8,9]
    B = fill(onine,(9,9))
    for i in 1:9
        for j in 1:9
            B[i,j] = A[i,j] == 0 ? onine : [A[i,j]]
        end
    end
    return Sudoku(B)
end

function construct()
    A = fill(0,(9,9))
    construct(A)
end

function get_definite(A::Array{Array{Int64,1}})
    [length(x) == 1 ? x[1] : 0 for x in vec(A)]
end

function get_row(A::Sudoku,i)
    #view(A.val,i,:)
    row = A.val[i,:]
    reshape(row,length(row),1)
end


function get_col(A::Sudoku,i)
    #view(A.val,:,i)
    col = A.val[:,i]
    #A.val[:,i]
    reshape(col,length(col),1)
end


function get_cell(A::Sudoku,i,j)
    celli = (i-1) ÷ 3
    cellj = (j-1) ÷ 3
    crm, crx = 3celli + 1, 3celli  + 3
    ccm, ccx = 3cellj + 1, 3cellj  + 3
    #view(A.val,crm:crx,ccm:ccx)
    A.val[crm:crx,ccm:ccx]
end

function union_except(array::Array{Array{Int64,1}},a::Int64,b::Int64)
    un = Array{Int64,1}(undef,1)
    r,c = size(array)
    for i ∈ 1:r , j ∈ 1:c
        if i != a || j != b
            union!(un,array[i,j])
        end
    end
    return un
end


function find_unique_if_any(A::Array{Array{Int64,1}})
    r,c = size(A)
    for i ∈ 1:r, j ∈ 1:c
        any_left = setdiff(A[i,j],union_except(A,i,j))
        if length(any_left) == 1
           return true, i,j, any_left
        end
    end
    return false, 0 , 0 , [0]
end



function solveiterate!(S::Sudoku)
    for i in 1:9
        for j in 1:9
            cellval = S.val[i,j]
            if length(cellval) > 1
                row_definite = get_definite(get_row(S,i))
                col_definite = get_definite(get_col(S,j))
                cell_definite = get_definite(get_cell(S,i,j))
                definite = union(row_definite,col_definite,cell_definite)
                left = setdiff(cellval,definite)
                S.val[i,j] = left

                #if length(left) > 1
                #    success,i,j,unique = find_unique_if_any(get_row(S,i))
                #    if success
                #        S.val[i,j] = unique
                #    end
                #    #replace_unique_if_any!(get_row(S,i))
                #    #replace_unique_if_any!(get_col(S,j))
                #    #replace_unique_if_any!(get_cell(S,i,j))
                #end
            end
        end
    end
end
