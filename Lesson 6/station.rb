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
    trains << train
    train.current_train_station(self)
  end

  def move_train(train)
    trains.delete(train)
  end

  def trains_on_station(type)
    trains_types = []
    trains.each do |train|
      trains_types << train.type
    end
    trains_types.select! { |train_type| train_type == type }
  end
end
