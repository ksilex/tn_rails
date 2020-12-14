module ValidChecker
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, type, optional)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise 'Неверный тип' if value.class != type
        
        instance_variable_set(var_name, value)
      end
    end
  end
  
  module InstanceMethods
  
  end
  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
