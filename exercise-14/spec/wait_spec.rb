require 'rspec'
require 'timecop'
require_relative '../../exercise-14/lib/wait'

describe 'Wait' do

  describe '#until' do
    it 'execute the block until it returns true' do
      expect(Wait.until {rand(9999) % 2 == 0 }).to be(true)
    end

    it 'expect an exception when no block is supplied' do
      begin
        Wait.until
        fail 'Expect a ArgumentError'
      rescue ArgumentError => error
        expect(error.to_s).to eq('A block must be supplied to this method.')
      end
      expect { Wait.until }.to raise_error(ArgumentError)
    end

    it 'expect an exception when expiry has been reached' do
      start_time = Time.now
      Timecop.scale(60)
      begin
        Wait.until { false }
        fail 'Expect a Wait::ExecutionExpiryException'
      rescue Wait::ExecutionExpiryException => error
        expect(error.to_s).to eq('The expiry time of 5 seconds has been reached.')
      end
      expect(Time.now - start_time).to be >= 5
      Timecop.return
    end

    it 'expect the retry_time to default to 0' do
      start_time = Time.now
      expect(Wait.until(expire_after: 10){true}).to be(true)
      expect(Time.now - start_time).to be <= 0.01
    end

    it 'expect the retry_time to pause execution' do
      start_time = Time.now
      count = 0
      expect(Wait.until(retry_time: 1) do
               (count += 1) == 2
      end ).to be(true)
      expect(Time.now - start_time).to be >= 1
    end
  end
end