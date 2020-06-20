require_relative 'passenger_train'
require_relative 'company'
require_relative 'validator'

class PassengerWagon < PassengerTrain
  attr_accessor :seats, :taken_seats
  attr_reader :number, :wagon_type
  extend Company
  include Validator
  def initialize(number, seats)
    @wagon_type = :passenger
    @seats = seats.to_f
    @taken_seats = 0
    @number = number
  end

  def take_seat
    validate_empty_seats
    self.taken_seats += 1
  end

  def show_all_seats
    seats
  end

  def show_empty_seats
    validate_empty_seats
    puts empty_seats
  end

  private

  def empty_seats
    seats - taken_seats
  end
end
