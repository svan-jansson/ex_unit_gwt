defmodule ExUnitGWT do
  @moduledoc """
  Helpers that add Given-When-Then (GWT) syntax to ExUnit

  ## Examples

  ```
  defmodule ExUnitGWTExample do
      use ExUnit.Case
      import ExUnitGWT

      feature "Serve coffee: in order to earn money customers should be able to buy coffee at all times" do
          scenario "Buy last coffee" do
            given? "there are 1 coffees left in the machine" do
              coffees_left = 1
              coffee_price = 1
            end

            and? "I have deposited 1 dollar" do
              dollars_deposited = 1
            end

            when? "I press the coffee button" do
              coffees_received = coffee_price * dollars_deposited
              coffees_left = coffees_left - coffees_received
            end

            then? "I should be served a coffee" do
              assert coffees_received == 1
            end

            and? "There should be no coffees left in the machine" do
              assert coffees_left == 0
            end
          end
        end

    end
  ```
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
  defmacro given?(_description, clause) do
    block = Keyword.get(clause, :do, nil)

    quote do
      unquote(block)
    end
  end

  @doc """
  Describes an action by the actor
  """
  defmacro when?(_description, clause) do
    block = Keyword.get(clause, :do, nil)

    quote do
      unquote(block)
    end
  end

  @doc """
  Describes a testable outcome
  """
  defmacro then?(_description, clause) do
    block = Keyword.get(clause, :do, nil)

    quote do
      unquote(block)
    end
  end

  @doc """
  Used to describe additional preconditions, actions or expected results
  """
  defmacro and?(_description, clause) do
    block = Keyword.get(clause, :do, nil)

    quote do
      unquote(block)
    end
  end

  @doc """
  Used to describe additional preconditions, actions or expected results

  ### Example

  ```
  but? "Then I should not be able to go back to the home screen" do
    assert home_screen_navigation == false
  end
  ```
  """
  defmacro but?(_description, clause) do
    block = Keyword.get(clause, :do, nil)

    quote do
      unquote(block)
    end
  end
end
