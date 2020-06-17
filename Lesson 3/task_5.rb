# frozen_string_literal: true

puts 'Введите дату в формате дд.мм.гггг'
user_date = gets.chomp.split('.')
day = user_date[0].to_i
month = user_date[1].to_i
year = user_date[2].to_i
days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days[1] = 29 if ((year % 4).zero? && (year % 100).zero? && (year % 400).zero?) ||
                ((year % 4).zero? && (year % 100).positive?)
past_days = []
(0..month - 1).each { |e| past_days << days[e] }
date_number = past_days.inject(0) { |result, elem| result + elem } + day
puts date_number
