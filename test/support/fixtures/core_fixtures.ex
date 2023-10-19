defmodule SuperSimpleFeatureFlags.CoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SuperSimpleFeatureFlags.Core` context.
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
      |> SuperSimpleFeatureFlags.Core.create_feature()

    feature
  end
end
