require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(origin, destination)
    @stations = [origin, destination]
    register_instance
  end

  def add_station(station)
    self.stations.insert(-2, station)
  end

  def delete_station(station)
    unless [self.stations.first, self.stations.last].include?(station)
      self.stations.delete(station)
    end
  end

  def list_stations
    puts "Станции маршрута: " 
    self.stations.each { |station| puts "#{station.name}"}
  end
end