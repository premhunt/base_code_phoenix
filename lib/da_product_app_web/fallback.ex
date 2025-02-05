defmodule DaProductAppWeb.Fallback do
  @moduledoc """
  Use this in a LiveView when a resource is not found.
  ```
  raise DaProductAppWeb.Fallback
  ```
  """
  defexception message: "invalid route", plug_status: 404
end