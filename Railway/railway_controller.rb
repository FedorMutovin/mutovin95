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
require_relative 'railway_model'
require_relative 'accessors'
require_relative 'validation'

class RailwayController < RailwayModel
  include Validation
  include Validator
  include Tips
  attr_accessor :user_stations, :user_trains, :user_routes, :user_train,
                :user_route, :answer

  def initialize
    @user_stations = []
    @user_trains = []
    @user_routes = []
  end

  OPERATIONS = { '1' => :add_station, '2' => :add_train, '3' => :add_route,
                 '4' => :add_train_route, '5' => :add_wagon_to_train,
                 '6' => :delete_train_wagon, '7' => :move_train,
                 '8' => :show_user_stations, '9' => :take_wagon_total,
                 '10' => :take_wagon_seat }.freeze

  CHANGE_ROOT_OPERATIONS = { '1' => :change_first_station,
                             '2' => :change_second_station,
                             '3' => :add_intermediate_station,
                             '4' => :delete_intermediate_station,
                             '5' => :add_station,
                             '6' => :delete_station }.freeze

  def menu
    loop do
      show_menu_operations
      break if OPERATIONS[answer].nil?

      send OPERATIONS[answer]
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
end
