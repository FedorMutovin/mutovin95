# frozen_string_literal: true

class Station
  attr_accessor :trains
  attr_reader :station_name

  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  def train_arrives(train)
    puts "Поезд #{train.train_number} прибыл на станцию #{station_name} "
    trains << train
    train.current_train_station(self)
  end


  def train_leaves(train)
    puts "Поезд #{train.train_number} покинул станцию #{station_name} "
    trains.delete(train)
  end

  def trains_on_station
    passengers_train = []
    freight_train = []
    trains.each do |train|
      if train.passenger_train
        passengers_train << train
      elsif train.freight_train
        freight_train << train
      end
      puts "Поезда на станции: #{train.train_number}"
    end
    puts " Пассажирских #{passengers_train.length}, Грузовых #{freight_train.length}"
  end
end
