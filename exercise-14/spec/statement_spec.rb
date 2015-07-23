require 'rspec'
require 'date'
require 'json'

require_relative '../../exercise-14/lib/statement'

describe Statement do

  describe '#to_json' do

    it 'expect statement to include a generated date' do
      statement = Statement.new do
        date Date.today
        call_charges do
          call '999' do
          end
        end
      end
      result = JSON.parse(statement.to_json)['statement']
      expect(result['generated']).to eq( Date.today.to_s )
    end

    it 'expect statement to include a due date' do
      statement = Statement.new do
        date Date.today
        due(date + 30.days)
        call_charges do
          call '999' do
          end
        end
      end
      result = JSON.parse(statement.to_json)['statement']
      expect(result['due']).to eq((Date.today + 30).to_s)
    end

    it 'expect statement to include a period from date' do
      statement = Statement.new do
        from Date.parse( '2015-01-26' )
        call_charges do
          call '999' do
          end
        end
      end
      period = JSON.parse(statement.to_json)['statement']['period']
      expect(period['from']).to eq('2015-01-26')
    end

    it 'expect statement to include a period to date' do
      statement = Statement.new do
        to Date.parse( '2015-01-25' )
        call_charges do
          call '999' do
          end
        end
      end
      period = JSON.parse(statement.to_json)['statement']['period']
      expect(period['to']).to eq('2015-01-25')
    end

    it 'expect statement to include a call charges, called' do
      statement = Statement.new do
        call_charges do
          call '07716393769' do
          end
        end
      end
      call_charges = JSON.parse(statement.to_json)['statement']['callCharges']
      expect(call_charges.first['called']).to eq('07716393769')
    end

    it 'expect statement to include a call charges, call, date' do
      statement = Statement.new do
        call_charges do
          call '07716393769' do
            date Date.parse( '2015-02-01' )
          end
        end
      end
      call_charges = JSON.parse(statement.to_json)['statement']['callCharges']
      expect(call_charges.first['date']).to eq('2015-02-01')
    end

    it 'expect statement to include a call charges, call, duration' do
      statement = Statement.new do
        call_charges do
          call '07716393769' do
            duration '00:23:03'
          end
        end
      end
      call_charges = JSON.parse(statement.to_json)['statement']['callCharges']
      expect(call_charges.first['duration']).to eq('00:23:03')
    end

    it 'expect statement to include a call charges, call, cost' do
      statement = Statement.new do
        call_charges do
          call '07716393769' do
            cost 1.13
          end
        end
      end
      call_charges = JSON.parse(statement.to_json)['statement']['callCharges']
      expect(call_charges.first['cost']).to eq(1.13)
    end

    it 'expect statement to include a generated date and call charges, call, date' do
      statement = Statement.new do
        date Date.today
        call_charges do
          call '07716393769' do
            date Date.parse( '2015-02-01' )
          end
        end
      end
      result = JSON.parse(statement.to_json)['statement']
      expect(result['generated']).to eq(Date.today.to_s)
      expect(result['callCharges'].first['date']).to eq( '2015-02-01' )
    end

    it 'check the contents of an entire statement' do

      statement = Statement.new do
        date Date.today
        due(date + 30.days)
        from Date.parse('2015-01-26')
        to Date.parse('2015-02-25')

        call_charges do
          call '07716393769' do
            date Date.parse('2015-02-01')
            duration '00:23:04'
            cost 1.13
          end
          call '999' do
            date Date.parse('2015-02-02')
            duration '00:23:03'
            cost 0.20
          end
        end

      end
      result = JSON.parse(statement.to_json)['statement']
      expect(result['generated']).to eq(Date.today.to_s)
      expect(result['due']).to eq((Date.today + 30).to_s)
      expect(result['period']['from']).to eq('2015-01-26')
      expect(result['period']['to']).to eq('2015-02-25')
      expect(result['total']).to eq(1.33)
      first_call_charge = result['callCharges'][0]
      expect(first_call_charge['called']).to eq('07716393769')
      expect(first_call_charge['date']).to eq('2015-02-01')
      expect(first_call_charge['duration']).to eq('00:23:04')
      expect(first_call_charge['cost']).to eq(1.13)
      second_call_charge = result['callCharges'][1]
      expect(second_call_charge['called']).to eq('999')
      expect(second_call_charge['date']).to eq('2015-02-02')
      expect(second_call_charge['duration']).to eq('00:23:03')
      expect(second_call_charge['cost']).to eq(0.20)
    end
  end

  context 'invalid invocation' do
    it 'expect an exception when no block is supplied' do
      begin
        statement = Statement.new
        fail 'Expect a ArgumentError'
      rescue ArgumentError => error
        expect(error.to_s).to eq('A block must be supplied to this method.')
      end
    end
  end
end
