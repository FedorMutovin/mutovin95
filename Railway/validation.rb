module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate(attr, type, *params)
      @validations ||= []
      @validations << { attr: attr, type: type, params: params }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:attr]}".to_sym)

        send("validate_#{validation[:type]}", value, *validation[:params])
      end
    end

    def validate_presence(value)
      raise "#{value} не может быть пустым" if value.empty?
    end

    def validate_type(value, params)
      raise "Недопустимый тип #{value}" unless value.class != params
    end

    def validate_format(value, params)
      raise "#{value} не соответствует соответствует формату #{params}" unless value =~ params
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
