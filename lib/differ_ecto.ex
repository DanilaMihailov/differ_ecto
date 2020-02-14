defmodule DifferEcto do
  alias Differ.{Diffable, Patchable}
  @moduledoc """
  Helpers for `Differ` usage with `Ecto`

  By calling `use` with this module, you get aliases to `Differ.Diffable`, `Differ.Patchable` and `DifferEcto.Diff`
  """

  @doc """
  Wrapper around `Differ.diff/2`, with optimiziation by default

  ## Options
  - `optimize` - level of optimization (default 1)

  ## Examples

      iex> DifferEcto.diff(%{name: "John", age: 22}, %{name: "John", age: 23})
      [{:age, :del, 22}, {:age, :ins, 23}]
  """
  @spec diff(Differ.Diffable.t(), Differ.Diffable.t(), optimize: number) :: Differ.Diffable.diff()
  def diff(old, new, opts \\ []) do
    optimize = Keyword.get(opts, :optimize, 1)
    Differ.diff(old, new) |> Differ.optimize(optimize)
  end

  @doc """
  Wrapper around `Differ.explain/4`, but expects map (or struct) and a field
  that will be explained

  options are the same as `Differ.explain/4`

  ## Examples

      iex> DifferEcto.explain_field(%{name: "qwerty"}, :name, [{:name, :diff, [eq: "qwer", del: "123", ins: "ty"]}],
      ...> fn {op, val} ->
      ...>   case op do
      ...>     :del -> "--" <> val
      ...>     :ins -> "++" <> val
      ...>     _ -> val
      ...>   end
      ...> end)
      "qwer--123++ty"
  """
  @spec explain_field(Patchable.t(), atom, Diffable.diff(), (Diffable.operation() -> String.t()),
          revert: true
        ) :: String.t()
  def explain_field(term, field, diff, cb, opts \\ []) do
    found = Enum.find(diff, fn op -> elem(op, 0) == field end)

    case found do
      {_, :diff, d} -> Differ.explain(Map.get(term, field), d, cb, opts)
      _ -> cb.({:eq, Map.get(term, field)})
    end
  end

  defdelegate patch(obj, diff), to: Differ
  defdelegate patch!(obj, diff), to: Differ
  defdelegate revert(obj, diff), to: Differ
  defdelegate revert!(obj, diff), to: Differ

  defmacro __using__(_opts) do
    quote do
      alias Differ.Diffable
      alias Differ.Patchable
      alias DifferEcto.Diff
    end
  end
end
