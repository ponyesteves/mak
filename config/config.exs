# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ceiboBase,
  ecto_repos: [CeiboBase.Repo]

# Configures Guardian
config :ceiboBase, CeiboBase.Guardian,
  issuer: "ceiboBase",
  secret_key: "mzRoWUUAbgH4XOmfb9zoXh/3ErxUBlXDhP/1UH3DdvaMCqlp+em9VMFubctjMGOa"

# Configures GuardianPipeLine

config :ceiboBase, CeiboBaseWeb.Guardian.AuthAccessPipeline,
  module: CeiboBase.Guardian,
  error_handler: CeiboBaseWeb.Guardian.AuthErrorHandler

# Configures the endpoint
config :ceiboBase, CeiboBaseWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4ntVSROhkwXahcj9VuTqRRm804z4eQcSd8Js0mF+6Tshn2MLEAPuzcDOdsl8Xg6p",
  render_errors: [view: CeiboBaseWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CeiboBase.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
