defmodule Mix.Tasks.I18n do
  use Mix.Task

  def run(_) do
    Mix.Task.run("gettext.extract")
    Mix.Task.run("gettext.merge", ["priv/gettext", "--locale", "es"])
  end
end
