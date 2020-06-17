# frozen_string_literal: true

require_relative 'passenger_train'
require_relative 'company'

class PassengerWagon < PassengerTrain
  attr_accessor :seats, :taken_seats
  attr_reader :number, :wagon_type
  extend Company
  def initialize(number, seats)
    @wagon_type = :passenger
    @seats = seats
    @taken_seats = 0
    @number = number
  end

  def take_seat
    self.taken_seats = taken_seats + 1
  end

  def show_all_seats
    seats
  end

  def show_empty_seats
    raise 'Нет свободных мест' if empty_seats.negative? || empty_seats.zero?

    empty_seats
  end

  private

  def empty_seats
    seats - taken_seats
  end
end
