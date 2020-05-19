# frozen_string_literal: true

puts 'Введите основание треугольника'
a = gets.to_f
puts 'Введите высоту треугольника'
h = gets.to_f
triangle_area = (1.0 / 2) * a * h
puts "Площадь треугольника равна #{triangle_area}"
