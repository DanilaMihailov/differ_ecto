defmodule DifferEcto do
  @moduledoc """
  Documentation for DifferEcto.
  """

  @doc """
  Wrapper around `Differ.diff/2`, with optimiziation by default

  ## Options
  - `optimize` - level of optimization (default 1)
  """
  @spec diff(Differ.Diffable.t(), Differ.Diffable.t(), [optimize: number]) :: Differ.Diffable.diff()
  def diff(old, new, opts \\ []) do
    optimize = Keyword.get(opts, :optimize, 1)
    Differ.diff(old, new) |> Differ.optimize(optimize)
  end

  @doc """
  Wrapper around `Differ.explain/4`, but expects map and a field
  that will be explained

  options are the same as `Differ.explain/4`
  """
  @spec explain_field(Patchable.t(), Diffable.diff(), atom, (Diffable.operation() -> String.t()), revert: true) :: String.t()
  def explain_field(term, diff, field, cb, opts \\ []) do
    found = Enum.find(diff, fn op -> elem(op, 0) == field end)
    case found do
      {_, :diff, d} -> Differ.explain(Map.get(term, field), d, cb, opts)
      _ -> cb.({:eq, Map.get(term, field)})
    end
  end
end
