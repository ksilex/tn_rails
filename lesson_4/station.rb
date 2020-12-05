class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
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
end
