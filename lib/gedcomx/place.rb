module Gedcomx
  class Place

    attr_reader :fields

    def self.java_class
      Java::OrgGedcomxConclusion::PlaceReference
    end

    def self.create(attributes = {})
      new_place = self.new
      new_place.original = attributes[:original] if attributes[:original]
      attributes[:fields].each { |field| new_place.add_field(field) } if attributes[:fields].is_a? Array
      new_place
    end

    def initialize(input = nil)
      @place = input || self.class.java_class.new
      @fields = []
      @fields = @place.fields.map { |field| Gedcomx::Field.new(field) } if @place.fields.is_a? Array
    end

    def add_field(field)
      return false unless field.is_a? Gedcomx::Field
      @place.add_field field.to_java
      @place.fields << field
    end

    def original
      @place.get_original
    end

    def original=(input_string)
      return false unless input_string.is_a? String
      @place.original = input_string
    end

    def to_java
      @place
    end
  end
end
