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
    @info "importing OhMyREPL (incl. fzf)"
    @eval using OhMyREPL
    @async begin
      # reinstall keybindings to work around https://github.com/KristofferC/OhMyREPL.jl/issues/166
      sleep(1)
      OhMyREPL.Prompt.insert_keybindings()
      OhMyREPL.enable_autocomplete_brackets(false)
    end
  catch e
    @error "error while importing OhMyREPL" e
  end

  try
    @info "importing InteractiveCodeSearch"
    @eval using InteractiveCodeSearch
  catch e
    @error "error while importing InteractiveCodeSearch" e
  end

  try
    @info "importing LinearAlgebra"
    @eval using LinearAlgebra
  catch e
    @error "error while importing LinearAlgebra" e
  end

  try
    @info "importing SparseArrays"
    @eval using SparseArrays
  catch e
    @error "error while importing SparseArrays" e
  end

  try
    @info "importing UnicodePlots"
    @eval using UnicodePlots
  catch e
    @error "error while importing UnicodePlots" e
  end

  # try
  #   @info "importing GR"
  #   @eval import GR
  #   @eval GR.inline("iterm")
  # catch e
  #   @error "error while importing GR" e
  # end

  # try
  #   @info "importing GRUtils"
  #   @eval using GRUtils
  #   @eval function spy(A::AbstractSparseMatrix, width=600)
  #     nrows, ncols = size(A)
  #     rows, cols, vals = findnz(A)
  #     vals .= abs.(vals)
  #     vals .= 255 * vals ./ maximum(vals)
  #     height = round(Int, width * nrows / ncols * 1.25)
  #     Figure((width, height))
  #     scatter(cols, rows,
  #             50 * ones(length(rows)),  # symbol size
  #             vals,                     # symbol color
  #             xlim=(1, ncols),
  #             ylim=(1, nrows),
  #             yflip=true,
  #             grid=false,
  #             colorbar=false)
  #     title("$nrows x $ncols, nnz = $(length(vals))")
  #     xlabel("row")
  #     ylabel("col")
  #     aspectratio(ncols / nrows)
  #     xticks(nrows/10, 10)
  #     yticks(ncols/10, 10)
  #   end
  # catch e
  #   @error "error while importing GRUtils" e
  # end
end

function template()
  @eval begin
    using PkgTemplates
    Template(;
      user="dpo",
      plugins=[
        Git(; ssh=true),
        Readme(; inline_badges=true),
        AppVeyor(; x86=false, coverage=false, extra_versions=["nightly"]),
        CirrusCI(; coverage=false, extra_versions=["nightly"]),
        DroneCI(; amd64=true, arm=true, arm64=true, extra_versions=["nightly"]),
        TravisCI(; extra_versions=["nightly"]),
        Codecov(),
        Coveralls(),
        Documenter{TravisCI}(),
        Citation(; readme=true),
      ]
     )
  end
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
