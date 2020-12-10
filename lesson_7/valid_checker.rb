module ValidChecker
  def valid?
    validate!
    true
  rescue
    false
  end
end