module Gedcomx
  class Gender

    attr_reader :fields

    def self.java_class
      Java::OrgGedcomxConclusion::Gender
    end

    def self.create(attributes = {})
      new_gender = self.new
      new_gender.type = attributes[:type] if attributes[:type]
      attributes[:fields].each { |field| new_gender.add_field(field) } if attributes[:fields].is_a? Array
      new_gender
    end

    def self.create_male
      new_gender = self.new
      new_gender.type = Gedcomx::TYPES[:male]
      field = Gedcomx::Field.create( values: [ { text: 'Male', type: Gedcomx::TYPES[:original] } ],
                                     type: Gedcomx::TYPES[:gender] )
      new_gender.add_field(field)
      new_gender
    end

    def self.create_female
      new_gender = self.new
      new_gender.type = Gedcomx::TYPES[:female]
      field = Gedcomx::Field.create( values: [ { text: 'Female', type: Gedcomx::TYPES[:original] } ],
                                     type: Gedcomx::TYPES[:gender] )
      new_gender.add_field(field)
      new_gender
    end

    def initialize(input = nil)
      @gender = input || self.class.java_class.new
      @fields = []
      @fields = @gender.fields.map { |field| Gedcomx::Field.new(field) } if @gender.fields.is_a? Array
    end

    def add_field(field)
      return false unless field.is_a? Gedcomx::Field
      @gender.add_field field.to_java
      @fields << field
    end

    def type
      @gender.get_type.to_s
    end

    def type= (input_type)
      @gender.type = ( input_type.is_a? Gedcomx.java_uri_class ) ? input_type : Gedcomx.new_uri(input_type)
    end

    def to_java
      @gender
    end
  end
end
