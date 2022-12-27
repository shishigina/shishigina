include("Functions.jl")
function putmarker_at_border_and_back!(r::Robot, side::HorizonSide, n_steps)
    n_steps = 0 
    if !isborder(r, side)
        move!(r, side)
        n_steps += 1
        putmarker_at_border_and_back!(r, side, n_steps)
    else
        putmarker!(r)
        along!(r, inverse_side(side), n_steps)
    end
end

