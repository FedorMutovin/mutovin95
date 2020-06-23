module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}"
      var_history = "@#{name}_history"
      history = []
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=") do |value|
        instance_variable_set(var_name, value)
        history << value
        history.delete_at(0) if history.length > 2
      end
      define_method("#{name}_history") do
        instance_variable_set(var_history, history)
      end
    end
  end

  def strong_attr_accessor(name, name_class)
    var_name = "@#{name}"
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=") do |value|
      raise 'Неверный тип' if  value.class != name_class

      instance_variable_set(var_name, value)
    end
  end
end
