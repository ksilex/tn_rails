require_relative 'company_name'
require_relative 'instance_counter'

class Train
  include CompanyName
  include InstanceCounter

  attr_reader :number, :type, :wagons, :current_station, :route
  attr_accessor :speed

  @@trains = []

  def self.find(number)
    @@trains.select { |train| train.number == number }
  end

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    @@trains.push(self)
    register_instance
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    if self.speed == 0
      if self.type == "passenger"
        self.wagons.push(PassengerWagon.new)
      else
        self.wagons.push(CargoWagon.new)
      end
    else
      puts "Остановите поезд"
    end
    puts "Кол-во вагонов: #{@wagons.count}"
  end

  def delete_wagon
    if self.speed == 0
      @wagons.pop
    else
      puts "Остановите поезд"
    end
    puts "Кол-во вагонов: #{@wagons.count}"
  end

  def assign_route(route)
    @route = route
    @current_station = route.stations.first
    @current_station.add_train(self)
  end

  def move_forward
    if self.next_station
      @current_station.train_leave(self)
      @current_station = self.next_station
      @current_station.add_train(self)
      puts "Теперь поезд на станции #{@current_station.name}"
    else
      puts "Маршрут завершен, последняя станция: #{@current_station.name}"
    end
  end

  def move_back
    if self.prev_station
      @current_station.train_leave(self)
      @current_station = self.prev_station
      @current_station.add_train(self)
      puts "Теперь поезд на станции #{@current_station.name}"
    else
      puts "Вы на начале маршрута, станция: #{@current_station.name}"
    end
  end

  def next_station
    self.route.stations[current_station_id + 1]
  end

  def prev_station
    self.route.stations[current_station_id - 1] if current_station_id != 0
  end

  protected

  def current_station_id
    id = self.route.stations.index(@current_station)
  end
end
