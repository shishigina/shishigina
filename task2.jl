function frame!(r)
    n1=ishod1!(r, Ost)
    n2=ishod2!(r, Sud)
    for side in (HorizonSide(i) for i in 0:3)
        put_markers!(r, side)
    end 
    along1!(r, Nord, n2)
    along2!(r, West, n1)
end 

function ishod1!(r, Ost)
    n1=0
    while !isborder(r, Ost)
        move!(r, Ost)
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

function put_markers!(r, side)
    while !isborder(r, side)
        move!(r, side)
        putmarker!(r)
    end 
end 
along1!(r, Nord, n2) = for _ in 1:n2 move!(r, Nord) end 
along2!(r, West, n1) = for _ in 1:n1 move!(r, West) end 








