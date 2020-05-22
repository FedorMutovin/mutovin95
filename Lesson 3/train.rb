# frozen_string_literal: true

class Train
  attr_accessor :speed, :route
  attr_reader :number, :type, :number_of_wagons

  def initialize(number, type, number_of_wagons)
    @number = number
    @type = type
    @number_of_wagons = number_of_wagons
    @speed = 0
  end

  def disperse(speed)
    self.speed += speed
    puts "Скорость поезда увеличена до #{speed}!"
  end

  def current_speed
    puts "Текущая скорость: #{speed}"
  end

  def stop
    self.speed = 0
    puts 'Поезд остановлен!'
  end

  def show_number_of_wagons
    puts "Количество вагонов поезда: #{number_of_wagons}"
  end

  def add_wagon
    if speed.zero?
      @number_of_wagons += 1
      puts "Текущее количество вагонов: #{number_of_wagons}"
    else
      puts 'Поезд движется! Для изменения количества вагонов остановите поезд'
    end
  end

  def delete_wagon
    if speed.zero?
      current_wagons = number_of_wagons - 1
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

  def add_route(route)
    @route = route
    @route.start_station.add_train(self)
  end

  def move_to_next_station
    take_station_index
    if @station_index + 1 > @stations.index(@stations[-1])
      puts 'Поезд не может покинуть пределы маршрута'
    else
      @current_station.move_train(self)
      next_station
      @current_station = @next_station
      @current_station.add_train(self)
    end
  end

  def move_to_last_station
    take_station_index
    if (@station_index - 1).negative?
      puts 'Поезд не может покинуть пределы маршрута'
    else
      @current_station.move_train(self)
      last_station
      @current_station = @last_station
      @current_station.add_train(self)
    end
  end

  def last_station
    take_station_index
    @last_station = @stations[@station_index - 1]
  end

  def next_station
    take_station_index
    @next_station = @stations[@station_index + 1]
  end

  def take_station_index
    @stations = @route.stations
    @station_index = @stations.index(@current_station)
  end

  def current_train_station(station)
    @current_station = station
  end
end
