require_relative 'wait'

# Wait.until do
#    count = 0
#    p count == 0 ? false : true
#    count += 1
# end


result = true
count = 0
while result do
  result = (count == 0 ? true : false )
  count = count + 1
  p result
end
