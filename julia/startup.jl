include("github_token.jl")

atreplinit() do repl
  try
    @info "importing Revise"
    @eval using Revise
    @async Revise.wait_steal_repl_backend()
  catch e
    @error "error while importing Revise" e
  end

  try
    @info "importing OhMyREPL"
    @eval using OhMyREPL
  catch e
    @error "error while importing OhMyREPL" e
  end

  # @info "importing SparseArrays"
  # using SparseArrays
  # function spy(A::AbstractSparseMatrix)
  #   nrows, ncols = size(A)
  #   rows, cols, vals = findnz(A)
  #   avals = abs.(vals)
  #   drawgrid(false)
  #   scatter(cols, rows,
  #           50 * ones(length(rows)),        # symbol size
  #           255 * avals ./ maximum(avals),  # symbol color
  #           xlim=(1, ncols),
  #           ylim=(1, nrows),
  #           yflip=true,                     # flip y axis
  #          )
  # end
end

function run_shell_cmd(cmd::Cmd)
  out = Pipe()
  err = Pipe()

  process = run(pipeline(cmd, stdout=out, stderr=err), wait=false)
  close(out.in)
  close(err.in)

  stdout = @async String(read(out))
  stderr = @async String(read(err))
  wait(process)
  return (
    stdout = fetch(stdout),
    stderr = fetch(stderr),
    code = process.exitcode
  )
end
