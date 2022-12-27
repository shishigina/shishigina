function mark_x!(r::Robot)
    sides = (Nord, Ost, Sud, West)
    for i in 1:4
        first_side = sides[i]
        second_side = sides[i % 4 + 1]
        direction = (first_side, second_side)
        n_steps = putmarkers_until_border!(r, direction)
        moves!(r, inverse_side(direction), n_steps)
    end
    putmarker!(r)
end
function moves!(r::Robot, sides, n_steps::Int)
    for _ in 1:n_steps
        move!(r, sides[1])
        move!(r, sides[2])
    end
end
function putmarkers_until_border!(r::Robot, sides)
    n_steps = 0
    while !isborder(r, sides[1]) && !isborder(r, sides[2])
        n_steps += 1
        move!(r, sides[1])
        move!(r, sides[2])
        putmarker!(r)
    end
    return n_steps
end
function inverse_side(sides::NTuple{2, HorizonSide})
    new_sides = (inverse_side(sides[1]), inverse_side(sides[2]))
    return new_sides
end

