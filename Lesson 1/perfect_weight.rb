# frozen_string_literal: true

puts 'Введите ваше имя?'
name = gets.chomp
puts 'Введите ваш рост?'
height = gets.to_f
perfect_weight = (height - 110) * 1.15
if perfect_weight.negative?
  puts "#{name}, твой вес оптимален"
else
  puts "#{name}, твой идеальный вес #{perfect_weight} кг."
end
