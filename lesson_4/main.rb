require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_pass'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'wagon_cargo'
require_relative 'wagon_pass'

@trains = []
@stations = []
@routes = []

def main 
  puts "Выберите действие
        1. Действия с поездами
        2. Действия со станциями
        3. Действия с маршрутами"

  choice = gets.chomp.to_i

  case choice
  when 1
    train_menu
  when 2
    station_menu
  when 3
    route_menu
  end
end


def train_menu
  puts "Выберите действие
        1. Создать поезд
        2. Действия с поездом
        3. Главное меню"

  choice = gets.chomp.to_i

  case choice
  when 1
    create_train
  when 2
    train_select
  when 3
    main
  end
end

def create_train
  puts "Введите тип поезда(passenger или cargo)"
  type = gets.chomp
  puts "Введите номер поезда"
  number = gets.chomp.to_i
  case type
  when "passenger"
    @trains.push(PassengerTrain.new(number))
  when "cargo"
    @trains.push(CargoTrain.new(number))
  end
  puts "Поезд №#{number} создан"
  train_menu
end

def train_select
  @trains.each_with_index { |train, id| puts "Выбор: #{id+1}. #{train.number}, #{train.type}" }
  puts "Выберите поезд для дальнейших действий"
  train_choice = gets.chomp.to_i - 1
  @selected_train = @trains[train_choice]
  puts "Выберите действие
        1. Назначить маршрут поезду
        2. Добавить вагон
        3. Отцепить вагон
        4. Отправить поезд на следующую станцию
        5. Отправить поезд на предыдущую станцию
        6. Остановить поезд
        7. Изменить скорость поезда
        8. Информация о поезде
        9. Назад"

  choice = gets.chomp.to_i

  case choice
  when 1
    train_assign_route
  when 2
    train_add_wagon
  when 3
    @selected_train.delete_wagon
    train_menu
  when 4
    @selected_train.move_forward
    train_menu
  when 5
    @selected_train.move_back
    train_menu
  when 6
    @selected_train.stop
    train_menu
  when 7
    train_speed_change
  when 8
    train_info
  when 9
    train_menu
  end
end

def train_assign_route
  routes_list
  @selected_train.assign_route(@selected_route)
  train_menu
end

def train_add_wagon
  if @selected_train.type == "passenger"
    @selected_train.add_wagon(PassengerWagon.new)
  else
    @selected_train.add_wagon(CargoWagon.new)
  end
  train_menu
end

def train_speed_change
  puts "Скорость поезда #{@selected_train.speed}. Введите новую величину"
  speed = gets.chomp.to_i
  @selected_train.speed = speed
  puts "Скорость поезда: #{@selected_train.speed}"
  train_menu
end

def train_info
  puts "Номер поезда: #{@selected_train.number}"
  puts "Тип: #{@selected_train.type}"
  puts "Кол-во вагонов: #{@selected_train.wagons.count}"
  unless @selected_train.route.nil?
    puts "Находится на станции: #{@selected_train.current_station.name}"
    puts "Следующая станция: #{@selected_train.next_station.name}"
    unless @selected_train.prev_station.nil?
      puts "Предыдущая станция: #{@selected_train.prev_station.name}"
    else 
      puts "Поезд уже в начале маршрута"
    end
    puts "Полный маршрут: #{@selected_train.route}"
  else
    puts "Поезд не имеет маршрута"
  end
  train_menu
end

def station_menu
  puts "Выберите действие
        1. Создать станцию
        2. Список всех станций и просмотр поездов на станции
        3. Главное меню"
  choice = gets.chomp.to_i

  case choice
  when 1
    create_station
  when 2
    stations_list
  when 3
    main
  end
end

def create_station
  puts "Введите название станции"
  name = gets.chomp
  @stations.push(Station.new(name))
  puts "Станция #{name} создана"
  station_menu
end

def stations_list
  stations_all
  puts "1. Для просмотра поездов на станции выберите одну из списка.
        2. Чтобы вернуться назад введите 0"
  
  choice = gets.chomp.to_i - 1
  station_menu if choice == -1
  @selected_station = @stations[choice]
  @selected_station.trains_list
  puts "1. Для просмотра кол-ва поездов по типу на станции введите тип.
        2. Чтобы вернуться в меню станций введите 0"
  type = gets.chomp
  station_menu if type == 0
  @selected_station.trains_count_by_type(type)
  station_menu
end

def route_menu
  puts "Выберите действие
        1. Создать маршрут
        2. Действия с маршрутом
        3. Главное меню"

  choice = gets.chomp.to_i

  case choice
  when 1
    create_route
  when 2
    route_select
  when 3
    main
  end
end

def route_select
  routes_list
  puts "Выберите действие
        1. Удалить станцию с маршрута
        2. Добавить станцию к маршруту
        3. Просмотр станций маршрута
        4. Назад"

  choice = gets.chomp.to_i

  case choice
  when 1
    route_delete_station
  when 2
    route_add_station
  when 3
    route_stations_list
  when 4
    route_menu
  end
end

def route_add_station
  stations_all
  puts "Выберите какую станцию добавить к маршруту"
  station_choice = gets.chomp.to_i - 1
  @selected_route.add_station(@stations[station_choice])
  route_menu
end

def route_delete_station
  @selected_route.stations.each_with_index do |station, id| 
    puts "Выбор: #{id+1}. #{station.name}"
  end
  puts "Выберите какую станцию удалить с маршрута"
  station_choice = gets.chomp.to_i - 1
  @selected_route.delete_station(@selected_route.stations[station_choice])
  route_menu
end

def route_stations_list
  @selected_route.list_stations
  route_menu
end

def create_route 
  if @stations.count < 2
    puts "Создайте начальную и конечную станции. Нажмите enter для перехода."
    back = gets.chomp
    create_station
  else 
    stations_all
    puts "Выберите начальную станцию"
    origin_choice = gets.chomp.to_i - 1
    puts "Выберите конечную станцию"
    destination_choice = gets.chomp.to_i - 1
    @routes.push(Route.new(@stations[origin_choice], @stations[destination_choice]))
    route_menu
  end
end

private

def stations_all
  @stations.each_with_index { |station, id| puts "Выбор: #{id+1}. #{station.name}" }
end

def routes_list
  @routes.each_with_index do |route, id| 
    print "Выбор: #{id + 1}. "
    route.stations.each { |station| print "#{station.name} "}
    print "\n"
  end
  puts "Выберите маршрут для дальнейших действий"
  route_choice = gets.chomp.to_i - 1
  @selected_route = @routes[route_choice]
end

main