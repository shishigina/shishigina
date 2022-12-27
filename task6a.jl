function mark_perimetr!(r::Robot) 
    path = get_left_down!(r)
    mark!(r)
    way_back!(r, path)
end

function get_left_down!(r::Robot)::Vector{Tuple{HorizonSide, Int}}
    steps = []
    while !(isborder(r, West) && isborder(r, Sud))
        steps_to_West = move_until_border!(r, West)
        steps_to_Sud = move_until_border!(r, Sud)
        push!(steps, (West, steps_to_West))
        push!(steps, (Sud, steps_to_Sud))
    end
    return steps
end
function move_until_border!(r::Robot, side::HorizonSide)::Int
    n_steps = 0
    while !isborder(r, side)
        n_steps += 1
        move!(r, side)
    end
    return n_steps
end
function mark!(r::Robot)
    steps_to_left_down = [0, 0]
    steps_to_left_down[1] = move_until_border!(r, Sud)
    steps_to_left_down[2] = move_until_border!(r, West)
    for side in (Nord, Ost, Sud, West)
        putmarkers_until_border!(r, side)
    end
    moves!(r, Ost, steps_to_left_down[2])
    moves!(r, Nord, steps_to_left_down[1])
end
function way!(r::Robot, path::Vector{Tuple{HorizonSide, Int}})
    for step in path
        moves!(r, step[1], step[2])
    end
end

function way_back!(r::Robot, path::Vector{Tuple{HorizonSide, Int}})
    inv_path = inversed_path(path)
    way!(r, inv_path)
end
function moves!(r::Robot, sides::NTuple{2, HorizonSide}, n_steps::Int)
    for _ in 1:n_steps
        move!(r, sides[1])
        move!(r, sides[2])
    end
end
function putmarkers_until_border!(r::Robot, side::HorizonSide)::Int
    n_steps = 0
    while !isborder(r, side) 
        move!(r, side)
        putmarker!(r)
        n_steps += 1
    end 
    return n_steps
end
function inversed_path(path::Vector{Tuple{HorizonSide, Int}})::Vector{Tuple{HorizonSide, Int}}
    inv_path = []
    for step in path
        inv_step = (inverse_side(step[1]), step[2])
        push!(inv_path, inv_step)
    end
    reverse!(inv_path)
    return inv_path
end

function moves!(r::Robot, side::HorizonSide, n_steps::Int)
    for i in 1:n_steps
        move!(r, side)
    end
end
