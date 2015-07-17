require 'spec_helper'
require 'ffaker'

describe Game do

  describe 'defaults' do
    it 'uses STDOUT for output' do
      expect(subject.output).to be($stdout)
    end

    it 'uses STDIN for input' do
      expect(subject.input).to be($stdin)
    end

    context 'weapons' do
      it 'they are rock paper scissors' do
        expect(described_class::WEAPONS_OF_CHOICE).to eq([:rock, :paper, :scissors])
      end
      it 'uses the default weapons' do
        expect(subject.weapons).to be(described_class::WEAPONS_OF_CHOICE)
      end
    end

  end

  describe 'game methods' do
    let(:output_stream) { StringIO.new }
    let(:input_stream) { StringIO.new }
    let(:computer_choice) { 'rock' }
    subject(:game) { described_class.new(output_stream, input_stream, [computer_choice]) }

    describe '#play' do

      it 'asks you to choose from the available weapons' do
        allow(game).to receive(:decide)
        game.play
        expect(output_stream.string).to include(described_class::CHOOSE_WEAPON_MSG)
      end

      it 'plays your choice against the computers choice' do
        user_choice = 'paper\n'

        expect(input_stream).to receive(:gets).and_return(user_choice)
        expect(game).to receive(:decide).with(user_choice, computer_choice)
        game.play
      end

      context 'user wins' do
        winning_hands = [['rock', 'scissors'],
                         ['scissors', 'paper'],
                         ['paper', 'rock']]

        it_behaves_like 'a round is played', winning_hands, "#{described_class::MESSAGES[:user_win]}"
      end

      context 'computer wins' do
        winning_hands = [['scissors', 'rock'],
                         ['rock', 'paper'],
                         ['paper', 'scissors']]

        it_behaves_like 'a round is played', winning_hands, "#{described_class::MESSAGES[:computer_win]}"
      end

      context 'draws' do
        winning_hands = [['scissors', 'scissors'],
                         ['rock', 'rock'],
                         ['paper', 'paper']]

        it_behaves_like 'a round is played', winning_hands, "#{described_class::MESSAGES[:draw]}"
      end

    end

    describe '#computer_choice' do

      let(:weapons) { [:weapon1] }
      subject(:game) do
        described_class.new(output_stream, input_stream, weapons)
      end

      it 'returns a random weapon' do
        expect(weapons).to receive(:sample).and_call_original
        expect(game.computer_choice).to eq (:weapon1.to_s)
      end
    end

    describe '#decide' do

      let(:output_stream) { StringIO.new }
      let(:input_stream) { StringIO.new }
      subject(:game) { described_class.new(output_stream, input_stream) }

      context 'user wins' do
        it 'outputs the winning message' do
          expect(game.decide('rock', 'scissors')).to eq(described_class::MESSAGES[:user_win])
        end
      end

      context 'computer wins' do
        it 'outputs the losing message' do
          expect(game.decide('paper', 'scissors')).to eq(described_class::MESSAGES[:computer_win])
        end
      end

      context "it's a draw" do
        it 'outputs the draw message' do
          expect(game.decide('paper', 'paper')).to eq(described_class::MESSAGES[:draw])
        end
      end

      context 'user input is invalid' do
        it 'returns an invalid choice message' do
          expect(game.decide(FFaker::Lorem.word.dup, 'paper')).to eq("That's not a choice")
        end
      end

    end
  end
end