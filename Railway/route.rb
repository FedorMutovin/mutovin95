require_relative 'instance_counter'
require_relative 'validator'

class Route
  include Validator
  include InstanceCounter
  attr_accessor :mid_stations, :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @mid_stations = []
    register_instance
  end

  def add_mid_station(station)
    mid_stations << station
  end

  def delete_mid_station(station)
    mid_stations.delete(station)
  end

  def show_stations_on_route
    stations.each(&:name)
  end

  def stations
    [start_station] + mid_stations + [end_station]
  end
end
