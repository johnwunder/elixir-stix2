defmodule Stix do
  @moduledoc """
  This library is a simple module with helpers for working with STIX 2.0 content. It supports generating IDs, creating objects, and creating bundles.

  Future modules may support marking data and parsing markings, versioning, and patterning.
  """

  @doc """
  Generates a STIX-compliant ID for the given type.

  ## Examples

    iex> Stix.generate_id("indicator")
    "indicator--0f6532e2-7ed0-4614-9d2e-b99a27293a52"

  """
  defdelegate id(type), to: Stix.Util

  @doc """
  Creates a STIX object of the given type, with the given properties (optional). Automatically generates the timestamps, ID, and created_by_ref.

  ## Examples

    iex> Stix.object("campaign", title: "Shade of Palms")
    %{created: #<DateTime(2016-10-05T13:51:38.504629Z Etc/UTC)>,
    created_by_ref: "source--0f6532e2-7ed0-4614-9d2e-b99a27293a52",
    id: "campaign--c44dcae5-46df-4905-a7f6-b0cf3de67012",
    modified: #<DateTime(2016-10-05T13:51:38.504645Z Etc/UTC)>,
    title: "Shade of Palms", type: "campaign"}
  """
  defdelegate object(object_type, properties \\ %{}), to: Stix.Object

  @doc """
  Versions the passed STIX object with the updated parameters. The modified timestamp will be updated automatically, but can also be passed manually.

  ## Examples

    iex> Stix.version(obj, title: "New title")
  """
  defdelegate version(old_object, new_properties), to: Stix.Object

  @doc """
  Creates a STIX bundle with the passed object or list of objects.

    iex> Stix.bundle([Stix.object("campaign", %{title: "Shade of Palms"})])
  """
  defdelegate bundle(list_or_object), to: Stix.Bundle

  @doc """
  Turns the Elixir objects (bundles and objects) into STIX. This is a simple delegate to Poison.encode/1.

    iex> Stix.bundle([Stix.object("campaign", %{title: "Shade of Palms"})])
  """
  defdelegate to_json(object_or_bundle), to: Stix.Util

  @doc """
  Turns the Elixir maps (bundles and objects) into STIX, raise an error if it fails. This is a simple delegate to Poison encode!/1.

    iex> Stix.bundle([Stix.object("campaign", %{title: "Shade of Palms"})])
  """
  defdelegate to_json!(object_or_bundle), to: Stix.Util

  @doc """
  Turns a string into Elixir maps (bundles and objects), atomizing the keys as when creating objects.

    iex> Stix.bundle([Stix.object("campaign", %{title: "Shade of Palms"})])
  """
  defdelegate from_string(str), to: Stix.Util

  @doc """
  Turns a string into Elixir maps (bundles and objects), atomizing the keys as when creating objects. Raises an error if it fails.

    iex> Stix.bundle([Stix.object("campaign", %{title: "Shade of Palms"})])
  """
  defdelegate from_string!(str), to: Stix.Util
end
