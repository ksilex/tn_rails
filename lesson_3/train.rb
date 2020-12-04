class Train
  attr_reader :number, :type, :wagons, :current_station, :route
  attr_accessor :speed

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    @wagons += 1 if self.speed == 0
  end

  def delete_wagon
    @wagons -= 1 if self.speed == 0 && self.wagons != 0
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

  def current_station_id
    id = self.route.stations.index(@current_station)
  end
end
