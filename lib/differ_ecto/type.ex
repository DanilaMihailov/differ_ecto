defmodule DifferEcto.Diff do
  use Ecto.Type

  def type, do: :list

  # Provide custom casting rules.
  def cast(diff) when is_list(diff) do
    {:ok, diff}
  end

  # Everything else is a failure though
  def cast(_), do: :error

  def load(data) do
    res =
      Enum.map(data, fn op ->
        case op do
          ["diff", val] ->
            {:ok, nval} = load(val)
            {:diff, nval}

          [key, "diff", val] ->
            {:ok, nval} = load(val)
            {String.to_existing_atom(key), :diff, nval}

          [cmd, val] ->
            {String.to_existing_atom(cmd), val}

          [key, cmd, val] ->
            {String.to_existing_atom(key), String.to_existing_atom(cmd), val}
        end
      end)

    {:ok, res}
  end

  def dump(diff) when is_list(diff) do
    res =
      Enum.map(diff, fn op ->
        case op do
          {:diff, val} ->
            {:ok, nval} = dump(val)
            [:diff, nval]

          {key, :diff, val} ->
            {:ok, nval} = dump(val)
            [key, :diff, nval]

          {cmd, val} ->
            [cmd, val]

          {key, cmd, val} ->
            [key, cmd, val]
        end
      end)

    {:ok, res}
  end

  def dump(_), do: :error
end
