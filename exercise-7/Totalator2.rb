require 'money'
require 'pry'

class Totalator

    def initialize( price_list )
    	@price_list = price_list
    	@scanned_items = []
    end 

    def scan_item( item ) 
    	@scanned_items << item
    end

    def total 
        parse_prices()
    	format_output( calculate_total )
    end

    private 

	def parse_prices
		@parsed_prices = @price_list.scan( /(\w+) = £?([\d+\.]+)p?/ )
                   .map{ |arr| [arr[0], arr[1].gsub( /\D/,'' ).to_i] }
                   .to_h
	end

	def calculate_total
		@scanned_items.map { |item| @parsed_prices[item] || 0 }.inject( :+ ) 
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

shopping_list.split.each do |item|
	till.scan_item( item )
end

p till.total
