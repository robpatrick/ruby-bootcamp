module Speech

  def self.included(base)
    puts "Module included in #{base}"
  end

  def say (message)
    puts message.downcase
  end

  def shout(message)
    puts "#{message.upcase}!!!"
  end

  def greeting
    greetings.sample
  end

  def farewell
    goodbyes.sample
  end

  def tell_me_the_time
    say "#{greeting}, the time is #{Time.now}"
  end

  private

  def greetings
    @greetings ||= ['hello', 'good day', "what's up", 'yo', 'hi', 'sup', 'hey']
  end

  def goodbyes
    @goodbyes ||= ['goodbye', 'see you later', 'in a while crocodile', 'l8rs', 'bye for now']
  end
end