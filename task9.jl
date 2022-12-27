function mark_chess!(r::Robot)

    steps = get_left_down_!(r)
    to_mark = (steps[1] + steps[2]) % 2 == 0
    steps_to_ost_border = move_until_border!(r, Ost)
    move_until_border!(r, West)
    last_side = steps_to_ost_border % 2 == 1 ? Sud : Nord

    side = Nord

    while !isborder(r, Ost)

        while !isborder(r, side)
            if to_mark
                putmarker!(r)
            end

            move!(r, side)
            to_mark = !to_mark
        end

        if to_mark
            putmarker!(r)
        end

        move!(r, Ost)
        to_mark = !to_mark

        side = inverse_side(side)
    end

    while !isborder(r, last_side)

        while !isborder(r, side)
            if to_mark
                putmarker!(r)
            end

            move!(r, side)
            to_mark = !to_mark
        end

        if to_mark
            putmarker!(r)
        end

    end

    get_left_down_!(r)
    get_to_origin!(r, steps)
end
function get_left_down_!(r::Robot)::NTuple{2, Int}
    steps_to_left_border = move_until_border!(r, West)
    steps_to_down_border = move_until_border!(r, Sud)
    return (steps_to_down_border, steps_to_left_border)
end
function move_until_border!(r::Robot, side::HorizonSide)::Int
    n_steps = 0
    while !isborder(r, side)
        n_steps += 1
        move!(r, side)
    end
    return n_steps
end
function inverse_side(side::HorizonSide)::HorizonSide
    inv_side = HorizonSide((Int(side) + 2) % 4)
    return inv_side
end
function get_to_origin!(r::Robot, steps_to_origin::NTuple{2, Int})
    for (i, side) in enumerate((Nord, Ost))
        moves!(r, side, steps_to_origin[i])
    end
end
function moves!(r::Robot, sides, n_steps::Int)
    for _ in 1:n_steps
        move!(r, sides)
    end
end