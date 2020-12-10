require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :trains, :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations.push(self)
    register_instance
    validate!
  end

  def add_train(train)
    self.trains.push(train)
  end

  def trains_count_by_type(type)
    puts "Кол-во поездов по типу #{type}: #{self.trains.count {|train| train.type == type}}"
  end

  def trains_list
    self.trains.each do |train|
      puts "Номер: #{train.number}, Тип: #{train.type}, Кол-во вагонов: #{train.wagons.count}"
    end
  end

  def train_leave(train)
    self.trains.delete(train)
  end

  def add_block_to_trains(&block)
    @trains.each { |train| yield(train) }
  end

  private

  def validate!
    raise "Не введено название станции" if name.empty?
  end
end
