defmodule SuperSimpleFeatureFlags.Persistence.Feature do
  use Ecto.Schema
  import Ecto.Changeset
  alias SuperSimpleFeatureFlags.Persistence.AtomType

  schema "features" do
    field :name, AtomType
    field :enabled, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(feature, attrs) do
    feature
    |> cast(attrs, [:name, :enabled])
    |> ensure_atom([:name])
    |> validate_required([:name, :enabled])
  end

  defp ensure_atom(changeset, fields) do
    Enum.reduce(fields, changeset, fn field, changeset ->
      case get_change(changeset, field) do
        nil ->
          changeset

        value when is_atom(value) ->
          changeset

        value when is_binary(value) ->
          put_change(changeset, field, String.to_atom(value))
      end
    end)
  end
end
