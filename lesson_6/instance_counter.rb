module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods #тут насколько я понял аттры инициализируются до переменной класса
                      #и из-за этого при обращении к методу нил возвращается
                      #поэтому так обошел, не знаю на сколько это правильно
    @@count = 0

    def count
      @@count
    end

    def instances
      @@count
    end

    def count=(val)
      @@count = val
    end
  end

  module InstanceMethods

    private

    def register_instance
      self.class.count += 1
    end

    public

    def valid?
      validate!
      true
    rescue
      false
    end
  end
end