defmodule SacApiEx.Websites.Models.WebsiteTrouble do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias SacApiEx.Websites.Models.Website
  alias SacApiEx.Troubles.Models.Trouble
  alias SacApiEx.Websites.Models.WebsiteTrouble

  # global fields
  @required_fields ~w(website_id trouble_id)a
  @already_exists "ALREADY_EXISTS"

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @type t :: %WebsiteTrouble{}
  schema "websites_troubles" do
    belongs_to(:websites, Website, primary_key: true)
    belongs_to(:troubles, Trouble, primary_key: true)

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
