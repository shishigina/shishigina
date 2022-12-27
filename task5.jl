function mark_frames!(r::Robot)
    steps = get_left_down!(r)

    while isborder(r, Sud) && !isborder(r, Ost)
        move_until_border!(r, Nord)
        move!(r, Ost)
        while !isborder(r, Ost) && move_if_possible!(r, Sud) end
    end

    for sides in [(Sud, Ost), (Ost, Nord), (Nord, West), (West, Sud)]
        side_to_move, side_to_border = sides
        while isborder(r, side_to_border)
            putmarker!(r)
            move!(r, side_to_move)
        end
        putmarker!(r)
        move!(r, side_to_border)
    end

    get_left_down!(r)
    way_back!(r, steps)
    frame!(r)
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
function move_if_possible!(r::Robot, side::HorizonSide)::Bool
    if !isborder(r, side)
        move!(r, side)
        return true
    end
    return false
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

function way!(r::Robot, path::Vector{Tuple{HorizonSide, Int}})
    for step in path
        moves!(r, step[1], step[2])
    end
end

function way_back!(r::Robot, path::Vector{Tuple{HorizonSide, Int}})
    inv_path = inversed_path(path)
    way!(r, inv_path)
end
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