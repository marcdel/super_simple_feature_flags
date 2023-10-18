defmodule SuperSimpleFeatureFlags.Repo do
  use Ecto.Repo,
    otp_app: :super_simple_feature_flags,
    adapter: Ecto.Adapters.Postgres
end
