require './lib/exercise-9/modules/speech'
require './lib/exercise-9/modules/movement'
require './lib/exercise-9/invalid_direction_exception'

module Exercise9
  class Robot
    include Speech
    include Movement

    def initialize(name)
      @name = name
    end

    def fire_laser
      shout 'firing laser'
    end
  end
end
