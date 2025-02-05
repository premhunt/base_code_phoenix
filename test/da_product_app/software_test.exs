defmodule DaProductApp.SoftwareTest do
  use DaProductApp.DataCase

  alias DaProductApp.Software

  describe "softwares" do
    alias DaProductApp.Software.SoftwareEntry

    import DaProductApp.SoftwareFixtures

    @invalid_attrs %{name: nil, slug: nil, last_updated: nil}

    test "list_softwares/0 returns all softwares" do
      software_entry = software_entry_fixture()
      assert Software.list_softwares() == [software_entry]
    end

    test "get_software_entry!/1 returns the software_entry with given id" do
      software_entry = software_entry_fixture()
      assert Software.get_software_entry!(software_entry.id) == software_entry
    end

    test "create_software_entry/1 with valid data creates a software_entry" do
      valid_attrs = %{name: "some name", slug: "some slug", last_updated: ~U[2025-02-02 17:46:00Z]}

      assert {:ok, %SoftwareEntry{} = software_entry} = Software.create_software_entry(valid_attrs)
      assert software_entry.name == "some name"
      assert software_entry.slug == "some slug"
      assert software_entry.last_updated == ~U[2025-02-02 17:46:00Z]
    end

    test "create_software_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Software.create_software_entry(@invalid_attrs)
    end

    test "update_software_entry/2 with valid data updates the software_entry" do
      software_entry = software_entry_fixture()
      update_attrs = %{name: "some updated name", slug: "some updated slug", last_updated: ~U[2025-02-03 17:46:00Z]}

      assert {:ok, %SoftwareEntry{} = software_entry} = Software.update_software_entry(software_entry, update_attrs)
      assert software_entry.name == "some updated name"
      assert software_entry.slug == "some updated slug"
      assert software_entry.last_updated == ~U[2025-02-03 17:46:00Z]
    end

    test "update_software_entry/2 with invalid data returns error changeset" do
      software_entry = software_entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Software.update_software_entry(software_entry, @invalid_attrs)
      assert software_entry == Software.get_software_entry!(software_entry.id)
    end

    test "delete_software_entry/1 deletes the software_entry" do
      software_entry = software_entry_fixture()
      assert {:ok, %SoftwareEntry{}} = Software.delete_software_entry(software_entry)
      assert_raise Ecto.NoResultsError, fn -> Software.get_software_entry!(software_entry.id) end
    end

    test "change_software_entry/1 returns a software_entry changeset" do
      software_entry = software_entry_fixture()
      assert %Ecto.Changeset{} = Software.change_software_entry(software_entry)
    end
  end
end
