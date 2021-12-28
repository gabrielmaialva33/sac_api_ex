defmodule SacApiEx.Troubles.Models.Trouble do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias SacApiEx.Troubles.Models.Trouble
  alias SacApiEx.Websites.Models.{Website, WebsiteTrouble}

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
  @type t :: %Trouble{}
  schema "troubles" do
    field :title, :string
    field :description, :string
    field :type, :string

    field :is_deleted, :boolean, default: false

    timestamps()

    # set relationships
    # belongs_to :websites, Website
    many_to_many :websites,
                 Website,
                 join_through: WebsiteTrouble,
                 join_keys: [
                   website_id: :id,
                   trouble_id: :id
                 ],
                 on_replace: :delete
  end

  @doc false
  def changeset(%Trouble{} = trouble, params \\ %{}) do
    trouble
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> update_change(:title, &String.capitalize/1)
    |> unique_constraint(:title)
  end
end
