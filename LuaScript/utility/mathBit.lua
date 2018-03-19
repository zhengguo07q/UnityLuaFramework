-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : mathBit.lua
--  Creator     : liyibao
--  Date        : 2017-8-3
--  Comment     :
-- ***************************************************************


module("mathBit", package.seeall)

data32={}

for i=1,32 do
    data32[i]=2^(32-i)
end

function d2b(arg)
    local   tr={}
    for i=1,32 do
        if arg >= data32[i] then
        tr[i]=1
        arg=arg-data32[i]
        else
        tr[i]=0
        end
    end
    return   tr
end   --d2b

function    b2d(arg)
    local   nr=0
    for i=1,32 do
        if arg[i] ==1 then
        nr=nr+2^(32-i)
        end
    end
    return  nr
end   --b2d

function    _xor(a,b)
    local   op1=d2b(a)
    local   op2=d2b(b)
    local   r={}

    for i=1,32 do
        if op1[i]==op2[i] then
            r[i]=0
        else
            r[i]=1
        end
    end
    return  b2d(r)
end --xor

function    _and(a,b)
    local   op1=d2b(a)
    local   op2=d2b(b)
    local   r={}
    
    for i=1,32 do
        if op1[i]==1 and op2[i]==1  then
            r[i]=1
        else
            r[i]=0
        end
    end
    return  b2d(r)
    
end --_and

function    _or(a,b)
    local   op1=d2b(a)
    local   op2=d2b(b)
    local   r={}
    
    for i=1,32 do
        if  op1[i]==1 or   op2[i]==1   then
            r[i]=1
        else
            r[i]=0
        end
    end
    return  b2d(r)
end --_or

function    _not(a)
    local   op1=d2b(a)
    local   r={}

    for i=1,32 do
        if  op1[i]==1   then
            r[i]=0
        else
            r[i]=1
        end
    end
    return  b2d(r)
end --_not

function    _rshift(a,n)
    local   op1=d2b(a)
    local   r=d2b(0)
    
    if n < 32 and n > 0 then
        for i=1,n do
            for i=31,1,-1 do
                op1[i+1]=op1[i]
            end
            op1[1]=0
        end
    r=op1
    end
    return  b2d(r)
end --_rshift

function    _lshift(a,n)
    local   op1=d2b(a)
    local   r=d2b(0)
    
    if n < 32 and n > 0 then
        for i=1,n   do
            for i=1,31 do
                op1[i]=op1[i+1]
            end
            op1[32]=0
        end
    r=op1
    end
    return  b2d(r)
end --_lshift


function    _print(tab)
    local   str=""
    for i=1,32 do
        str=str .. tab[i]
    end
    print(str)
end