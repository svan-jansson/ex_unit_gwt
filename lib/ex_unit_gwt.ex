defmodule ExUnitGwt do
  @moduledoc """
  Macros that add Given-When-Then (GWT) syntax
  """

  @doc """
  Used to describe some terse yet descriptive text of what is desired in order to realize a named business value as an explicit system actor I want to gain some beneficial outcome which furthers the goal
  """
  defmacro feature(description, do: block) do
    quote do
      ExUnit.Case.__describe__(__MODULE__, __ENV__.line, unquote(description))

      try do
        unquote(block)
      after
        @ex_unit_describe nil
        Module.delete_attribute(__MODULE__, :describetag)
      end
    end
  end

  @doc """
  Used to describe some determinable business situation
  """
  defmacro scenario(description, var \\ quote(do: _), contents) do
    contents =
      case contents do
        [do: block] ->
          quote do
            unquote(block)
            :ok
          end

        _ ->
          quote do
            try(unquote(contents))
            :ok
          end
      end

    var = Macro.escape(var)
    contents = Macro.escape(contents, unquote: true)

    quote bind_quoted: [var: var, contents: contents, description: description] do
      name = ExUnit.Case.register_test(__ENV__, :scenario, description, [])
      def unquote(name)(unquote(var)), do: unquote(contents)
    end
  end

  @doc """
  Describes a scenario precondition
  """
  defmacro given?(_, clause) do
    block = Keyword.get(clause, :do, nil)

    quote do
      unquote(block)
    end
  end

  @doc """
  Describes an action by the actor
  """
  defmacro when?(_, clause) do
    block = Keyword.get(clause, :do, nil)

    quote do
      unquote(block)
    end
  end

  @doc """
  Describes a testable outcome
  """
  defmacro then?(_, clause) do
    block = Keyword.get(clause, :do, nil)

    quote do
      unquote(block)
    end
  end

  @doc """
  Used to describe additional preconditions, actions or expected results
  """
  defmacro and?(_, clause) do
    block = Keyword.get(clause, :do, nil)

    quote do
      unquote(block)
    end
  end
end
