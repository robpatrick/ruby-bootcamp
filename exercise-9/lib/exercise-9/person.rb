require './lib/exercise-9/modules/speech'
require './lib/exercise-9/modules/movement'
require './lib/exercise-9/invalid_direction_exception'

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
