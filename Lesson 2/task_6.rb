# frozen_string_literal: true

products = {}

loop do
puts 'Введите название товара?'
product_name = gets.chomp
break if product_name == 'стоп'

puts 'Введите цену за единицу?'
price = gets.to_f
puts 'Введите количество товара'
product_quantity = gets.to_f
products[product_name] = { price: price, product_quantity: product_quantity }
end
product_sum = 0
puts products
products.each do |key, value|
  puts "#{key}, кол-во: #{value[:product_quantity]}, цена: #{value[:price] * value[:product_quantity]}"
  product_sum += value[:price] * value[:product_quantity]
end
puts "Итоговая цена: #{product_sum}"
