function cross!(r)
    for side in (HorizonSide(i) for i in 0:3)
        n=numsteps_putmarkers!(r, side)
        along!(r, inverse(side), n)
    end
    putmarker!(r)
end 
function numsteps_putmarkers!(r, side)
    num_steps=0
    while !isborder(r, side)
        move!(r, side)
        num_steps+=1
        putmarker!(r)
    end
    return num_steps 
end 
inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2, 4))
along!(r, side, n) = for _ in 1:n move!(r, side) end