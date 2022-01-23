defmodule SacApiEx.Website.Models.Website do
  @moduledoc """
  Define website schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias SacApiEx.Website.Models.{Website, WebsiteTrouble}
  alias SacApiEx.Trouble.Models.Trouble

  # global fields
  @required_fields ~w(title url)a
  @optional_fields ~w(description)a

  # website flop drive
  @derive {
    Flop.Schema,
    filterable: @required_fields ++ @optional_fields,
    sortable: @required_fields,
    default_order_by: [:title],
    default_order_directions: [:asc, :desc],
    default_limit: 10,
    max_limit: 100
  }

  # websites schema
  @primary_key {:id, :binary_id, autogenerate: true}
  @type t :: %Website{}
  schema "websites" do
    field :title, :string
    field :description, :string
    field :url, :string
    field :is_deleted, :boolean, default: false

    timestamps()

    # set relationships
    # has_many :troubles, Trouble
    many_to_many :troubles,
                 Trouble,
                 join_through: WebsiteTrouble,
                 join_keys: [
                   website_id: :id,
                   trouble_id: :id
                 ],
                 on_replace: :mark_as_invalid
  end

  @doc false
  def changeset(%Website{} = website, params \\ %{}) do
    website
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:title)
    |> cast_assoc(:troubles, with: &Trouble.changeset/2, required: false)
  end
end
