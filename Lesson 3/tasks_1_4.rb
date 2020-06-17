# frozen_string_literal: true

# 1
months = { January: 31,
           February: 29,
           March: 31,
           April: 30,
           May: 31,
           June: 30,
           Jule: 31,
           August: 31,
           September: 30,
           October: 31,
           November: 30,
           December: 31 }
months.each { |month, date| puts "#{month} #{date}" if date == 30 }

# 2
arr = []
(10..100).step(5).each { |e| arr << e }
puts arr

# 3
arr = [0, 1]
number = 0
while number <= 100
  number = arr[-1] + arr[-2]
  arr << number
end
puts arr

# 4
letters = %w[а б в г д е ё ж з и й к л м н о п р с т у ф х ц ч ш щ ъ ы ь э ю я]
transparent_letters = %w[а е ё и о у ы э ю я]
transparent_hash = {}
transparent_letters.each do |transparent_letter|
  transparent_hash[transparent_letter] = letters.index(transparent_letter)
end
puts transparent_hash
