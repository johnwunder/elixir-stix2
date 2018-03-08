defmodule StixBundleTest do
  use ExUnit.Case

  test "bundle" do
    result = Stix.bundle([Stix.object("indicator")])
    assert Map.keys(result) == [:id, :objects, :type]
  end

  test "bundle object" do
    result = Stix.bundle(Stix.object("indicator"))
    assert Map.keys(result) == [:id, :objects, :type]
  end

end
