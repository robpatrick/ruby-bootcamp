require 'rspec'
require 'date'
require 'json'

require_relative '../../exercise-14/lib/statement'

describe Statement do

  it 'should do something' do

    statement = Statement.new do
      date Date.today
      due(date + 30.days)
      from Date.parse('2015-01-26')
      to Date.parse('2015-02-25')

      call_charges do
        call '07716393769' do
          date Date.parse('2015-02-01')
          duration "00:23:03"
          cost 1.13
        end
        call '07716393769' do
          date Date.parse('2015-02-01')
          duration "00:23:03"
          cost 0.20
        end
      end

    end
    result = JSON.parse(statement.to_json)
    expect(result['generated']).to eq(Date.today.to_s)
    expect(result['due']).to eq((Date.today + 30).to_s)
    expect(result['period']['from']).to eq('2015-01-26')
    expect(result['period']['to']).to eq('2015-02-25')
    #expect(result['total']).to eq('1.23')
  end

  describe '#to_json' do

    it 'statement should include a date' do
      statement = Statement.new do
        date Date.today
        call_charges do
        end
      end
      expect(statement.to_json).to include( '2015-07-22' )
    end
    it 'statement should include a due date' do
      statement = Statement.new do
        date Date.today
        due(date + 30.days)
        call_charges do
        end
      end
      expect(statement.to_json).to include( '2015-08-21' )
    end
    it 'statement should include a from date' do
      statement = Statement.new do
        from Date.parse( '2015-01-26' )
        call_charges do
        end
      end
      expect(statement.to_json).to include( "2015-01-26" )
    end
    it 'statement should include a to date' do
      statement = Statement.new do
        to Date.parse( '2015-01-25' )
        call_charges do
        end
      end
      expect(statement.to_json).to include( "2015-01-25" )
    end
    it 'statement should include a call charges, call' do
      statement = Statement.new do
        call_charges do
          call '07716393769'
        end
      end
      expect(statement.to_json).to include( "07716393769" )
    end
    it 'statement should include a call charges, call, date' do
      statement = Statement.new do
        call_charges do
          call '07716393769' do
            call Date.parse( '2015-02-01' )
          end
        end
      end
      expect(statement.to_json).to include( "2015-02-01" )
    end
    it 'statement should include a call charges, call, duration' do
      statement = Statement.new do
        call_charges do
          call '07716393769' do
            duration '00:23:03'
          end
        end
      end
      expect(statement.to_json).to include( "00:23:03" )
    end
    it 'statement should include a call charges, call, cost' do
      statement = Statement.new do
        call_charges do
          call '07716393769' do
            cost 1.13
          end
        end
      end
      expect(statement.to_json).to include( "1.13" )
    end

    it 'statement should include a date and call charges, call, date' do
      statement = Statement.new do
        date Date.today
        call_charges do
          call '07716393769' do
            date Date.parse( '2015-02-01' )
          end
        end
      end
      expect(statement.to_json).to include( "2015-07-22" )
      expect(statement.to_json).to include( "2015-02-01" )
    end
  end

end