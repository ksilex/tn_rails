first = 0
second = 1
arr = []

loop do
  arr.push(first)
  first, second = second, first + second
  if first > 100
    break
  end
end

print "#{arr}\n"