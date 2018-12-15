defmodule ExUnitGWT.CLIFormatter do
  use GenServer

  defdelegate init(opts), to: ExUnit.CLIFormatter
  defdelegate handle_cast(request, state), to: ExUnit.CLIFormatter
end
