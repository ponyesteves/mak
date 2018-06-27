defmodule Mak.Teamplace do

  @client_id "dc0df9bf90795fe5c2434613f2d5c623"
  @client_secret "382b70b31919f0e7453160d742cc5503"

  def get_token() do
    "https://3.teamplace.finneg.com/BSA/api/oauth/token?grant_type=client_credentials&client_id=#{@client_id}&client_secret=#{@client_secret}"
    |> HTTPoison.get!
    |> Map.get(:body)
  end

  def get_end_point(token, end_point_base), do: end_point_base <> token

  def get_data(end_point) do
    HTTPoison.get!(end_point)
    |> Map.get(:body)
    |> Poison.decode!()
  end

end
