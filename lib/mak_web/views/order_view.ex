defmodule MakWeb.OrderView do
  use MakWeb, :view

  def format_date(date) do
    [date.day, date.month, date.year - 2000]
    |> Enum.join("/")
  end
end
