try
  @info "importing Revise"
  @eval using Revise
catch
  @warn "error while importing Revise"
end
