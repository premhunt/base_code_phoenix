defmodule DaProductApp.Software.SoftwareEntry do
  use Ecto.Schema
  import Ecto.Changeset
  alias DaProductApp.Repo
  alias DaProductApp.Software.SoftwareVersion  # Keep correct reference

  
  @primary_key {:id, :binary_id, autogenerate: false}  # Use binary_id for UUIDs
  schema "software" do
    field :name, :string
    field :slug, :string
    field :last_updated, :utc_datetime
    field :inserted_at, :utc_datetime
    field :updated_at, :utc_datetime
    has_many :versions, DaProductApp.Software.SoftwareVersion, on_delete: :nilify_all  # Prevent crashes if no related data

    #has_many :versions, DaProductApp.Software.SoftwareVersion  # Ensure correct relation
  end

  def changeset(software_entry, attrs) do
    software_entry
    |> cast(attrs, [:name, :slug, :last_updated])
    |> validate_required([:name, :slug])
    |> unique_constraint(:slug)
  end

  # ✅ Ensure we reference `SoftwareEntry`
  def list_software do
    Repo.all(DaProductApp.Software.SoftwareEntry)
  end
  def list_software do
  query = """
  SELECT 
    LOWER(CONCAT(
      SUBSTRING(HEX(id), 1, 8), '-',
      SUBSTRING(HEX(id), 9, 4), '-',
      SUBSTRING(HEX(id), 13, 4), '-',
      SUBSTRING(HEX(id), 17, 4), '-',
      SUBSTRING(HEX(id), 21)
    )) AS id, 
    name, 
    slug, 
    last_updated, 
    inserted_at, 
    updated_at 
  FROM software
  """

  Ecto.Adapters.SQL.query!(Repo, query, [])
  |> Map.get(:rows)
  |> Enum.map(fn [id, name, slug, last_updated, inserted_at, updated_at] ->
    %{
      id: id,
      name: name,
      slug: slug,
      last_updated: last_updated,
      inserted_at: inserted_at,
      updated_at: updated_at
    }
  end)
end


  def get_software!(id) do
    DaProductApp.Software.SoftwareEntry
    |> Repo.get!(id)
    |> Repo.preload(:versions)
  end
end

