require 'rspec'
require 'spec_helper'
require 'ffaker'

describe Exercise9::Robot do

    subject{ described_class.new(FFaker::Lorem.word) }

    it_behaves_like 'a speaker'
    it_behaves_like 'a mover'

    it '#tell_me_the_time' do
      expect(subject).to receive(:say).with(/, the time is /)
      subject.tell_me_the_time
    end

    it '#fire_lazer' do
      expect(subject).to receive(:shout).with('firing laser')
      subject.fire_laser
    end
end