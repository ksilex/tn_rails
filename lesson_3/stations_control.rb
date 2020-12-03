class Station 
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
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
attr_reader :number, :type
attr_accessor :speed, :wagons

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
    self.wagons += 1 if self.speed == 0
  end

  def delete_wagon
    self.wagons -= 1 if self.speed == 0
  end
end