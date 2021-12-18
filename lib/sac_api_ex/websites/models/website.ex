defmodule SacApiEx.Websites.Models.Website do
  use Ecto.Schema
  import Ecto.Changeset

  alias SacApiEx.Websites.Models.Website
  alias SacApiEx.Troubles.Models.Trouble

  # global fields
  @required_fields ~w(title url)a
  @optional_fields ~w(description)a

  # website flop drive
  @derive {
    Flop.Schema,
    filterable: [:title, :description, :url],
    sortable: [:title, :url],
    default_order_by: [:title],
    default_order_directions: [:asc, :desc],
    default_limit: 10,
    max_limit: 100
  }

  # websites schema
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @type t :: %Website{}
  schema "websites" do
    field :title, :string
    field :description, :string
    field :url, :string
    field :is_deleted, :boolean, default: false

    timestamps()

    # set many to many relationship
    many_to_many :troubles, Trouble, join_through: "websites_troubles"
  end

  @doc false
  def changeset(%Website{} = website, params) do
    website
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:title)
  end
end
