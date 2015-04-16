module Gedcomx
  class NamePart

    attr_reader :fields

    def self.java_class
      Java::OrgGedcomxConclusion::NamePart
    end

    def self.create(attributes = {})
      new_part = self.new
      new_part.value = attributes[:value] if attributes[:value]
      new_part.type = attributes[:type] if attributes[:type]
      attributes[:fields].each { |field| new_part.add_field field } if attributes[:fields].is_a? Array
      new_part
    end

    def initialize(input = nil)
      @name_part = input || self.class.java_class.new
      @fields = []
      @fields = @name_part.fields.map { |field| Gedcomx::Field.new(field) } if @name_part.fields
    end

    def add_field(field)
      return false unless field.is_a? Gedcomx::Field
      @name_part.to_java.add_field field.to_java
      @fields << field
    end

    def type
      @name_part.get_type.to_s
    end

    def type=(input_type)
      @name_part.type = ( input_type.is_a? Gedcomx.java_uri_class ) ? input_type : Gedcomx.new_uri(input_type)
    end

    def value
      @name_part.get_value
    end

    def value=(input_value)
      @name_part.value = input_value
    end

    def to_java
      @name_part
    end
  end
end
