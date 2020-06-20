module Tips
  MENU_TIPS = { '1.' => 'Создавать станции',
                '2.' => 'Создавать поезда',
                '3.' => 'Создавать маршруты и управлять станциями в нем',
                '4.' => 'Назначать маршрут поезду',
                '5.' => 'Добавлять вагоны к поезду',
                '6.' => 'Отцеплять вагоны от поезда',
                '7.' => 'Перемещать поезд по маршруту вперед и назад',
                '8.' => 'Просматривать список станций и список поездов на станции',
                '9.' => 'Заполнить обьем вагона(для грузовых)',
                '10.' => 'Занять место в вагоне(для пассажирских)',
                'Любая другая => ' => 'Выйти' }.freeze

  def show_menu_operations
    puts 'Программа управления железнодорожной станцией. Выберите номер операции'
    MENU_TIPS.each { |key, value| puts "#{key}#{value}" }
    user_answer
  end

  def show_train_types_tip
    puts "Нужно задать тип поезду, укажите номер
              1. Пассажирский
              2. Грузовой"
  end

  def show_user_stations_table
    user_stations.each { |e| puts "#{(user_stations.index(e) + 1)}.#{e.name}" }
    user_answer
  end

  def number_train_tip
    puts 'Введите номер поезда'
    user_answer
  end

  def show_change_root_menu
    puts 'Введите номер операции, которую нужно выполнить перед сохранением?
               1. Изменить начальную станцию
               2. Изменить конечную станцию
               3. Добавить промежуточную станцию
               4. Удалить промежуточную станцию
               5. Добавить станцию
               6. Удалить станцию
               7. Сохранить'
    user_answer
  end

  def show_change_station_text
    puts 'Выберите номер станции, на которую хотите заменить'
  end

  def show_user_trains_table
    user_trains.each { |e| puts "#{(user_trains.index(e) + 1)}.#{e.number}" }
    user_answer
  end

  def seats_tip
    puts 'Какое количество сидений добавить в вагон?'
    user_answer
  end

  def take_total_tip
    puts 'Какой обьем вы хотите занять?'
    user_answer
  end

  def total_tip
    puts 'Какое количество обьема добавить в вагон?'
    user_answer
  end

  def wagon_number_tip
    puts 'Укажите номер вагона?'
    user_answer
  end

  def show_train_with_wagons(train)
    puts "Номер поезда на станции: #{train.number}, тип: #{train.type},
          кол-во вагонов: #{train.wagons.length}"
    train_all_wagons(train)
  end

  def train_all_wagons(train)
    train.all_wagons do |wagon|
      puts "номер вагона: #{wagon.number},тип вагона: #{wagon.wagon_type}"
      if wagon.wagon_type == :passenger
        puts "места: #{wagon.show_all_seats},
              кол-во свободных мест #{wagon.show_empty_seats}"
      else
        puts "обьем: #{wagon.show_total},
              кол-во свободного обьема #{wagon.show_available_total}"
      end
    end
  end

  def add_station_name_tip
    puts 'Введите название станции'
    user_answer
  end

  def show_move_train_tip
    puts 'Куда вы хотите отправить поезд?
               1. На следующую станцию
               2. На предыдущую станцию'
    user_answer
  end

  def show_trains_by_type(type)
    user_trains.each do |train|
      puts "#{user_trains.index(train) + 1}. #{train.number}" if train.type == type
    end
    user_answer
  end

  def show_wagons_table(train_index, wagon)
    puts "#{user_trains[index(train_index)].wagons.index(wagon) + 1}. #{wagon.number}"
    user_answer
  end

  def seat_question
    puts 'В каком вагоне вы хотели бы занять место?'
  end

  def show_change_station_tips
    show_change_station_text
    show_user_stations_table
  end

  def mid_stations_table(user_route)
    user_route.mid_stations.each do |e|
      puts "#{(user_route.mid_stations.index(e) + 1)}.#{e.name}"
    end
    user_answer
  end

  def show_train_wagons
    puts 'Выберите вагон, который хотите удалить'
    @user_train.wagons.each do |e|
      puts "#{(@user_train.wagons.index(e) + 1)}.#{e.number}"
    end
  end

  def show_user_route_table
    user_routes.each { |e| puts "#{(user_routes.index(e) + 1)}.#{e.stations}" }
    user_answer
  end
end
