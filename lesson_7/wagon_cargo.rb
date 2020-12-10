class CargoWagon < Wagon
  def initialize(volume)
    @type = "cargo"
    @volume = volume
    volume_initial
  end
  def wagon_load(volume)
    @volume -= volume
  end

  def taken_volume
    @volume_initial - @volume
  end

  def left_volume
    @volume
  end

  private

  def volume_initial
    @volume_initial = @volume
  end
end