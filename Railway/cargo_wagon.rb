# frozen_string_literal: true

require_relative 'cargo_train'
require_relative 'company'
require_relative 'validator'

class CargoWagon < CargoTrain
  attr_accessor :total, :taken_total
  attr_reader :number, :wagon_type
  extend Company
  include Validator
  def initialize(number, total)
    @wagon_type = :cargo
    @total = total.to_f
    @taken_total = 0
    @number = number
  end

  def take_total(user_total)
    validate_available_total
    self.taken_total += user_total.to_i
  end

  def show_total
    total
  end

  def show_available_total
    validate_available_total
    puts available_total
  end

  private

  def available_total
    total - taken_total
  end
end
