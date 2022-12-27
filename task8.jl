function move_snake!(r::Robot)
    n_steps = 1
    cur_side = Ost
    counter = 1
    while true

        if moves_if_not_marker!(r, cur_side, n_steps)
            return
        end 

        cur_side = next_side(cur_side)

        if counter % 2 == 0
            n_steps += 1
        end

        counter += 1
    end
end

function move_if_not_marker!(r::Robot, side::HorizonSide)::Bool
    
    if !ismarker(r)
        move!(r, side)
        return false
    end

    return true
end

function moves_if_not_marker!(r::Robot, side::HorizonSide, n_steps::Int)::Bool

    for _ in 1:n_steps
        if move_if_not_marker!(r, side)
            return true
        end
    end
    
    return false
end

function next_side(side::HorizonSide)::HorizonSide
    return HorizonSide( (Int(side) + 1 ) % 4 )
end


