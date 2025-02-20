defmodule DaProductApp.SBOMTest do
  use DaProductApp.DataCase

  alias DaProductApp.SBOM

  describe "components" do
    alias DaProductApp.SBOM.Component

    import DaProductApp.SBOMFixtures

    @invalid_attrs %{version: nil, component_name: nil, supplier_type: nil, supplier_name: nil, relationship: nil, checksum_type: nil, checksum_algorithm: nil, checksum_value: nil, user_id: nil, application_id: nil, organization_id: nil}

    test "list_components/0 returns all components" do
      component = component_fixture()
      assert SBOM.list_components() == [component]
    end

    test "get_component!/1 returns the component with given id" do
      component = component_fixture()
      assert SBOM.get_component!(component.id) == component
    end

    test "create_component/1 with valid data creates a component" do
      valid_attrs = %{version: "some version", component_name: "some component_name", supplier_type: "some supplier_type", supplier_name: "some supplier_name", relationship: "some relationship", checksum_type: "some checksum_type", checksum_algorithm: "some checksum_algorithm", checksum_value: "some checksum_value", user_id: 42, application_id: 42, organization_id: 42}

      assert {:ok, %Component{} = component} = SBOM.create_component(valid_attrs)
      assert component.version == "some version"
      assert component.component_name == "some component_name"
      assert component.supplier_type == "some supplier_type"
      assert component.supplier_name == "some supplier_name"
      assert component.relationship == "some relationship"
      assert component.checksum_type == "some checksum_type"
      assert component.checksum_algorithm == "some checksum_algorithm"
      assert component.checksum_value == "some checksum_value"
      assert component.user_id == 42
      assert component.application_id == 42
      assert component.organization_id == 42
    end

    test "create_component/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SBOM.create_component(@invalid_attrs)
    end

    test "update_component/2 with valid data updates the component" do
      component = component_fixture()
      update_attrs = %{version: "some updated version", component_name: "some updated component_name", supplier_type: "some updated supplier_type", supplier_name: "some updated supplier_name", relationship: "some updated relationship", checksum_type: "some updated checksum_type", checksum_algorithm: "some updated checksum_algorithm", checksum_value: "some updated checksum_value", user_id: 43, application_id: 43, organization_id: 43}

      assert {:ok, %Component{} = component} = SBOM.update_component(component, update_attrs)
      assert component.version == "some updated version"
      assert component.component_name == "some updated component_name"
      assert component.supplier_type == "some updated supplier_type"
      assert component.supplier_name == "some updated supplier_name"
      assert component.relationship == "some updated relationship"
      assert component.checksum_type == "some updated checksum_type"
      assert component.checksum_algorithm == "some updated checksum_algorithm"
      assert component.checksum_value == "some updated checksum_value"
      assert component.user_id == 43
      assert component.application_id == 43
      assert component.organization_id == 43
    end

    test "update_component/2 with invalid data returns error changeset" do
      component = component_fixture()
      assert {:error, %Ecto.Changeset{}} = SBOM.update_component(component, @invalid_attrs)
      assert component == SBOM.get_component!(component.id)
    end

    test "delete_component/1 deletes the component" do
      component = component_fixture()
      assert {:ok, %Component{}} = SBOM.delete_component(component)
      assert_raise Ecto.NoResultsError, fn -> SBOM.get_component!(component.id) end
    end

    test "change_component/1 returns a component changeset" do
      component = component_fixture()
      assert %Ecto.Changeset{} = SBOM.change_component(component)
    end
  end
end
