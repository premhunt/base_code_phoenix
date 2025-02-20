defmodule DaProductApp.SBOM.Component do
  use DaProductApp.Schema
  import Ecto.Changeset
  import Logger
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "components" do
    field :version, :string
    field :component_name, :string
    field :supplier_type, :string
    field :supplier_name, :string
    field :relationship, :string
    field :checksum_type, :string
    field :checksum_algorithm, :string
    field :checksum_value, :string
    field :user_id, :integer
    field :application_id, :integer
    field :organization_id, :integer

    timestamps(type: :utc_datetime)
  end

  #@doc false
  #def changeset(component, attrs) do
  #  component
  #  |> cast(attrs, [:component_name, :version, :supplier_type, :supplier_name, :relationship, :checksum_type, :checksum_algorithm, :checksum_value, :user_id, :application_id, :organization_id])
  #  |> validate_required([:component_name, :version, :supplier_type, :supplier_name, :relationship, :checksum_type, :checksum_algorithm, :checksum_value, :user_id, :application_id, :organization_id])
  #end


  @doc false
  def changeset(component, attrs) do
   Logger.debug("Component changeset inside db: #{inspect(attrs)}") # Correct usage
  component
  |> cast(attrs, [
    :component_name, :version, :supplier_type, :supplier_name, :relationship, 
    :checksum_type, :checksum_algorithm, :checksum_value, :user_id, 
    :application_id, :organization_id
  ])
  |> validate_required([
    :component_name, :version, :supplier_type, :supplier_name, :relationship, 
    :checksum_type, :checksum_algorithm, :checksum_value, :user_id, 
    :application_id, :organization_id
  ])
end

end
