require 'money'

price_list = "orange = 10p apple = 20p bread = £1.10 tomato = 25p cereal = £2.34" 

shopping_list=<<LIST
 list
 orange
 apple
 apple
 orange
 tomato
 cereal
 bread
 orange
 tomato
LIST

=begin
Given the following price list and shopping list print out the total cost of 
the shopping list in pounds and pence
=end 

parsed_prices = price_list.scan( /(\w+) = £?([\d+\.]+)p?/ )
                          .map{ |arr| [arr[0], arr[1].gsub( /\D/,'' ).to_i] }
                          .to_h

total = shopping_list.split.map{ |item| parsed_prices[item] || 0 }.inject( :+ )

output = "The price of the shopping list is: #{Money.new(total, "GBP").format}"

p output