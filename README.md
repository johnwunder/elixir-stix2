# Stix

This library is a simple module with helpers for working with STIX 2.0 content. It supports generating IDs, creating objects, and creating bundles.

Future modules may support marking data and parsing markings, versioning, and patterning.

## Installation

This package can be installed by adding `stix` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:stix, "~> 0.1.0"}
  ]
end
```

API Docs: [https://hexdocs.pm/stix](https://hexdocs.pm/stix).

## Usage

This is a very simple library: it has a very small set of helpers for the most common tasks. Most things with STIX2 should be easy anyway! All of the functions you need are on the `Stix` module.

### Configuration

If you'll be creating objects, you probably want to configure your producer's identity reference used in `created_by_ref`. To do so, simply set the configuration key `creator_id` for the `stix` application:

```elixir
config :stix, creator_id: "identity--your-UUID-here"
```

### Creating Objects

Objects are created by type and an optional set of properties:

```elixir
Stix.object("campaign")
Stix.object("campaign", title: "Shade of Palms")
```

### Creating Bundles

Just pass in the list of objects (or a single object) to `bundle`:

```elixir
obj = Stix.object("campaign", title: "Shade of Palms")
bundle = Stix.bundle(obj) # Or, Stix.bundle([obj, obj2, ...])
```

### JSON

You can serialize to JSON with `to_json` and `to_json!`. These are simple delegates to the `Poison` library, so `to_json` will return the typical status/result tuple and `to_json!` will return the string and raise an error if it fails.

```elixir
{:ok, json_string} = Stix.to_json(bundle)
```

### Pipelining

The functions may work best as pipelines:

```elixir
Stix.object("indicator", pattern: "[...]")
|> Stix.bundle()
|> Stix.to_json()
```

### Parsing JSON

You can parse STIX as a string as well. Like serializing to JSON, this just delegates to `Poison` and accepts both the standard and error-raising forms.

```elixir
Stix.from_string("stix string here")
Stix.from_string!("stix string here")
```

Parsing is pretty basic. All it really does is load the file, parse the JSON, and atomize the same keys as everything else.

### Working with objects

Parsed objects will be maps that have had their standard STIX keys atomized. Custom keys will not be atomized unless originally parsed as an atom (don't do this). This means you can call them as properties:

```elixir
obj = Stix.object("campaign", title: "Shade of Palms")
obj.title == "Shade of Palms" # true
```

### Versioning

Objects can be versioned per the STIX specification with the `version` function. Pass the original object and the updated properties. The modified time will be updated automatically.

```elixir
obj = Stix.object("campaign", title: "Shade of Palms")

obj = obj |> Stix.version(title: "Shade of Psalms")
obj.title == "Shade of Psalms" # true
obj.modified != obj.created # true
```
