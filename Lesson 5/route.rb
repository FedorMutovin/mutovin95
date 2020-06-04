# frozen_string_literal: true

class Route
  require_relative 'instance_counter'
  attr_accessor :intermediate_stations, :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @intermediate_stations = []
    register_instance
  end

  def add_intermediate_station(station)
    intermediate_stations << station
    puts "В маршрут добавлена промежуточная станция #{station.name}"
  end

  def delete_intermediate_station(station)
    intermediate_stations.delete(station)
    puts "Из маршрута исключена промежуточная станция #{station.name}"
  end

  def show_stations_on_route
    puts 'Станции по маршруту: '
    stations.each { |station| puts station.name }
  end

  def stations
    [start_station] + intermediate_stations + [end_station]
  end
end
