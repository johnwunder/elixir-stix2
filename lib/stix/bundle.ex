defmodule Stix.Bundle do
  
  @doc """
  Creates a STIX bundle with the passed list of objects.

    iex> Stix.bundle([Stix.create_object("campaign", %{title: "Shade of Palms"})])
  """
  def bundle(list) when is_list(list) do
    %{
      id: Stix.id("bundle"),
      type: "bundle",
      objects: list
    }
  end

  @doc """
  Creates a STIX bundle with the single item in it.

    iex> Stix.bundle(Stix.create_object("campaign", %{title: "Shade of Palms"}))
  """
  def bundle(item), do: bundle([item])
end