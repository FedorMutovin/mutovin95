# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  def initialize(cargo_train)
    @cargo_train = cargo_train
  end
end
