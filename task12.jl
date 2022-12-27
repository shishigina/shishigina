function num_horizontal_borders!(robot)
    back_path = get_left_down!(robot)
    side = Ost
    num_borders = num_horizontal_borders!(robot, side)
    while !isborder(robot, Nord)
        move!(robot, Nord)
        side = inverse(side)
        num_borders += num_horizontal_borders!(robot,side)
    end
    get_left_down!(robot)
    way_back!(robot, back_path)
    return num_borders
end
function num_horizontal_borders!(robot, side) 
    max_cells = 0
    num_borders = 0
    state = 0
    while !isborder(robot, side)
        move!(robot, side) 
        if state == 0
            if isborder(robot, Nord) == true
                state = 1 
            end
        else 
            if isborder(robot, Nord) == false
                if max_cells == 0 
                    state = 1
                    max_cells += 1
                else
                    state = 0
                    num_borders += 1
                    max_cells=0
                end 
            end
        end
    end 
    return num_borders
end
inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2, 4))

function get_left_down!(robot::Robot)::Vector{Tuple{HorizonSide, Int}}
    steps = []
    while !(isborder(robot, West) && isborder(robot, Sud))
        steps_to_West = move_until_border!(robot, West)
        steps_to_Sud = move_until_border!(robot, Sud)
        push!(steps, (West, steps_to_West))
        push!(steps, (Sud, steps_to_Sud))
    end
    return steps
end
function move_until_border!(robot::Robot, side::HorizonSide)::Int
    n_steps = 0
    while !isborder(robot, side)
        n_steps += 1
        move!(robot, side)
    end
    return n_steps
end
function way!(robot::Robot, path::Vector{Tuple{HorizonSide, Int}})
    for step in path
        moves!(robot, step[1], step[2])
    end
end

function way_back!(robot::Robot, path::Vector{Tuple{HorizonSide, Int}})
    inv_path = inversed_path(path)
    way!(robot, inv_path)
end
function moves!(robot::Robot, sides::NTuple{2, HorizonSide}, n_steps::Int)
    for _ in 1:n_steps
        move!(robot, sides[1])
        move!(robot, sides[2])
    end
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