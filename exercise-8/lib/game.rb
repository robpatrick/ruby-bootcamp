class Game

  WEAPONS_OF_CHOICE = [:rock, :paper, :scissors].freeze
  CHOOSE_WEAPON_MSG = 'Choose a weapon: paper, scissors or rock? '

  MESSAGES = {
      user_win: "You win! :-)\n",
      computer_win: "You lose :-(\n",
      draw: "Youses draws! :-/\n"
  }

  attr_reader :output, :input, :weapons

  def initialize(output = STDOUT, input = STDIN, weapons = WEAPONS_OF_CHOICE)
    @output = output
    @input = input
    @weapons = weapons
  end

  def play
    output.write(CHOOSE_WEAPON_MSG)
    choice = input.gets
    output.write( decide(choice, computer_choice) )
  end

  def computer_choice
    weapons.sample.to_s
  end
    
  def decide(choice, computer_choice)
    choice.chomp!
    return "That's not a choice" unless WEAPONS_OF_CHOICE.include?(choice.to_sym)
    if choice == computer_choice
      return MESSAGES[:draw]
    elsif choice == 'paper' && computer_choice == 'rock' ||
          choice == 'rock'  && computer_choice == 'scissors' ||
          choice == 'scissors' && computer_choice == 'paper'
      return MESSAGES[:user_win]
    end
    MESSAGES[:computer_win]
  end
end
