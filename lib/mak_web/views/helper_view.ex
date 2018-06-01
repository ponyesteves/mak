defmodule MakWeb.HelperView do

  def format_date(date) do
    [date.day, date.month, date.year - 2000]
    |> Enum.join("/")
  end
end
