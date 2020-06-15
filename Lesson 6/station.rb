# frozen_string_literal: true

require_relative 'validator'
require_relative 'instance_counter'

class Station
  include Validator

  attr_accessor :trains
  attr_reader :name
  @@all = []
  def self.all
    @@all
  end

  def initialize(name)
    @name = name.to_s
    @trains = []
    @@all << self
    register_instance
  end

  def add_train(train)
    puts "Поезд #{train.number} прибыл на станцию #{name} "
    trains << train
    train.current_train_station(self)
  end

  def move_train(train)
    puts "Поезд #{train.number} покинул станцию #{name} "
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
