class PassengerWagon < Wagon
  def initialize(seats)
    @type = "passenger"
    @seats = seats
    seats_initial
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
