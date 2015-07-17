shared_examples 'a speaker' do

  describe 'speech methods' do
    it '#say' do
      message = FFaker::Lorem.word.upcase
      expect(STDOUT).to receive(:puts).with(message.downcase)
      subject.say(message)
    end

    it '#shout' do
      message = FFaker::Lorem.word.downcase
      expect(STDOUT).to receive(:puts).with("#{message.upcase}!!!")
      subject.shout(message)
    end

    it '#greeting' do
      greetings = subject.instance_variable_get(:@greetings)
      expect(greetings).to include(subject.greeting)
    end

    it '#farewell' do
      goodbyes = subject.instance_variable_get(:@goodbyes)
      expect(goodbyes).to include(subject.farewell)
    end
  end
end

shared_examples 'a mover' do
  describe 'movement methods' do

    context 'starting point' do
      it '@position is at start point' do
        expect(subject.position[:longitude]).to eq(0)
        expect(subject.position[:latitude]).to eq(0)
      end
    end

    context 'successful invocation' do
      it '#move_left' do
        subject.move_left()
        expect(subject.position[:longitude]).to eq(0)
        expect(subject.position[:latitude]).to eq(1)
      end

      it '#move_right' do
        subject.move_right()
        expect(subject.position[:longitude]).to eq(0)
        expect(subject.position[:latitude]).to eq(-1)
      end

      it '#move_forwards' do
        subject.move_forwards()
        expect(subject.position[:longitude]).to eq(1)
        expect(subject.position[:latitude]).to eq(0)
      end

      it '#move_backwards' do
        subject.move_backwards()
        expect(subject.position[:longitude]).to eq(-1)
        expect(subject.position[:latitude]).to eq(0)
      end
    end

    context 'invalid invocation' do
      it '#move with invalid direction' do
        expect { subject.move('Your money maker') }.to raise_error(InvalidDirectionException)
      end
    end

  end
end