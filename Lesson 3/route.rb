# frozen_string_literal: true

class Route
  attr_accessor :intermediate_stations
  attr_reader :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @intermediate_stations = []
  end

  def add_intermediate_station(station)
    puts "В маршрут добавлена промежуточная станция #{station.station_name}"
    intermediate_stations << station
  end

  def delete_intermediate_station(station)
    puts "Из маршрута исключена промежуточная станция #{station.station_name}"
    intermediate_stations.delete(station)
  end

  def show_stations_on_route
    puts 'Станции по маршруту: '
    stations.each { |station| puts station.station_name }
  end

  def stations
    [start_station] + intermediate_stations + [end_station]
  end

end
