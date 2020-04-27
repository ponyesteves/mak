# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mak,
  ecto_repos: [Mak.Repo]

# Configures Guardian
config :mak, Mak.Guardian,
  issuer: "mak",
  secret_key: "mzRoWUUAbgH4XOmfb9zoXh/3ErxUBlXDhP/1UH3DdvaMCqlp+em9VMFubctjMGOa"

# Configures GuardianPipeLine

config :mak, MakWeb.Guardian.AuthAccessPipeline,
  module: Mak.Guardian,
  error_handler: MakWeb.Guardian.AuthErrorHandler

# Configures the endpoint
config :mak, MakWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4ntVSROhkwXahcj9VuTqRRm804z4eQcSd8Js0mF+6Tshn2MLEAPuzcDOdsl8Xg6p",
  render_errors: [view: MakWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Mak.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :gettext, :default_locale, "es"
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.

config :teamplace, :credentials, %{
  client_id: "7e2fe6ae993c92c717c834dc6a23de0a",
  client_secret: "68804262ab88629b5607d36e9331b6b1"
}

config :teamplace, :api_base, "https://3.teamplace.finneg.com/BSA/api/"


import_config "#{Mix.env()}.exs"
