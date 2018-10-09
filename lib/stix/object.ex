defmodule Stix.Object do

  @defaults %{creator_id: "identity--0f6532e2-7ed0-4614-9d2e-b99a27293a52"}

  def object(object_type, object_properties \\ %{}) do
    %{
      type:                     object_type,
      id:                       Stix.id(object_type),
      created:                  Timex.format!(Timex.now, "{ISO:Extended:Z}"),
      modified:                 Timex.format!(Timex.now, "{ISO:Extended:Z}"),
      created_by_ref:           Application.get_env(:stix, :creator_id) || @defaults.creator_id,
      spec_version:             "2.1"
    }
    |> Map.merge(Enum.into(object_properties, %{}))
    |> Stix.Util.atomize()
  end

  def version(old_object, new_version) do
    old_object
    |> Map.put(:modified, Timex.format!(Timex.now, "{ISO:Extended:Z}"))
    |> Map.merge(Enum.into(new_version, %{}))
  end
end