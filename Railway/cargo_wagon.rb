# frozen_string_literal: true

require_relative 'cargo_train'
require_relative 'company'

class CargoWagon < CargoTrain
  attr_accessor :total, :taken_total
  attr_reader :number, :wagon_type
  extend Company
  def initialize(number, total)
    @wagon_type = :cargo
    @total = total
    @taken_total = 0
    @number = number
  end

  def take_total(user_total)
    self.taken_total = taken_total + user_total
  end

  def show_total
    total
  end

  def show_available_total
    raise 'Нет свободного обьема' if available_total.negative? || available_total.zero?

    available_total
  end

  private

  def available_total
    total - taken_total
  end

end
