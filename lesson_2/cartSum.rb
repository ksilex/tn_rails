cart = {}

loop do
  puts "Название товара:"
  name = gets.chomp

  break if name == "стоп"

  if !cart[name].nil? 
    puts "Изменить кол-во:"
    count = gets.chomp.to_f
    cart[name]["кол-во"] = count
    next
  end

  puts "Цена товара:"
  price = gets.chomp.to_f

  puts "Кол-во:"
  count = gets.chomp.to_f

  cart[name] = {"цена" => price, "кол-во" => count}
end

sum = 0
cart.each do |product, props|
  sum += props["цена"] * props["кол-во"]
end

puts "Сумма товаров в корзине:#{sum}"
