defmodule Mak.Helpers do
    def today do
      {_, today} = Date.from_erl(elem(:calendar.local_time(), 0))
      today
    end
  end
  