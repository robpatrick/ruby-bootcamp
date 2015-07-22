require 'call_charges'
require 'json'

class Statement

  def initialize(&block)
    instance_eval &block if block_given?
  end

  def to_json
    {:generated => Date.today,
     :due => @due,
     :period => {:from => @from,
                 :to => @to },
     :total => @due,
     :callCharges => { :called => @call_charges.telephone_number,
                       :date => @call_charges.call_date,
                       :duration => @call_charges.call_duration,
                       :cost => @call_charges.call_cost}
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

class Fixnum
  def days
    self
  end
end