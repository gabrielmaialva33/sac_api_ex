defmodule SacApiEx.User.Models.Role do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias SacApiEx.User.Models.Role

  # global fields
  @required_fields ~w(name slug)a
  @optional_fields ~w(description)a

  # role flop drive
  @derive {
    Flop.Schema,
    filterable: @required_fields ++ @optional_fields,
    sortable: @required_fields,
    default_order_by: [:name],
    default_order_directions: [:asc, :desc],
    default_limit: 10,
    max_limit: 20
  }

  # role schema
  @primary_key {:id, :binary_id, autogenerate: true}
  @type t :: %Role{}
  schema "roles" do
    field :slug, :string
    field :name, :string
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(%Role{} = role, params \\ %{}) do
    role
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> update_change(:slug, &String.capitalize/1)
    |> unique_constraint(@required_fields)
  end
end
