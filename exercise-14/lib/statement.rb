require 'json'

class Statement

  def initialize(&block)
    raise ArgumentError, 'A block must be supplied to this method.' unless block_given?
    instance_eval &block if block_given?
  end

  def to_json

    calls = Array.new

    @call_charges.calls.each do |call|
      calls << {:called => call.telephone_number,
                :date => call.call_date,
                :duration => call.call_duration,
                :cost => call.call_cost}
    end

    {:statement => {
        :generated => Date.today,
        :due => @due,
        :period => {:from => @from,
                    :to => @to},
        :total => @call_charges.total,
        :callCharges => calls
    }}.to_json
  end

  def date(date = nil)
    if date
      @date = date
    else
      @date
    end
  end

  def due(due_date)
    @due = due_date.to_s
  end

  def from(from_date)
    @from = from_date
  end

  def to(to_date)
    @to = to_date
  end

  def call_charges(&block)
    @call_charges = CallCharges.new(&block)
  end

end

class CallCharges

  attr_reader :calls

  def initialize(&block)
    @calls = Array.new
    instance_eval &block if block_given?
  end

  def call(telephone_number, &block)
    @calls.push(Call.new(telephone_number, &block)) if block_given?
  end

  def total
    @calls.map { |call| call.call_cost || 0 }.inject(:+).round(2)
  end

end

class Call

  attr_reader :telephone_number, :call_date, :call_duration, :call_cost

  def initialize(telephone_number, &block)
    @telephone_number = telephone_number
    instance_eval &block if block_given?
  end

  def date(date)
    @call_date = date
  end

  def duration(duration)
    @call_duration = duration
  end

  def cost(cost)
    @call_cost = cost
  end
end

class Fixnum
  def days
    self
  end
end