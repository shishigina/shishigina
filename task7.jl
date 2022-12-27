function move_down!(r::Robot, side::HorizonSide)
    find!(r, side)
    move!(r, side)
end
function find!(r::Robot, side::HorizonSide)
    n_steps = 1
    ort_side = HorizonSide((Int(side) + 1) % 4)
    while isborder(r, side)
        moves!(r, ort_side, n_steps)
        n_steps += 1
        ort_side = inverse_side(ort_side)
    end
end

function moves!(r::Robot, sides, n_steps::Int)
    for _ in 1:n_steps
        move!(r, sides)
    end
end
function inverse_side(side::HorizonSide)::HorizonSide
    inv_side = HorizonSide((Int(side) + 2) % 4)
    return inv_side
end


