# frozen_string_literal: true

require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'passenger_train'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'main'
require_relative 'validator'
require_relative 'tips'

class Railway
  include Validator
  include Tips
  attr_accessor :user_stations, :user_trains, :user_routes, :user_train,
                :user_route, :answer

  def initialize
    @user_stations = []
    @user_trains = []
    @user_routes = []
  end

  def menu
    loop do
      show_menu_operations
      user_answer
      case answer
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
      when '9'
        take_wagon_total
      when '10'
        take_wagon_seat
      else
        break
      end
    end
  end

  def add_station
    loop do
      add_station_name_tip
      add_user_station
      puts 'Ваши станции, выйти (n), продолжить, любую другую клавишу'
      show_user_stations_table
      break unless continue_create?
    end
  end

  def add_train
    loop do
      number_train_tip
      add_user_train
      puts 'Ваши поезда, выйти (n), продолжить, любую другую клавишу'
      show_user_trains_table
      break unless continue_create?
    end
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def add_route
    validate_route_stations
    puts 'Выберите номер начальной станции'
    show_user_stations_table
    start_station = user_station(answer)
    puts 'Выберите номер конечной станции'
    show_user_stations_table
    end_station = user_station(answer)
    user_route = Route.new(start_station, end_station)
    puts 'Маршрут добавлен'
    change_root(user_route)
  end

  def add_train_route
    choose_user_train
    choose_user_route
    @user_train.add_route(@user_route)
  end

  def add_wagon_to_train
    choose_user_train
    wagon_number_tip
    wagon_number = answer
    if @user_train.type == :passenger
      seats_tip
      @user_train.add_passenger_wagon(answer, wagon_number)
    else
      total_tip
      @user_train.add_cargo_wagon(answer, wagon_number)
    end
  end

  def delete_train_wagon
    choose_user_train
    validate_wagons
    wagon = @user_train.wagons[answer.to_i - 1]
    @user_train.delete_wagon(wagon)
  end

  def move_train
    show_move_train_tip
    case answer
    when '1'
      move_train_to_next_station
    when '2'
      move_train_to_last_station
    else
      raise 'Введено неверное значение'
    end
  end

  def show_user_stations
    validate_stations
    user_stations.each do |user_station|
      puts "Станция: #{user_station.name}"
      user_station.trains_on_station do |train|
        show_train_with_wagons(train)
      end
    end
  end

  def take_wagon_seat
    validate_user_passenger_trains
    puts 'В каком пассажирском поезде вы хотите занять вагон?'
    take_wagon(:passenger)
    @user_wagon.take_seat
  end

  def take_wagon_total
    validate_user_cargo_trains
    take_total_tip
    puts 'В каком грузовом поезде вы хотите занять обьем?'
    take_wagon(:cargo)
    @user_wagon.take_total(answer)
  end

  private

  def delete_station
    puts 'Выберите номер станции, которую хотите удалить'
    show_user_stations_table
    delete_station = user_station(answer)
    user_stations.delete(delete_station)
    puts 'Станция удалена'
  end

  def add_user_station
    station = Station.new(answer)
    user_stations << station
  end

  def add_user_train
    user_train = Train.new(answer)
    user_train.add_type
    user_trains << user_train
  end

  def user_station(station)
    user_stations[station.to_i - 1]
  end

  def continue_create?
    answer != 'n'
  end

  def take_wagon(type)
    show_trains_by_type(type)
    train_index = answer
    take_seat_validate(train_index)
    seat_question
    choose_wagon_for_take(train_index)
  end

  def user_routes?
    return unless user_routes.empty?

    raise 'Нужно создать как минимум один маршрут'
  rescue RuntimeError
    add_route
  end

  def choose_user_train
    validate_train
    puts 'Выберите поезд'
    show_user_trains_table
    @user_train = user_trains[answer.to_i - 1]
  rescue RuntimeError
    add_train
  end

  def choose_user_route
    user_routes?
    puts 'Выберите маршрут'
    show_user_route_table
    @user_route = user_routes[answer.to_i - 1]
  end

  def choose_wagon_for_take(train_index)
    user_trains[index(train_index)].all_wagons do |wagon|
      show_wagons_table(train_index, wagon)
      @user_wagon = user_trains[index(train_index)].wagons[answer.to_i - 1]
    end
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

  def change_station(user_route)
    yield(user_route)
    puts 'Cтанция изменена'
    user_route.show_stations_on_route
  end

  def delete_intermediate_station(user_route)
    puts 'Выберите номер промежуточной станции, которую хотите удалить'
    mid_stations_table(user_route)
    delete_mid_station = user_route.mid_stations[answer.to_i - 1]
    user_route.delete_mid_station(delete_mid_station)
    user_route.show_stations_on_route
  end

  def add_intermediate_station(user_route)
    puts 'Выберите номер станции, которую хотите добавить как промежуточную'
    show_user_stations_table
    mid_station = user_station(answer)
    user_route.add_mid_station(mid_station)
    puts 'Промежуточная станция изменена'
    user_route.show_stations_on_route
  end

  def change_first_station(user_route)
    show_change_station_tips
    change_station(user_route) { |x| x.start_station = user_station(answer) }
  end

  def change_second_station(user_route)
    show_change_station_tips
    change_station(user_route) { |x| x.end_station = user_station(answer) }
  end

  def user_answer
    self.answer = gets.chomp
  end

  def index(number)
    number.to_i - 1
  end

  def change_root(user_route)
    loop do
      show_change_root_menu
      case answer
      when '1'
        change_first_station(user_route)
      when '2'
        change_second_station(user_route)
      when '3'
        add_intermediate_station(user_route)
      when '4'
        delete_intermediate_station(user_route)
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
