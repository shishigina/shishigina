function markers!(r)
    n1=ishod1!(r, West)
    n2=ishod2!(r, Sud)
    putmarker!(r)
    side=Ost
    row!(r, side)
    while !isborder(r, Nord)
        move!(r, Nord)
        putmarker!(r)
        side=inverse(side)
        while !isborder(r, side)
            row!(r, side)
        end 
    end 
    along1!(r, Ost, n1) 
    along2!(r, Nord, n2)
end 
function ishod1!(r, West)
    n1=0
    while !isborder(r, West)
        move!(r, West)
        n1+=1
    end
    return n1
end 
    
function ishod2!(r, Sud)
    n2=0
    while !isborder(r, Sud)
        move!(r, Sud)
        n2+=1
    end
    return n2
end 
function row!(r, side)
    while !isborder(r, side)
        move!(r, side)
        putmarker!(r)
    end 
end
along1!(r, Ost, n1) = for _ in 1:n1 move!(r, Ost) end
along2!(r, Nord, n2) = for _ in 1:n2 move!(r, Nord) end
inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2, 4))