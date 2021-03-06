function add_daughter!(m::AbstractMultiScaleArrayHead,x::AbstractMultiScaleArray)
  push!(m.x,x)
  if !isempty(m.y)
    m.end_idxs[end] = m.end_idxs[end-1]+length(x)
    push!(m.end_idxs,m.end_idxs[end]+length(y))
  else
    push!(m.end_idxs,m.end_idxs[end]+length(x))
  end
  nothing
end

function __add_daughter!(m::AbstractMultiScaleArray,x::AbstractMultiScaleArray,i,I::Int...)
  __add_daughter!(m.x[i],x,I...)
  for j = i:num_daughters(m)
    m.end_idxs[j]  += length(x)
  end
  if !isempty(m.y)
    m.end_idxs[end]  += length(x)
  end
  nothing
end

function __add_daughter!(m::AbstractMultiScaleArray,x::AbstractMultiScaleArray)
  push!(m.x,x)
  if !isempty(m.y)
    m.end_idxs[end] = m.end_idxs[end-1]+length(x)
    push!(m.end_idxs,m.end_idxs[end]+length(y))
  else
    push!(m.end_idxs,m.end_idxs[end]+length(x))
  end
  nothing
end

function __add_daughter!(m::AbstractMultiScaleArray,x::AbstractMultiScaleArray,i::Int)
  __add_daughter!(m.x[i],x)
  for j = i:num_daughters(m)
    m.end_idxs[j]  += length(x)
  end
  if !isempty(m.y)
    m.end_idxs[end]  += length(x)
  end
  nothing
end

function add_daughter!(m::AbstractMultiScaleArrayHead,x::AbstractMultiScaleArray,i::Int)
  __add_daughter!(m.x[i],x)
  for j = i:num_daughters(m)
    m.end_idxs[j]  += length(x)
  end
  if !isempty(m.y)
    m.end_idxs[end]  += length(x)
  end
  nothing
end

function add_daughter!(m::AbstractMultiScaleArrayHead,x::AbstractMultiScaleArray,i,I::Int...)
  __add_daughter!(m.x[i],x,I...)
  for j = i:num_daughters(m)
    m.end_idxs[j]  += length(x)
  end
  if !isempty(m.y)
    m.end_idxs[end]  += length(x)
  end
  nothing
end

function __remove_daughter!(m::AbstractMultiScaleArray,i::Int)
  del_length = length(m.x[i])
  deleteat!(m.x,i); deleteat!(m.end_idxs,i)
  for j = i:num_daughters(m)
    m.end_idxs[j] -= del_length
  end
  if !isempty(m.y)
    m.end_idxs[end]  -= del_length
  end
  del_length
end

function remove_daughter!(m::AbstractMultiScaleArrayHead,i::Int)
  del_length = length(m.x[i])
  deleteat!(m.x,i); deleteat!(m.end_idxs,i)
  for j = i:num_daughters(m)
    m.end_idxs[j] -= del_length
  end
  if !isempty(m.y)
    m.end_idxs[end]  -= del_length
  end
  nothing
end

function __remove_daughter!(m::AbstractMultiScaleArrayLeaf,i::Int)
  deleteat!(m.x,i)
  1
end

function remove_daughter!(m::AbstractMultiScaleArrayHead,i,I::Int...)
  del_length = __remove_daughter!(m.x[i],I...)
  for j = i:num_daughters(m)
    m.end_idxs[j] -= del_length
  end
  if !isempty(m.y)
    m.end_idxs[end]  -= del_length
  end
  if size(m.x[i].x) == (0,)
    deleteat!(m.x,i)
    deleteat!(m.end_idxs,i)
  end
  nothing
end

function __remove_daughter!(m::AbstractMultiScaleArray,i,I::Int...)
  del_length = __remove_daughter!(m.x[i],I...)
  for j = i:num_daughters(m)
    m.end_idxs[j] -= del_length
  end
  if !isempty(m.y)
    m.end_idxs[end]  -= del_length
  end
  if length(m.x[i]) == 0
    deleteat!(m.x,i)
  end
  del_length
end
