defmodule DaProductApp.SoftwareFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DaProductApp.Software` context.
  """

  @doc """
  Generate a software_entry.
  """
  def software_entry_fixture(attrs \\ %{}) do
    {:ok, software_entry} =
      attrs
      |> Enum.into(%{
        last_updated: ~U[2025-02-02 17:46:00Z],
        name: "some name",
        slug: "some slug"
      })
      |> DaProductApp.Software.create_software_entry()

    software_entry
  end
end
