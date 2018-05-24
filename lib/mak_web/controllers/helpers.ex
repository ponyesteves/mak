defmodule MakWeb.Helpers do
  def to_select(collection), do: Enum.map(collection, &{&1.name, &1.id})
end
