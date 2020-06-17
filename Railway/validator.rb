# frozen_string_literal: true

module Validator
  TRAIN_NUMBER_EXAMPLE = /^[а-яА-ЯёЁa-zA-Z0-9]{3}-*[а-яА-ЯёЁa-zA-Z0-9]{2}$/.freeze


  def validate_number!
    raise 'Неверный формат номера поезда' if number !~ TRAIN_NUMBER_EXAMPLE
  end

  def valid?
    validate_number!
    true
  rescue RuntimeError => e
    e.message
    false
  end

  def validate_empty_seats
    raise 'Нет свободных мест' if empty_seats.negative? || empty_seats.zero? ||
                                  taken_seats == seats
  end

  def validate_available_total
    raise 'Нет свободного обьема' if available_total.negative? || available_total.zero? ||
                                     taken_total == total
  end

  def validate_user_passenger_trains
    validate_train_type(:passenger)
  end

  def validate_user_cargo_trains
    validate_train_type(:cargo)
  end

  private

  def validate_train_type(train_type)
    trains = []
    user_trains.each { |user_train| trains << user_train.type if user_train.type == train_type }
    raise 'У вас нет созданных поездов подходящего типа' if user_trains.empty? || trains.empty?
  end
end
