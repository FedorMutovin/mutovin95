# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  def initialize
    @variety = :cargo
  end
end
