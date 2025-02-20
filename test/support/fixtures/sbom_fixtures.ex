defmodule DaProductApp.SBOMFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DaProductApp.SBOM` context.
  """

  @doc """
  Generate a component.
  """
  def component_fixture(attrs \\ %{}) do
    {:ok, component} =
      attrs
      |> Enum.into(%{
        application_id: 42,
        checksum_algorithm: "some checksum_algorithm",
        checksum_type: "some checksum_type",
        checksum_value: "some checksum_value",
        component_name: "some component_name",
        organization_id: 42,
        relationship: "some relationship",
        supplier_name: "some supplier_name",
        supplier_type: "some supplier_type",
        user_id: 42,
        version: "some version"
      })
      |> DaProductApp.SBOM.create_component()

    component
  end
end
