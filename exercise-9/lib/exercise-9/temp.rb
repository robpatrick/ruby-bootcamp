require_relative 'modules/speech'
class RudePerson
  attr_reader :name

  include Speech

  def initialize( name = 'Mike' )
    @name = name
    @greetings = ['Fuck off', 'Screw you']
  end
end

person = RudePerson.new( )
p "Hello #{person.name} how are you today?"
p "#{person.name}: #{person.greeting}"
