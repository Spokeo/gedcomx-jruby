module Gedcomx
  class Fact

    attr_reader :date, :fields, :place

    def self.java_class
      Java::OrgGedcomxConclusion::Fact
    end

    def self.create(attributes = {})
      new_fact = self.new
      new_fact.date = attributes[:date] if attributes[:date]
      new_fact.type = attributes[:type] if attributes[:type]
      new_fact.value = attributes[:value] if attributes[:value]
      new_fact.primary = attributes[:primary] if attributes[:primary]
      attributes[:fields].each { |field| new_fact.add_field(field) } if attributes[:fields].is_a? Array
      new_fact
    end

    def initialize(input = nil)
      @fact = input || self.class.java_class.new
      @date = Gedcomx::Date.new(@fact.get_date) if @fact.get_date
      @place = Gedcomx::Place.new(@fact.get_place) if @fact.get_place
      @fields = []
      @fields = @fact.fields.map { |field| Gedcomx::Field.new(field) } if @fact.fields.is_a? Array
    end

    def add_field(field)
      return false unless field.is_a? Gedcomx::Field
      @fact.add_field field.to_java
      @fact.fields << field
    end

    def date=(date)
      return false unless date.is_a? Gedcomx::Date
      @fact.date = date.to_java
      @date = date
    end

    def primary?
      @fact.get_primary
    end

    def primary=(is_primary)
      return false unless is_primary.is_a? Boolean
      @fact.primary = is_primary
    end

    def type
      @fact.get_type.to_s
    end

    def type= (input_type)
      @fact.type = ( input_type.is_a? Gedcomx.java_uri_class ) ? input_type : Gedcomx.new_uri(input_type)
    end

    def value
      @fact.get_value
    end

    def value= (value_string)
      @fact.value = value_string
    end

    def to_java
      @fact
    end
  end
end
