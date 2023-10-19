defmodule SuperSimpleFeatureFlags.Repo.Migrations.CreateFeatures do
  use Ecto.Migration

  def change do
    create table(:features) do
      add :name, :string, null: false
      add :enabled, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
