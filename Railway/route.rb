# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validator'

class Route
  include Validator
  include InstanceCounter
  attr_accessor :intermediate_stations, :start_station, :end_station

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @intermediate_stations = []
    register_instance
  end

  def add_intermediate_station(station)
    intermediate_stations << station
  end

  def delete_intermediate_station(station)
    intermediate_stations.delete(station)
  end

  def show_stations_on_route
    stations.each(&:name)
  end

  def stations
    [start_station] + intermediate_stations + [end_station]
  end
end
