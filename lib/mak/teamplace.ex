defmodule Mak.Teamplace do
  @client_id "7e2fe6ae993c92c717c834dc6a23de0a"
  @client_secret "68804262ab88629b5607d36e9331b6b1"

  def get_token() do
    auth_url
    |> HTTPoison.get!()
    |> Map.get(:body)
  end

  def get_end_point(token, end_point_base), do: end_point_base <> token

  def get_data(end_point) do
    HTTPoison.get!(end_point)
    |> Map.get(:body)
    |> Poison.decode!()
  end

  def post_data(end_point, data) do
    headers = [{"content-type", "application/json"}]
    error = {:error, "Hubo un error"}
    case HTTPoison.post(end_point, data, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, "Registro Creado"}
      {:ok, _} -> error
      {:error, _} -> error
    end
  end

  defp auth_url do
    "https://3.teamplace.finneg.com/BSA/api/oauth/token?grant_type=client_credentials&client_id=#{
      @client_id
    }&client_secret=#{@client_secret}"
  end
end
