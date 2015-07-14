require 'money'

class Totalator

    def initialize( price_list )
    	@price_list = price_list
    end 

    def total( shopping_list )
        parse_prices()
    	format_output( calculate_total( shopping_list ) )
    end

    private

	def parse_prices
		@parsed_prices = @price_list.scan( /(\w+) = £?([\d+\.]+)p?/ )
                   .map{ |arr| [arr[0], arr[1].gsub( /\D/,'' ).to_i] }
                   .to_h
	end

	def calculate_total( shopping_list )
		shopping_list.split.map{ |item| @parsed_prices[item] || 0 }.inject( :+ )
    end

    def format_output( total )
    	"The price of the shopping list is: #{Money.new(total, "GBP").format}"
    end

end

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

till = Totalator.new( price_list )

p till.total( shopping_list )