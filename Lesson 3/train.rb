# frozen_string_literal: true

class Train
  attr_accessor :train_speed, :route
  attr_reader :train_number, :passenger_train, :freight_train, :number_of_wagons

  # train_type = boolean
  def initialize(train_number, passenger_train, freight_train, number_of_wagons)
    @train_number = train_number
    @passenger_train = passenger_train
    @freight_train = freight_train
    @number_of_wagons = number_of_wagons
    @train_speed = 0
  end

  def disperse_train(speed)
    self.train_speed = speed
    puts "Скорость поезда увеличена до #{speed}!"
  end

  def show_current_speed
    puts "Текущая скорость: #{train_speed}"
  end

  def stop_train
    self.train_speed = 0
    puts 'Поезд остановлен!'
  end

  def show_number_of_wagons
    puts "Количество вагонов поезда: #{number_of_wagons}"
  end

  def add_or_delete_wagons(wagon)
    if wagon.to_f > 1 || wagon.to_f < -1
      puts "Можно добавить или исключить только один вагон, текущее значение #{wagon}"
    else
      if train_speed.zero?
        current_wagons = number_of_wagons.to_f + wagon
        if current_wagons.negative?
          puts 'Количество вагонов не может быть отрицательным!'
        else
          @number_of_wagons = current_wagons
          puts "Текущее количество вагонов: #{@number_of_wagons}"
        end
      else
        puts 'Поезд движется! Для изменения количества вагонов остановите поезд'
      end
    end
  end

  def add_train_route(route)
    @route = route
    @route.start_station.train_arrives(self)
  end

  def one_station_train_move(step)
    if step.to_f > 1 || step.to_f < -1
      "Можно переместить или вернуть поезд только на одну станцию, текущее значение #{step}"
    else
      @route.stations_on_route
      take_station_index
      if (@station_index + step).negative? ||
         @station_index + step > @route_station.index(@route_station[-1])
        puts 'Поезд не может покинуть пределы маршрута'
      else
        @current_station.train_leaves(self)
        @last_station = @current_station
        @current_station = @route_station[@station_index + step]
        @current_station.train_arrives(self)
        take_station_index
        @next_station = @route_station[@station_index + 1]
      end
    end
  end

  def show_train_traffic_history
    puts "Поезд находиться на станции: #{@current_station.station_name},
          предыдущая: #{@last_station.station_name},
          следующая: #{@next_station.nil? ? 'Конец маршрута' : "#{@next_station.station_name}.to_s"}"
  end

  def take_station_index
    @route_station = @route.route_stations
    @station_index = @route_station.index(@current_station)
  end

  def current_train_station(station)
    @current_station = station
  end
end
