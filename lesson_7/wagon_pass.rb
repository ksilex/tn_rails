require_relative 'id_for_wagon'

class PassengerWagon < Wagon
  include IDIncrementor
  
  def initialize(seats)
    @type = "passenger"
    @seats = seats
    seats_initial
    id_incrementor
  end
  def take_seat
    @seats -= 1
  end

  def taken_seats
    @seats_initial - @seats
  end

  def free_seats
    @seats
  end

  private

  def seats_initial
    @seats_initial = @seats
  end
end
