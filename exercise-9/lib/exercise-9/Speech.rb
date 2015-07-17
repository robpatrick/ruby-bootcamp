module Speech
  def say (message)
    puts message.downcase
  end

  def shout(message)
    puts "#{message.upcase}!!!"
  end

  def greeting
    @greetings.sample
  end

  def farewell
    @goodbyes.sample
  end
end