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
end
