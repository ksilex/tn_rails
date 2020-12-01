puts "Ваше имя"
name = gets.chomp

puts "Ваш рост"
height = gets.chomp.to_i

coef = (height - 110) * 1.15

if coef < 0 
  puts "Ваш вес уже оптимальный"
else
  puts "#{name}, ваш идеальный вес равен #{coef.round(2)}"
end
