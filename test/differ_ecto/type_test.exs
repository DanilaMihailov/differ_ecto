defmodule DifferEctoTypeTest do
  use ExUnit.Case
  import Ecto.Type
  alias DifferEcto.Diff

  test "type is list" do
    assert Diff.type() == :list
  end

  test "load" do
    assert load(Diff, [["eq", "qwert"]]) == {:ok, [eq: "qwert"]}
    assert load(Diff, [["diff", [["ins", "xcv"]]]]) == {:ok, [diff: [ins: "xcv"]]}

    assert load(Diff, [["key", "diff", [["key2", "ins", "xcv"]]]]) ==
             {:ok, [{:key, :diff, [{:key2, :ins, "xcv"}]}]}
  end

  test "dump" do
    assert dump(Diff, eq: "qwert") == {:ok, [[:eq, "qwert"]]}
    assert dump(Diff, diff: [ins: "xcv"]) == {:ok, [[:diff, [[:ins, "xcv"]]]]}

    assert dump(Diff, [{:key, :diff, [{:key2, :ins, "xcv"}]}]) ==
             {:ok, [[:key, :diff, [[:key2, :ins, "xcv"]]]]}
  end
end
