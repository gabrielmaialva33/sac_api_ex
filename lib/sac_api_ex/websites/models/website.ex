defmodule SacApiEx.Websites.Models.Website do
  use Ecto.Schema
  import Ecto.Changeset

  # websites schema
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "websites" do
    field :title, :string
    field :description, :string
    field :url, :string
    field :is_deleted, :boolean, default: false

    timestamps()

    # set many to many relationship
    many_to_many :troubles, SacApiEx.Websites.Models.Trouble, join_through: "websites_troubles"
  end

  @doc false
  def changeset(website, attrs) do
    website
    |> cast(attrs, [:title, :description, :url, :is_deleted])
    |> validate_required([:title, :description, :url, :is_deleted])
  end
end
