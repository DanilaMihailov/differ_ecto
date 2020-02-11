defmodule DifferEctoTest do
  use ExUnit.Case
  doctest DifferEcto

  test "call optimize by default" do
    diff1 = DifferEcto.diff("qwerty xyz", "qwerxy1234")
    diff2 = Differ.diff("qwerty xyz", "qwerxy1234") |> Differ.optimize()

    assert diff1 == diff2
  end

  test "pass params to optimize" do
    diff1 = DifferEcto.diff("qwerty xyz", "qwerxy1234", optimize: 2)
    diff2 = Differ.diff("qwerty xyz", "qwerxy1234") |> Differ.optimize(2)

    assert diff1 == diff2
  end

  test "explain is same as in differ" do
    old_map = %{key: 1, some: "qwer", same: 1}
    new_map = %{key: 2, some: "werty", same: 1}
    diff = DifferEcto.diff(old_map, new_map)

    explainer = fn {op, val} ->
      case op do
        :del -> "--" <> val
        :ins -> "++" <> val
        _ -> val
      end
    end

    explained = DifferEcto.explain_field(new_map, :some, diff, explainer)

    found = Enum.find(diff, fn op -> elem(op, 0) == :some end) |> elem(2)
    explained_differ = Differ.explain(new_map.some, found, explainer)

    assert explained == explained_differ
  end

  test "explain when no change" do
    old_map = %{key: 1, some: "qwer", same: 1}
    diff = DifferEcto.diff(old_map, old_map)

    explainer = fn {op, val} ->
      case op do
        :eq -> "__" <> val
        _ -> val
      end
    end

    explained = DifferEcto.explain_field(old_map, :some, diff, explainer)

    assert explained == "__qwer"
  end

  test "delegates are right" do
    old_map = %{key: 1, some: "qwer", same: 1}
    new_map = %{key: 2, some: "werty", same: 1}
    diff = DifferEcto.diff(old_map, new_map)

    assert Differ.patch(old_map, diff) == DifferEcto.patch(old_map, diff)
    assert Differ.patch!(old_map, diff) == DifferEcto.patch!(old_map, diff)
    assert Differ.revert(new_map, diff) == DifferEcto.revert(new_map, diff)
    assert Differ.revert!(new_map, diff) == DifferEcto.revert!(new_map, diff)
  end
end
