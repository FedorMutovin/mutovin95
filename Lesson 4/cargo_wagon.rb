# frozen_string_literal: true

require_relative 'cargo_train'

class CargoWagon < CargoTrain
  def initialize
    @wagon_type = :cargo
  end
end