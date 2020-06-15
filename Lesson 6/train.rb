# frozen_string_literal: true

require_relative 'company'
require_relative 'instance_counter'
require_relative 'validator'

class Train
  include Validator
  include InstanceCounter
  extend Company

  attr_accessor :speed, :route, :wagons, :type, :number
  attr_reader :number

  @@trains = {}
  def self.find(train_number)
    @@trains[train_number]
  end

  def initialize(number)
    @number = number.to_s
    @wagons = []
    @speed = 0
    @@trains[number] = self
    validate_number!
    register_instance
  end

  def disperse(speed)
    self.speed += speed
  end

  def current_speed
    puts "Текущая скорость: #{speed}"
  end

  def stop
    self.speed = 0
  end

  def show_number_of_wagons
    puts "Количество вагонов поезда: #{wagons.length}"
  end

  def add_route(route)
    @route = route
    @route.start_station.add_train(self)
  end

  def move_to_next_station
    if current_station_index + 1 > route_stations.index(route_stations[-1])
      raise 'Поезд не может покинуть пределы маршрута'
    end

    @current_station.move_train(self)
    @current_station = next_station
    @current_station.add_train(self)
  end

  def move_to_last_station
    if (current_station_index - 1).negative?
      raise 'Поезд не может покинуть пределы маршрута'
    end

    @current_station.move_train(self)
    @current_station = last_station
    @current_station.add_train(self)
  end

  def last_station
    route_stations[current_station_index - 1]
  end

  def next_station
    route_stations[current_station_index + 1]
  end

  def route_stations
    @route.stations
  end

  def current_train_station(station)
    @current_station = station
  end

  def add_wagon(wagon)
    raise 'Данный вагон уже добавлен к поезду' if wagons.include?(wagon)
    unless speed.zero?
      raise 'Поезд движется! Для изменения количества вагонов остановите поезд'
    end

    wagons << wagon
  end

  def delete_wagon(wagon)
    unless speed.zero?
      raise 'Поезд движется! Для изменения количества вагонов остановите поезд'
    end

    wagons.delete(wagon)
  end

  def add_passenger_wagon
    passenger_wagon = PassengerWagon.new
    add_wagon(passenger_wagon)
  end

  def add_cargo_wagon
    cargo_wagon = CargoWagon.new
    add_wagon(cargo_wagon)
  end

  protected

  # для определения типа вагона

  attr_reader :variety, :wagon_type

  private

  # для вычисления индекса станции

  def current_station_index
    @route.stations.index(@current_station)
  end

end
