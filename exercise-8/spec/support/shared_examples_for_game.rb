shared_examples "a round is played" do |rounds, result|

  rounds.each do |round|
    user_choice = round.first
    computer_choice = round.last
    it "play with user choice: #{user_choice}, computer choice: #{computer_choice} expecting message: #{result}" do
      allow(input_stream).to receive(:gets).and_return(user_choice)
      allow(game).to receive(:computer_choice).and_return(computer_choice)
      game.play

      expect(output_stream.string).to include(result)
    end
  end

end
