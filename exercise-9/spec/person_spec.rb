require 'rspec'
require 'spec_helper'
require 'ffaker'

describe Exercise9::Person do

  subject { described_class.new(FFaker::Lorem.word) }

  it_behaves_like 'a speaker'
  it_behaves_like 'a mover'

  it '#tell_me_the_time' do
    expect(subject).to receive(:say).with(/, sorry I'm not a Robot and I don't have a watch/)
    subject.tell_me_the_time
  end
end