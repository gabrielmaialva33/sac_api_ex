defmodule SacApiEx.Websites.Models.Website do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "websites" do
    field :description, :string
    field :is_deleted, :boolean, default: false
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(website, attrs) do
    website
    |> cast(attrs, [:title, :description, :url, :is_deleted])
    |> validate_required([:title, :description, :url, :is_deleted])
  end
end
