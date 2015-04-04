module Gedcomx
  class Identifier

    def self.java_class
      Java::OrgGedcomxConclusion::Identifier
    end

    def self.create(attributes = {})
      new_identifier = self.new
      new_identifier.type = attributes[:type] if attributes[:type]
      new_identifier.value = attributes[:value] if attributes[:value]
      new_identifier
    end

    def initialize(input = nil)
      @identifier = input || self.class.java_class.new
    end

    def type
      @identifier.get_type.to_s
    end

    def type=(input_type)
      @identifier.type = ( input_type.is_a? Gedcomx.java_uri_class ) ? input_type : Gedcomx.new_uri(input_type)
    end

    def value
      @identifier.get_value.to_s
    end

    def value=(input_value)
      @identifier.value = ( input_value.is_a? Gedcomx.java_uri_class ) ? input_value : Gedcomx.new_uri(input_value)
    end

    def to_java
      @identifier
    end
  end
end
