defmodule DaProductAppWeb.ComponentController do
  use DaProductAppWeb, :controller
  alias DaProductApp.Software.SoftwareEntry

 # def index(conn, _params) do
 #   software_list = SoftwareEntry.list_software()
 #   render(conn, :software , software_list: software_list)
 # end


  def index(conn, _params) do
  software_list = 
    SoftwareEntry.list_software() 
    |> Enum.map(fn software -> %{
      id: software.id,
      name: software.name,
      slug: software.slug,
      last_updated: DateTime.to_iso8601(software.last_updated),
      inserted_at: DateTime.to_iso8601(software.inserted_at),
      updated_at: DateTime.to_iso8601(software.updated_at)
      #last_updated: software.last_updated,
      #inserted_at: software.inserted_at,
      #updated_at: software.updated_at
    } end)

  render(conn, :component, software_list_json: Jason.encode!(software_list))
  #render(conn, :software, software_list_json: software_list)
end

end

