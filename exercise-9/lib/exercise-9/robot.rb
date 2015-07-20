require_relative 'modules/speech'
require_relative 'modules/movement'

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
