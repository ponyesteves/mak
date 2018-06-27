defmodule MakWeb.ImportController do
  use MakWeb, :controller

  alias Mak.Base.Machine
  alias Mak.Teamplace

  @ep "https://3.teamplace.finneg.com/BSA/api/maquinas/list?ACCESS_TOKEN="

  def machines(conn, _params) do
    Teamplace.get_token
    |> Teamplace.get_end_point(@ep)
    |> Teamplace.get_data
    |> Enum.map(&translate/1)
    |> IO.inspect
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
