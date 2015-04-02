module Gedcomx
  class Field

    attr_reader :values

    def self.java_class
      Java::OrgGedcomxRecords::Field
    end

    def self.java_value_class
      Java::OrgGedcomxRecords::FieldValue
    end

    def initialize(input = nil)
      @field = input || self.class.java_class.new
      @values = []
      @values.concat @field.values.map { |value| Gedcomx::FieldValue.new(value) } if @field.values
    end

    def add_value(value_string, input_type = nil)
      value = Gedcomx::FieldValue.new
      value.text = value_string
      value.type = input_type if input_type
      @field.add_value value.to_java
      @values << value
    end

    def type
      @field.get_type
    end

    def type=(input_type)
      @field.type= ( input_type.is_a? Gedcomx.java_uri_class ) ? input_type : Gedcomx.new_uri(input_type)
    end

    def to_java
      @field
    end
  end
end
