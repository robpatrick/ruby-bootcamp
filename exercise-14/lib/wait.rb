module Wait
  def self.until(retry_time: 0, expire_after: 5)
    raise ArgumentError, 'A block must be supplied to this method.' unless block_given?
    time_limit = Time.new + expire_after
    result = yield
    until result do
      raise ExecutionExpiryException, "The expiry time of #{expire_after} seconds has been reached." if (Time.new <=> time_limit) == 1
      sleep(retry_time)
      result = yield
    end
    result
  end

  class ExecutionExpiryException < StandardError; end
end
