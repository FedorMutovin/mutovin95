# frozen_string_literal: true

class Station
  attr_accessor :trains
  attr_reader :station_name

  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  def add_train(train)
    puts "Поезд #{train.number} прибыл на станцию #{station_name} "
    trains << train
    train.current_train_station(self)
  end

  def move_train(train)
    puts "Поезд #{train.number} покинул станцию #{station_name} "
    trains.delete(train)
  end

  def trains_on_station(type)
    trains_types = []
    puts 'Поезда на станции: '
    trains.each do |train|
      puts train.number
      trains_types << train.type
    end
    trains_types.select! { |train_type| train_type == type }
    puts "#{type} #{trains_types.length}"
  end
end
