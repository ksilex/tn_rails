class Station 
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    self.trains.push(train)
  end

  def trains_count
    self.trains.group_by { |train| train.type }.
    transform_values { |values| values.count }.
    each { |k, v| puts "Тип поезда: #{k}, кол-во: #{v}" }
  end

  def trains_list
    self.trains.each do |train|
      puts "Номер: #{train.number}, Тип: #{train.type}, Кол-во вагонов: #{train.wagons}"
    end
  end

  def train_leave(train)
    self.trains.delete(train)
  end
end

class Route
  attr_reader :stations

  def initialize(origin, destination)
    @stations = [origin, destination]
  end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def delete_station(station)
    unless [self.stations.first, self.stations.last].include?(station)
      self.stations.delete(station)
    end
  end
end

class Train
attr_reader :number, :type, :wagons, :current_station, :route
attr_accessor :speed

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @current_station = nil
    @route = []
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    @wagons += 1 if self.speed == 0
  end
#self.wagons не сработает, т.к. не описан как сеттер. Если описывать его как сеттер, то можно добавлять сколько угодно вагонов
  
  def delete_wagon
    @wagons -= 1 if self.speed == 0
  end

  def assign_route(route)
    @route = route
    @current_station = route.stations.first
  end

  def move_forward
    id = self.route.stations.index(@current_station)
    if id == self.route.stations.size-1
      puts "Маршрут завершен, последняя станция: #{@current_station}"
    else
      @current_station = self.route.stations[id += 1] 
      puts "Теперь поезд на станции #{@current_station}"
    end
  end

  def move_back
    id = self.route.stations.index(@current_station)
    if id == 0
      puts "Маршрут начат"
    else
      @current_station = self.route.stations[id -= 1]
      puts "Теперь поезд на станции #{@current_station}"
    end
  end

  def next_station
    id = self.route.stations.index(@current_station)
    puts "Следующая станция: #{self.route.stations[id += 1]}"
  end

  def prev_station
    id = self.route.stations.index(@current_station)
    puts "Предыдущая станция: #{self.route.stations[id -= 1]}"
  end
end
