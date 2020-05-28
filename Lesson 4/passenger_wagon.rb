# frozen_string_literal: true

require_relative 'passenger_train'

class PassengerWagon < PassengerTrain
  def initialize
    @wagon_type = :passenger
  end
end