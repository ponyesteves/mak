defmodule MakWeb.ImportController do
  use MakWeb, :controller

  alias Mak.Base.Machine

  @client_id "dc0df9bf90795fe5c2434613f2d5c623"
  @client_secret "382b70b31919f0e7453160d742cc5503"
  @ep "https://3.teamplace.finneg.com/BSA/api/maquinas/list?ACCESS_TOKEN="

  def machines(conn, _params) do
    get_token
    |> get_end_point
    |> get_data
    |> Enum.take(5)
    |> Enum.map(&translate/1)
    |> IO.inspect
    |> Enum.map(&Mak.Base.upsert_machine/1)

    json conn, %{id: 123}
  end


  defp get_data(ep) do
    HTTPoison.get!(ep)
    |> Map.get(:body)
    |> Poison.decode!()
  end

  def get_token() do
    "https://3.teamplace.finneg.com/BSA/api/oauth/token?grant_type=client_credentials&client_id=#{@client_id}&client_secret=#{@client_secret}"
    |> HTTPoison.get!
    |> Map.get(:body)
  end

  defp get_end_point(token), do: @ep <> token |> IO.inspect

  defp translate(ceres_obj) do
    %{
      "id" => ceres_obj["codigo"],
      "name"=> ceres_obj["nombre"],
      "desc" => ceres_obj["descripcion"]
    }
  end
end
