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