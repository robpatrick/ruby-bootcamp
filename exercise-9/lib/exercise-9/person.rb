require_relative 'modules/speech'
require_relative 'modules/movement'

module Exercise9
  class Person
    include Speech
    include Movement

    def initialize(name)
      @name = name
    end

    def tell_me_the_time
      say "#{greeting}, sorry I'm not a Robot and I don't have a watch"
    end

  end
end
