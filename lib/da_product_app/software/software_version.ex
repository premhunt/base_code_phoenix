defmodule DaProductApp.Software.SoftwareVersion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "software_versions" do
    field :cycle, :string
    field :release_date, :date
    field :eol_date, :date
    field :latest_version, :string
    field :link, :string
    field :last_updated, :utc_datetime
    belongs_to :software, DaProductApp.Software.SoftwareEntry, type: :binary_id
    timestamps()
  end

  def changeset(version, attrs) do
    version
    |> cast(attrs, [:cycle, :release_date, :eol_date, :latest_version, :software_id])
    |> validate_required([:cycle, :software_id])
  end
end


