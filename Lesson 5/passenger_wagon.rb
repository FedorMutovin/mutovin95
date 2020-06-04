# frozen_string_literal: true

require_relative 'passenger_train'
require_relative 'company'

class PassengerWagon < PassengerTrain
  extend Company
  def initialize
    @wagon_type = :passenger
  end
end
