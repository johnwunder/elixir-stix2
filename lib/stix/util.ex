defmodule Stix.Util do

  @expected_keys ~w(id type modified created title description pattern kill_chain_phases objects created_by_ref)

  # Generate a STIX-compatible ID
  def id(type) do
    "#{type}--#{UUID.uuid4()}"
  end

  # Decode from string. The encode version is a simple delegate, but in this case we have to pass through atomize
  def from_string(string) do
    with {:ok, stix_object} <- Poison.decode(string), do: {:ok, atomize(stix_object)}
  end

  # Decode from string. The encode version is a simple delegate, but in this case we have to pass through atomize
  def from_string!(string) do
    string
    |> Poison.decode!()
    |> atomize()
  end

  def to_json(object_or_bundle), do: Poison.encode(object_or_bundle, pretty: true)
  def to_json!(object_or_bundle), do: Poison.encode!(object_or_bundle, pretty: true)

  # Atomize a list of objects
  def atomize(list) when is_list(list), do: for i <- list, do: atomize(i)

  # Atomize a map of string keys and values
  def atomize(map) when is_map(map) do
    for {key, val} <- map, into: %{}, do: {atomize(key), atomize_val(val)}
  end

  # Atomize a string if it belongs to the expected keys
  def atomize(key) when is_bitstring(key) and key in @expected_keys, do: String.to_atom(key)

  # Don't atomize anything else
  def atomize(key), do: key

  # Atomize a value in a map, which just recursively calls atomize if it's a map
  def atomize_val(val) when is_map(val), do: atomize(val)
  def atomize_val(val) when is_list(val), do: atomize(val)
  def atomize_val(val), do: val

  def now, do: timestamp(Timex.now)
  def timestamp(ts), do: Timex.format!(ts, "{ISO:Extended:Z}")
end