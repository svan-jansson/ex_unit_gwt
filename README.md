# ExUnitGWT

[Given-When-Then](https://en.wikipedia.org/wiki/Given-When-Then) syntax for [ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_unit_gwt` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_unit_gwt, "~> 1.0.0", only: :test}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_unit_gwt](https://hexdocs.pm/lab).

## Usage Example

The example below describes a feature containing a test scenario, borrowed from the Gherkin docs. The module goes inside the /test folder, just like any other ExUnit test.

```elixir
defmodule ExunitGwtExample do
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
