defmodule DaProductAppWeb.ComponentLibrary do
  defmacro __using__(_) do
    quote do
      import DaProductAppWeb.ComponentLibrary
      # Import additional component modules below
      import DaProductAppWeb.Components.Badges
      import DaProductAppWeb.Components.Cards

    end
  end
  @moduledoc """
  This module is added and used in DaProductAppWeb. The idea is
  different component modules can be added and imported in the macro section above.
  """
  use Phoenix.Component

end
