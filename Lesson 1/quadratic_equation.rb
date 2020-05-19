# frozen_string_literal: true

puts 'Введите первый коэффициент'
a = gets.to_f
puts 'Введите второй коэффициент'
b = gets.to_f
puts 'Введите третий коэффициент'
c = gets.to_f

discriminant = b**2 - 4 * a * c
minor_b = ~b + 1
discriminant_square_root = Math.sqrt(discriminant)

if discriminant.negative?
  puts 'Корней нет'
elsif discriminant.zero?
  x = minor_b / (2 * a)
  puts "Дискриминант равен #{discriminant}, 1 корень #{x}"
else
  first_x = (minor_b + discriminant_square_root) / (2 * a)
  second_x = (minor_b - discriminant_square_root) / (2 * a)
  puts "Два корня, Х1 = #{first_x}, Х2 = #{second_x}"
end
