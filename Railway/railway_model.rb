require_relative 'railway_controller'

class RailwayModel
  private

  def delete_station
    puts 'Выберите номер станции, которую хотите удалить'
    show_user_stations_table
    delete_station = user_station(answer)
    user_stations.delete(delete_station)
    puts 'Станция удалена'
  end

  def add_user_station
    station = Station.new(answer)
    user_stations << station
  end

  def add_user_train
    user_train = Train.new(answer)
    user_train.add_type
    user_trains << user_train
  end

  def user_station(station)
    user_stations[station.to_i - 1]
  end

  def continue_create?
    answer != 'n'
  end

  def take_wagon(type)
    show_trains_by_type(type)
    train_index = answer
    take_seat_validate(train_index)
    seat_question
    choose_wagon_for_take(train_index)
  end

  def user_routes?
    return unless user_routes.empty?

    raise 'Нужно создать как минимум один маршрут'
  rescue RuntimeError
    add_route
  end

  def choose_user_train
    validate_train
    puts 'Выберите поезд'
    show_user_trains_table
    @user_train = user_trains[answer.to_i - 1]
  rescue RuntimeError
    add_train
  end

  def choose_user_route
    user_routes?
    puts 'Выберите маршрут'
    show_user_route_table
    @user_route = user_routes[answer.to_i - 1]
  end

  def choose_wagon_for_take(train_index)
    user_trains[index(train_index)].all_wagons do |wagon|
      show_wagons_table(train_index, wagon)
      @user_wagon = user_trains[index(train_index)].wagons[answer.to_i - 1]
    end
  end

  def train_have_route
    @user_train.add_train_route if @user_train.route.nil?
  end

  def move_train_to_next_station
    choose_user_train
    train_have_route
    @user_train.move_to_next_station
  end

  def move_train_to_last_station
    choose_user_train
    train_have_route
    @user_train.move_to_last_station
  end

  def change_station(user_route)
    yield(user_route)
    puts 'Cтанция изменена'
    user_route.show_stations_on_route
  end

  def delete_intermediate_station(user_route)
    puts 'Выберите номер промежуточной станции, которую хотите удалить'
    mid_stations_table(user_route)
    delete_mid_station = user_route.mid_stations[answer.to_i - 1]
    user_route.delete_mid_station(delete_mid_station)
    user_route.show_stations_on_route
  end

  def add_intermediate_station(user_route)
    puts 'Выберите номер станции, которую хотите добавить как промежуточную'
    show_user_stations_table
    mid_station = user_station(answer)
    user_route.add_mid_station(mid_station)
    puts 'Промежуточная станция изменена'
    user_route.show_stations_on_route
  end

  def change_first_station(user_route)
    show_change_station_tips
    change_station(user_route) { |x| x.start_station = user_station(answer) }
  end

  def change_second_station(user_route)
    show_change_station_tips
    change_station(user_route) { |x| x.end_station = user_station(answer) }
  end

  def user_answer
    self.answer = gets.chomp
  end

  def index(number)
    number.to_i - 1
  end

  def change_root(user_route)
    loop do
      show_change_root_menu
      break if CHANGE_ROOT_OPERATIONS[answer].nil?

      send CHANGE_ROOT_OPERATIONS[answer], user_route
    end
    user_routes << user_route
  rescue ArgumentError
    send CHANGE_ROOT_OPERATIONS[answer]
    retry
  end
end
