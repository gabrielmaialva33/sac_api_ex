defmodule SacApiEx.Troubles.Models.Report do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias SacApiEx.Troubles.Models.{Report, Trouble}

  # global fields
  @required_fields ~w(trouble_id)a
  @optional_fields ~w(is_reported)a

  # report schema
  @primary_key {:id, :binary_id, autogenerate: true}
  @type t :: %Report{}
  schema "reports" do
    field :trouble_id, :binary_id
    belongs_to :troubles, Trouble, define_field: false

    field :is_reported, :boolean, default: true

    timestamps()
  end

  @doc false
  def changeset(%Report{} = report, params \\ %{}) do
    report
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
