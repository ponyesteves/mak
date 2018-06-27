defmodule Mak.Bpm do
  alias Mak.Teamplace
  @ep "https://3.teamplace.finneg.com/BSA/api/maqrepint?ACCESS_TOKEN="

  def post_case(order) do
    Teamplace.get_token()
    |> Teamplace.get_end_point(@ep)
    |> Teamplace.post_data(adapt_order(order))
  end

  def adapt_order(order) do
    %{
      Prioridad: 1,
      Descripcion: build_description(order.desc, order.user),
      Titulo: order.title,
      FechaComprobante: order.date,
      Fecha: order.date,
      PersonaIDPropietario: "413",
      TransaccionTipoID: "CASOTEAMPLACE",
      TransaccionSubtipoID: "CB - MAQ",
      MaquinaCodigo: order.machine_id
    }
    |> Poison.encode!()
  end

  defp build_description(description, user) do
    "Solicita: " <> user.username <> " -- \n " <> description
  end
end
