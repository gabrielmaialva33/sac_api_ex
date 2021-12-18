defmodule SacApiEx.Troubles.Models.Trouble do
  use Ecto.Schema
  import Ecto.Changeset

  # troubles schema
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "troubles" do
    field :title, :string
    field :description, :string
    field :type, :string
    field :is_deleted, :boolean, default: false


    timestamps()

    # set many to many relationship
    many_to_many :websites, SacApiEx.Websites.Models.Website, join_through: "websites_troubles"
  end

  @doc false
  def changeset(trouble, attrs) do
    trouble
    |> cast(attrs, [:title, :description, :type, :is_deleted])
    |> validate_required([:title])
  end
end
