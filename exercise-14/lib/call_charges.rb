class CallCharges

  attr_reader :call_date, :call_duration, :telephone_number, :call_cost

  def initialize(&block)
    instance_eval &block if block_given?
  end

  def call(telephone_number, &block)
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