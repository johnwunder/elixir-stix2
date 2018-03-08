defmodule StixObjectTest do
  use ExUnit.Case

  test "create_object" do
    object = Stix.object("indicator")
    assert object.type == "indicator"
    assert Regex.match?(~r/indicator--/, object.id)
    assert object.created
    assert object.modified
  end

  test "create_object with dictionary" do
    object = Stix.object("indicator", %{title: "testing"})
    assert object.type == "indicator"
    assert Regex.match?(~r/indicator--/, object.id)
    assert object.created
    assert object.modified
    assert object.title == "testing"
  end

  test "create_object as key list" do
    object = Stix.object("indicator", title: "testing", description: "Something")
    assert object.type == "indicator"
    assert Regex.match?(~r/indicator--/, object.id)
    assert object.created
    assert object.modified
    assert object.title == "testing"
    assert object.description == "Something"
  end

  test "versioning" do
    object = Stix.object("indicator", title: "testing")
    assert object.title == "testing"

    new_version = Stix.version(object, title: "testing2")
    assert new_version.created == object.created
    assert new_version.title == "testing2"
    assert new_version.modified != object.modified
  end
end