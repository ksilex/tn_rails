puts "Введите число"
dd = gets.chomp.to_i

puts "Введите месяц"
mm = gets.chomp.to_i

puts "Введите год"
yy = gets.chomp.to_i

days_in_mm = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if (yy % 4 == 0 && yy % 100 != 0) || (yy % 400 == 0)
  days_in_mm[1] = 29
end

days_count = 0

days_in_mm[0...mm - 1].each do |month_days|
  days_count += month_days
end

days_count += dd
puts "Кол-во дней: #{days_count}"
