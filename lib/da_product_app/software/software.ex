defmodule DaProductApp.Software.Software do
  use Ecto.Schema
  import Ecto.Changeset
  alias DaProductApp.Repo
  alias DaProductApp.Software.SoftwareVersion  # Fix incorrect module reference

  schema "software" do
    field :name, :string
    field :slug, :string
    field :last_updated, :utc_datetime
    has_many :versions, DaProductApp.Software.SoftwareVersion  # Fixed typo
    timestamps()
  end

  def changeset(software, attrs) do
    software
    |> cast(attrs, [:name, :slug, :last_updated])
    |> validate_required([:name, :slug])
    |> unique_constraint(:slug)
  end

  # ✅ Fix incorrect reference: Should use `DaProductApp.Software.Software`, not `SoftwareEntry`
  def list_software do
    Repo.all(DaProductApp.Software.SoftwareEntry)
  end

  def get_software!(id) do
    DaProductApp.Software.Software
    |> Repo.get!(id)
    |> Repo.preload(:versions)
  end
end

