defmodule DaProductApp.Software do
  @moduledoc """
  The Software context.
  """

  import Ecto.Query, warn: false
  alias DaProductApp.Repo

  alias DaProductApp.Software.SoftwareEntry

  @doc """
  Returns the list of softwares.

  ## Examples

      iex> list_softwares()
      [%SoftwareEntry{}, ...]

  """
  def list_softwares do
    Repo.all(SoftwareEntry)
  end

  @doc """
  Gets a single software_entry.

  Raises `Ecto.NoResultsError` if the Software entry does not exist.

  ## Examples

      iex> get_software_entry!(123)
      %SoftwareEntry{}

      iex> get_software_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_software_entry!(id), do: Repo.get!(SoftwareEntry, id)

  @doc """
  Creates a software_entry.

  ## Examples

      iex> create_software_entry(%{field: value})
      {:ok, %SoftwareEntry{}}

      iex> create_software_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_software_entry(attrs \\ %{}) do
    %SoftwareEntry{}
    |> SoftwareEntry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a software_entry.

  ## Examples

      iex> update_software_entry(software_entry, %{field: new_value})
      {:ok, %SoftwareEntry{}}

      iex> update_software_entry(software_entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_software_entry(%SoftwareEntry{} = software_entry, attrs) do
    software_entry
    |> SoftwareEntry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a software_entry.

  ## Examples

      iex> delete_software_entry(software_entry)
      {:ok, %SoftwareEntry{}}

      iex> delete_software_entry(software_entry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_software_entry(%SoftwareEntry{} = software_entry) do
    Repo.delete(software_entry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking software_entry changes.

  ## Examples

      iex> change_software_entry(software_entry)
      %Ecto.Changeset{data: %SoftwareEntry{}}

  """
  def change_software_entry(%SoftwareEntry{} = software_entry, attrs \\ %{}) do
    SoftwareEntry.changeset(software_entry, attrs)
  end
end
