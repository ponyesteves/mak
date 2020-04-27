defmodule MakWeb.ImportController do
  use MakWeb, :controller

  alias Mak.Base.Machine

  def machines(conn, _params) do
    Application.get_env(:teamplace, :credentials)
    |> Teamplace.get_data("maquinas", "list")
    |> Enum.map(&translate/1)
    |> Enum.map(&Mak.Base.upsert_machine/1)

    redirect(conn, to: machine_path(conn, :index))
  end

  defp translate(ceres_obj) do
    %{
      "id" => ceres_obj["codigo"],
      "name"=> ceres_obj["nombre"],
      "desc" => ceres_obj["descripcion"]
    }
  end
end
