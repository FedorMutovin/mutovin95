# frozen_string_literal: true

require_relative 'cargo_train'
require_relative 'company'

class CargoWagon < CargoTrain
  extend Company
  def initialize
    @wagon_type = :cargo
  end
end
