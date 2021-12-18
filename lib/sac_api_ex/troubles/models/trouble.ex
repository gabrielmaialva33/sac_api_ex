defmodule SacApiEx.Troubles.Models.Trouble do
  use Ecto.Schema
  import Ecto.Changeset

  alias SacApiEx.Troubles.Models.Trouble
  alias SacApiEx.Websites.Models.Website

  # global fields
  @required_fields ~w(title description)a
  @optional_fields ~w(type)a

  # website flop drive
  @derive {
    Flop.Schema,
    filterable: [:title, :description, :type],
    sortable: [:title, :description],
    default_order_by: [:title],
    default_order_directions: [:asc, :desc],
    default_limit: 10,
    max_limit: 100
  }

  # troubles schema
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @type t :: %Trouble{}
  schema "troubles" do
    field :title, :string
    field :description, :string
    field :type, :string
    field :is_deleted, :boolean, default: false

    timestamps()

    # set many to many relationship
    many_to_many :websites, Website, join_through: "websites_troubles"
  end

  @doc false
  def changeset(%Trouble{} = trouble, params) do
    trouble
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:title)
  end
end
