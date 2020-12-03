first = 0
second = 1
arr = []

while first <= 100
  arr.push(first)
  first, second = second, first + second
end

print "#{arr}\n"
