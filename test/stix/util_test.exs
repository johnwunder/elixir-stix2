defmodule StixUtilTest do
  use ExUnit.Case

  alias Stix.Util

  @stix_json """
{
  "type": "bundle",
  "objects": [
      {
          "type": "indicator",
          "title": "Shade of Palms",
          "modified": "2018-01-15T23:02:58.275233Z",
          "id": "indicator--ac50f70d-7c46-4de0-b1cf-6eeae3eab38d",
          "created_by_ref": "identity--0f6532e2-7ed0-4614-9d2e-b99a27293a52",
          "created": "2018-01-15T23:02:58.240172Z"
      }
  ],
  "id": "bundle--296339de-3501-4035-9a45-fb31a2f81565"
}
"""

  test "generate_id" do
    assert Regex.match?(~r/indicator--/, Stix.id("indicator"))
  end

  test "atomize" do
    assert Util.atomize(%{"id" => "1234", "blah" => "4321"}) == %{:id => "1234", "blah" => "4321"}
    assert Util.atomize([%{"id" => "1234", "blah" => "4321"}]) == [%{:id => "1234", "blah" => "4321"}]
    assert Util.atomize(%{"id" => "1234", "objects" => [%{"id": "1234"}]}) == %{id: "1234", objects: [%{id: "1234"}]}

    assert Util.atomize_val(%{"id" => "1234", "blah" => "4321"}) == %{:id => "1234", "blah" => "4321"}
  end

  test "to_json" do
    {:ok, json} = "indicator"
    |> Stix.object
    |> Stix.to_json

    # This length should be constant because the timestamp and ID formats are constant length
    assert String.length(json) == 222
  end

  test "to_json!" do
    json = "indicator"
    |> Stix.object
    |> Stix.to_json!

    # This length should be constant because the timestamp and ID formats are constant length
    assert String.length(json) == 222
  end

  test "from_string" do
    {:ok, stix} = Stix.from_string(@stix_json)

    assert hd(stix.objects).title == "Shade of Palms"
  end

  test "from_string!" do
    stix = Stix.from_string!(@stix_json)

    assert hd(stix.objects).title == "Shade of Palms"
  end
end
