defmodule SuperSimpleFeatureFlags.CoreTest do
  use SuperSimpleFeatureFlags.DataCase

  alias SuperSimpleFeatureFlags.Core

  describe "features" do
    alias SuperSimpleFeatureFlags.Core.Feature

    import SuperSimpleFeatureFlags.CoreFixtures

    @invalid_attrs %{enabled: nil, name: nil}

    test "list_features/0 returns all features" do
      feature = feature_fixture()
      assert Core.list_features() == [feature]
    end

    test "get_feature!/1 returns the feature with given id" do
      feature = feature_fixture()
      assert Core.get_feature!(feature.id) == feature
    end

    test "create_feature/1 with valid data creates a feature" do
      valid_attrs = %{enabled: true, name: :some_name}

      assert {:ok, %Feature{} = feature} = Core.create_feature(valid_attrs)
      assert feature.enabled == true
      assert feature.name == :some_name
    end

    test "create_feature/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_feature(@invalid_attrs)
    end

    test "update_feature/2 with valid data updates the feature" do
      feature = feature_fixture()
      update_attrs = %{enabled: false, name: :some_updated_name}

      assert {:ok, %Feature{} = feature} = Core.update_feature(feature, update_attrs)
      assert feature.enabled == false
      assert feature.name == :some_updated_name
    end

    test "update_feature/2 with invalid data returns error changeset" do
      feature = feature_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_feature(feature, @invalid_attrs)
      assert feature == Core.get_feature!(feature.id)
    end

    test "delete_feature/1 deletes the feature" do
      feature = feature_fixture()
      assert {:ok, %Feature{}} = Core.delete_feature(feature)
      assert_raise Ecto.NoResultsError, fn -> Core.get_feature!(feature.id) end
    end

    test "change_feature/1 returns a feature changeset" do
      feature = feature_fixture()
      assert %Ecto.Changeset{} = Core.change_feature(feature)
    end
  end
end
