defmodule MakWeb.LayoutView do
  use MakWeb, :view

  def machine_land?(conn, path) do
    Regex.compile!(path<>"$") |> Regex.match?(Path.join("/", conn.path_info))
  end
end
