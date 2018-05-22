defmodule MakWeb.MachineView do
  use MakWeb, :view

  def img_from_binary(binary) do
    "data:image/*;base64," <> Base.encode64(binary)
  end
end
