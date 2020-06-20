require_relative 'validator'
require_relative 'instance_counter'

class Station
  include Validator
  include InstanceCounter

  attr_accessor :trains
  attr_reader :name
  class << self
    attr_reader :all
  end
  @all = []

  def initialize(name)
    @name = name
    @trains = []
    self.class.all << self
    register_instance
  end

  def add_train(train)
    trains << train
    train.current_train_station(self)
  end

  def move_train(train)
    trains.delete(train)
  end

  def trains_on_station
    trains.each { |train| yield(train) }
  end
end
