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
      expect(subject.send(:greetings)).to include(subject.greeting)
    end

    it '#farewell' do
      expect(subject.send(:goodbyes)).to include(subject.farewell)
    end
  end
end