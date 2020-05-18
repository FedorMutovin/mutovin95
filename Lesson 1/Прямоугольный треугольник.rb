puts "Введите значение гипотенузы"
hypotenuse = gets.to_i
puts "Введите значение 1ого катета"
first_side = gets.to_i
puts "Введите значение 2ого катета"

second_side = gets.to_i
equilateral_triangle = (hypotenuse == first_side && first_side == second_side)
isosceles_triangle = (hypotenuse == first_side || first_side == second_side || second_side == hypotenuse)
right_triangle = (hypotenuse**2) == (first_side**2 + second_side**2)

case true
when equilateral_triangle
  puts "Ваш треугольник равносторонний"
when isosceles_triangle
  puts "Ваш треугольник равнобедренный"
when right_triangle
  puts "Ваш треугольник прямоугольный"
else
  puts "Прикольный треугольник:)"
end

