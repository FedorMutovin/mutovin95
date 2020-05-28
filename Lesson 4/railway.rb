# frozen_string_literal: true

require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'passenger_train'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'main'

class Railway
  attr_accessor :user_stations, :user_trains, :user_routes, :user_train, :user_route

  def initialize
    @user_stations = []
    @user_trains = []
    @user_routes = []
  end

  def menu
    loop do
      puts 'Программа управления железнодорожной станцией. Выберите номер операции
             1. Создавать станции
             2. Создавать поезда
             3. Создавать маршруты и управлять станциями в нем (добавлять, удалять)
             4. Назначать маршрут поезду
             5. Добавлять вагоны к поезду
             6. Отцеплять вагоны от поезда
             7. Перемещать поезд по маршруту вперед и назад
             8. Просматривать список станций и список поездов на станции
             9. Выйти'
      operation = gets.chomp
      case operation
      when '1'
        add_station
      when '2'
        add_train
      when '3'
        add_route
      when '4'
        add_train_route
      when '5'
        add_wagon_to_train
      when '6'
        delete_train_wagon
      when '7'
        move_train
      when '8'
        show_user_stations
      else
        break
      end
    end
  end

  def add_station
    loop do
      puts 'Введите название станции'
      user_station = gets.chomp
      station = Station.new(user_station)
      user_stations << station
      puts 'Ваши станции, чтобы выйти (n), чтобы продолжить, любую другую клавишу'
      user_stations.each { |e| puts e.name }
      answer = gets.chomp
      break if answer == 'n'
    end
  end

  def delete_station
    puts 'Выберите номер станции, на которую хотите удалить'
    user_stations.each { |e| puts "#{(user_stations.index(e) + 1)}.#{e.name}" }
    user_station = gets.chomp
    delete_station = user_stations[user_station.to_i - 1]
    user_stations.delete(delete_station)
    puts 'Станция удалена'
  end

  def add_train
    loop do
      puts 'Введите номер поезда'
      user_train = gets.chomp
      train = Train.new(user_train)
      while train.type.nil?
        puts "Нужно задать тип поезду, укажите номер
              1. Пассажирский
              2. Грузовой"
        user_train_type = gets.chomp
        if user_train_type == '1'
          train.add_passenger_type
        elsif user_train_type == '2'
          train.add_cargo_type
        else
          puts 'Тип не задан'
        end
      end
      user_trains << train
      puts 'Ваши поезда, чтобы выйти (n), чтобы продолжить, любую другую клавишу'
      user_trains.each { |e| puts e.number }
      answer = gets.chomp
      break if answer == 'n'
    end
  end

  def add_route
    if user_stations.empty? || user_stations.length < 2
      puts 'Для того чтобы построить маршрут, вам нужно создать минимум 2 станции'
      add_station
    else
      puts 'Выберите номер начальной станции'
      user_stations.each { |e| puts "#{(user_stations.index(e) + 1)}.#{e.name}" }
      user_station = gets.chomp
      start_station = user_stations[user_station.to_i - 1]
      puts 'Выберите номер конечной станции'
      user_stations.each { |e| puts "#{(user_stations.index(e) + 1)}.#{e.name}" }
      user_station = gets.chomp
      end_station = user_stations[user_station.to_i - 1]
      user_route = Route.new(start_station, end_station)
      puts 'Маршрут добавлен'
      change_root(user_route)
    end
  end

  def add_train_route
    choose_user_train
    choose_user_route
    @user_train.add_route(@user_route)
  end

  def add_wagon_to_train
    choose_user_train
    if @user_train.type == :passenger
      @user_train.add_passenger_wagon
    else
      @user_train.add_cargo_wagon
    end
  end

  def delete_train_wagon
    choose_user_train
    if @user_train.wagons.empty?
      puts 'У поезда отсутствуют вагоны'
    else
      puts 'Выберите вагон, который хотите удалить'
      @user_train.wagons.each { |e| puts "#{(@user_train.wagons.index(e) + 1)}.#{e}" }
      user_wagon = gets.chomp
      wagon = @user_train.wagons[user_wagon.to_i - 1]
      @user_train.delete_wagon(wagon)
    end
  end

  def move_train
    puts 'Куда вы хотите отправить поезд?
               1. На следующую станцию
               2. На предыдущую станцию'
    operation = gets.chomp
    case operation
    when '1'
      move_train_to_next_station
    when '2'
      move_train_to_last_station
    else
      puts 'Введено неверное значение'
    end
  end

  def show_user_stations
    if user_stations.empty?
      'Нет доступных станций'
    else
      puts 'Ваши станции. Выберите станцию, для просмотра на ней списка поездов'
      choose_user_stations
      user_station = gets.chomp
      station = user_stations[user_station.to_i - 1]
      puts 'Какой тип поезда вы хотите посмотреть на станции?
               1. Пассажирские
               2. Грузовые'
      answer = gets.chomp
      if answer == '1'
        station.trains_on_station(:passenger)
      elsif answer == '2'
        station.trains_on_station(:cargo)
      else
        puts 'Неверный тип поезда'
      end
    end
  end

  private

  def change_station_text
    puts 'Выберите номер станции, на которую хотите заменить'
  end

  def choose_user_stations
    user_stations.each { |e| puts "#{(user_stations.index(e) + 1)}.#{e.name}" }
  end

  def user_trains?
    return unless user_trains.empty?

    puts 'Нужно создать как минимум один поезд'
    add_train
  end

  def user_routes?
    return unless user_routes.empty?

    puts 'Нужно создать как минимум один маршрут'
    add_route
  end

  def choose_user_train
    user_trains?
    puts 'Выберите поезд'
    user_trains.each { |e| puts "#{(user_trains.index(e) + 1)}.#{e.number}" }
    train = gets.chomp
    @user_train = user_trains[train.to_i - 1]
  end

  def choose_user_route
    user_routes?
    puts 'Выберите маршрут'
    user_routes.each { |e| puts "#{(user_routes.index(e) + 1)}.#{e.stations}" }
    route = gets.chomp
    @user_route = user_routes[route.to_i - 1]
  end

  def train_have_route
    @user_train.add_train_route if @user_train.route.nil?
  end

  def move_train_to_next_station
    choose_user_train
    train_have_route
    @user_train.move_to_next_station
  end

  def move_train_to_last_station
    choose_user_train
    train_have_route
    @user_train.move_to_last_station
  end

  def change_root(user_route)
    loop do
      puts 'Введите номер операции, которую нужно выполнить перед сохранением?
               1. Изменить начальную станцию
               2. Изменить конечную станцию
               3. Добавить промежуточную станцию
               4. Удалить промежуточную станцию
               5. Добавить станцию
               6. Удалить станцию
               7. Сохранить'
      operation = gets.chomp
      case operation
      when '1'
        change_station_text
        choose_user_stations
        user_station = gets.chomp
        user_route.start_station = user_stations[user_station.to_i - 1]
        puts 'Начальная станция изменена'
        user_route.show_stations_on_route
      when '2'
        change_station_text
        choose_user_stations
        user_station = gets.chomp
        user_route.end_station = user_stations[user_station.to_i - 1]
        puts 'Конечная станция изменена'
        user_route.show_stations_on_route
      when '3'
        puts 'Выберите номер станции, которую хотите добавить как промежуточную'
        choose_user_stations
        user_station = gets.chomp
        intermediate_station = user_stations[user_station.to_i - 1]
        user_route.add_intermediate_station(intermediate_station)
        puts 'Промежуточная станция изменена'
        user_route.show_stations_on_route
      when '4'
        puts 'Выберите номер промежуточной станции, которую хотите удалить'
        user_route.intermediate_stations.each { |e| puts "#{(user_route.intermediate_stations.index(e) + 1)}.#{e.name}" }
        user_station = gets.chomp
        delete_intermediate_station = user_route.intermediate_stations[user_station.to_i - 1]
        user_route.delete_intermediate_station(delete_intermediate_station)
        user_route.show_stations_on_route
      when '5'
        add_station
      when '6'
        delete_station
      else
        user_routes << user_route
        break
      end
    end
  end
end
