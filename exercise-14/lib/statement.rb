require 'json'
require 'money'

class Statement

  def initialize(&block)
    instance_eval &block if block_given?
  end

  def to_json

    {:generated => Date.today,
     :due => @due,
     :period => {:from => @from,
                 :to => @to },
     :total => @call_charges.total,
     :callCharges => { :called => @call_charges.calls[0].telephone_number,
                       :date => @call_charges.calls[0].call_date,
                       :duration => @call_charges.calls[0].call_duration,
                       :cost => @call_charges.calls[0].call_cost}
    }.to_json
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

  def total

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
    @calls.push( Call.new(telephone_number, &block) ) if block_given?
  end

  def total
    @calls.map{|call| call.call_cost || 0 }.inject(:+).round(2)
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