defmodule SuperSimpleFeatureFlags.PersistenceTest do
  use SuperSimpleFeatureFlags.DataCase

  alias SuperSimpleFeatureFlags.Persistence

  describe "features" do
    alias SuperSimpleFeatureFlags.Persistence.Feature

    import SuperSimpleFeatureFlags.PersistenceFixtures

    @invalid_attrs %{enabled: nil, name: nil}

    test "list_features/0 returns all features" do
      feature = feature_fixture()
      assert Persistence.list_features() == [feature]
    end

    test "get_feature!/1 returns the feature with given id" do
      feature = feature_fixture()
      assert Persistence.get_feature!(feature.id) == feature
    end

    test "create_feature/1 with valid data creates a feature" do
      valid_attrs = %{enabled: true, name: :some_name}

      assert {:ok, %Feature{} = feature} = Persistence.create_feature(valid_attrs)
      assert feature.enabled == true
      assert feature.name == :some_name
    end

    test "create_feature/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Persistence.create_feature(@invalid_attrs)
    end

    test "update_feature/2 with valid data updates the feature" do
      feature = feature_fixture()
      update_attrs = %{enabled: false, name: :some_updated_name}

      assert {:ok, %Feature{} = feature} = Persistence.update_feature(feature, update_attrs)
      assert feature.enabled == false
      assert feature.name == :some_updated_name
    end

    test "update_feature/2 with invalid data returns error changeset" do
      feature = feature_fixture()
      assert {:error, %Ecto.Changeset{}} = Persistence.update_feature(feature, @invalid_attrs)
      assert feature == Persistence.get_feature!(feature.id)
    end

    test "delete_feature/1 deletes the feature" do
      feature = feature_fixture()
      assert {:ok, %Feature{}} = Persistence.delete_feature(feature)
      assert_raise Ecto.NoResultsError, fn -> Persistence.get_feature!(feature.id) end
    end

    test "change_feature/1 returns a feature changeset" do
      feature = feature_fixture()
      assert %Ecto.Changeset{} = Persistence.change_feature(feature)
    end
  end
end
