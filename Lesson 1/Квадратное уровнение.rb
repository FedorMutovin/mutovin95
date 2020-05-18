puts "Введите первый коэффициент"
a = gets.to_i
puts "Введите второй коэффициент"
b = gets.to_i
puts "Введите третий коэффициент"
c = gets.to_i

discriminant = b**2 - 4*a*c
minor_b = ~b + 1

if discriminant < 0
  puts "Корней нет"
elsif discriminant == 0
  x = minor_b/(2*a)
  puts "Дискриминант равен #{discriminant}, 1 корень #{x}"
else
  first_x = (minor_b + Math.sqrt(discriminant))/(2*a)
  second_x = (minor_b - Math.sqrt(discriminant))/(2*a)
  puts "Два корня, Х1 = #{first_x}, Х2 = #{second_x}"
end