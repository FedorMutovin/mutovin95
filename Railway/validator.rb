module Validator
  TRAIN_NUMBER_TIP = /^[а-яА-ЯёЁa-zA-Z0-9]{3}-*[а-яА-ЯёЁa-zA-Z0-9]{2}$/.freeze

  def validate_number!
    raise 'Неверный формат номера поезда' if number !~ TRAIN_NUMBER_TIP
  end

  def validate_empty_seats
    raise 'Нет свободных мест' if empty_seats.negative? || empty_seats.zero? ||
                                  taken_seats == seats
  end

  def validate_available_total
    raise 'Нет свободного обьема' if available_total.negative? ||
                                     available_total.zero? ||
                                     taken_total == total
  end

  def validate_train
    return unless user_trains.empty?

    raise 'Нужно создать как минимум один поезд'
  end

  def validate_user_passenger_trains
    validate_train_type(:passenger)
  end

  def validate_user_cargo_trains
    validate_train_type(:cargo)
  end

  def validate_route_stations
    return unless user_stations.empty? || user_stations.length < 2

    raise 'Нужно создать минимум 2 станции'
  end

  def validate_wagons
    raise 'У поезда отсутствуют вагоны' if @user_train.wagons.empty?
  end

  def validate_stations
    raise 'Нет доступных станций' if user_stations.empty?
  end

  def take_seat_validate(train_index)
    raise 'Нет вагонов ' if user_trains[index(train_index)].wagons.empty?
  end

  private

  def validate_train_type(train_type)
    user_trains.each_with_object([]) do |user_train, arr|
      arr << user_train.type if user_train.type == train_type
      @trains_types = arr
    end
    return unless user_trains.empty? || @trains_types.empty?

    raise 'У вас нет созданных поездов подходящего типа'
  end
end
