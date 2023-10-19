defmodule SuperSimpleFeatureFlags.PersistenceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SuperSimpleFeatureFlags.Persistence` context.
  """

  @doc """
  Generate a feature.
  """
  def feature_fixture(attrs \\ %{}) do
    {:ok, feature} =
      attrs
      |> Enum.into(%{
        enabled: true,
        name: :some_name
      })
      |> SuperSimpleFeatureFlags.Persistence.create_feature()

    feature
  end
end
