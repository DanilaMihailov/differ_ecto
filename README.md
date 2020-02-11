# DifferEcto

`Ecto.Type` for `Differ` diffs

## Installation

The package can be installed
by adding `differ_ecto` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:differ_ecto, "~> 0.1.0"}
  ]
end
```

## Documentation

Documentation can be found at [https://hexdocs.pm/differ_ecto](https://hexdocs.pm/differ_ecto).


## Usage

```elixir
defmodule Example do
  use Ecto.Schema
  # gives us Diffable, Patchable and Diff
  use DifferEcto

  # we have to skip `:diffs` field
  # skip timestamps as well
  @derive [{Diffable, skip: [:updated_at, :diffs]}, Patchable]
  schema "example" do
    field :body, :string
    field :title, :string
    # we want to store list of diffs in document
    field :diffs, {:array, Diff}, default: []
    timestamps()
  end
end

```

