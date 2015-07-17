require './lib/exercise-9/speech'
require './lib/exercise-9/movement'
require './lib/exercise-9/invalid_direction_exception'

module Exercise9
  class Person
    include Speech
    include Movement
    attr_reader :position

    def initialize(name)
      @name = name

      @greetings = ['hello', 'good day', "what's up", 'yo', 'hi', 'sup', 'hey']
      @goodbyes = ['goodbye', 'see you later', 'in a while crocodile', 'l8rs', 'bye for now']
      @position  = {longitude: 0, latitude: 0 }
    end

    def tell_me_the_time
      say "#{greeting}, sorry I'm not a Robot and I don't have a watch"
    end

  end
end
