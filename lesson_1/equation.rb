puts "Введите a"
a = gets.chomp.to_f

puts "Введите b"
b = gets.chomp.to_f

puts "Введите c"
c = gets.chomp.to_f

d = b**2 - 4 * a * c

if d<0
  puts "Уравнение не имеет корней"
elsif d==0
  x1 = -b / (2 * a)
  puts "x1 и х2 равны: #{x1}"
else
  dSqrt = Math.sqrt(d)
  x1 = (-b + dSqrt) / (2 * a)
  x2 = (-b -dSqrt) / (2 * a)
  puts "Первый корень равен: #{x1}\nВторой корень равен:#{x2}"
end
