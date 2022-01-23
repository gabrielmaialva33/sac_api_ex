defmodule SacApiEx.Website.Models.WebsiteTrouble do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias SacApiEx.Website.Models.Website
  alias SacApiEx.Trouble.Models.Trouble
  alias SacApiEx.Website.Models.WebsiteTrouble

  # global fields
  @required_fields ~w(website_id trouble_id)a
  @already_exists "ALREADY_EXISTS"

  @primary_key {:id, :binary_id, autogenerate: true}
  @type t :: %WebsiteTrouble{}
  schema "websites_troubles" do
    field :website_id, :binary_id
    belongs_to :websites, Website, define_field: false

    field :trouble_id, :binary_id
    belongs_to :troubles, Trouble, define_field: false

    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(%WebsiteTrouble{} = website_trouble, params) do
    website_trouble
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:websites)
    |> foreign_key_constraint(:troubles)
    |> unique_constraint(
         [:websites, :troubles],
         name: :website_id_trouble_id_unique_index,
         message: @already_exists
       )
  end
end
