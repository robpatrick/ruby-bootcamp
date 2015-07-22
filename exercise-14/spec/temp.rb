fiber_counter = Fiber.new do
  i = 0
  while true
    i += 1
    Fiber.yield i
  end
end

puts fiber_counter.resume
puts fiber_counter.resume
puts fiber_counter.resume
puts fiber_counter.resume

enum_counter = Enumerator.new do |y|
  i = 0
  while true
    i += 1
    y.yield i
  end
end

puts enum_counter.next
puts enum_counter.next
puts enum_counter.next
puts enum_counter.next

fiber = Fiber.new do
  Fiber.yield 1
  2
end

puts fiber.resume
puts fiber.resume
puts fiber.resume