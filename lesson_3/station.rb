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
    @count = 0
    self.trains.each do |train|
      if train.type == type
        @count += 1
      end
    end
    puts "Кол-во поездов по типу #{type}: #{@count}"
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
