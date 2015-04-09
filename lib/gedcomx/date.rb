module Gedcomx
  class Date

    attr_reader :fields

    def self.java_class
      Java::OrgGedcomxConclusion::Date
    end

    def self.create(attributes = {})
      new_date = self.new
      new_date.original = attributes[:original] if attributes[:original]
      attributes[:fields].each { |field| new_date.add_field(field) } if attributes[:fields].is_a? Array
      new_date
    end

    def self.create_simple(attributes = {})
      day = attributes[:day]
      month = attributes[:month]
      year = attributes[:year]

      return nil unless ( day || month || year )
      new_fields = []
      full_string = ''

      if day
        full_string += day
        new_fields << Gedcomx::Field.create(values: [ { text: day, type: Gedcomx::TYPES[:day] } ])
      end

      if month
        full_string += ' ' unless full_string.empty?
        full_string += month
        new_fields << Gedcomx::Field.create(values: [ { text: month, type: Gedcomx::TYPES[:month] } ])
      end

      if year
        full_string += ' ' unless full_string.empty?
        full_string += year
        new_fields << Gedcomx::Field.create(values: [ { text: year, type: Gedcomx::TYPES[:year] } ])
      end

      new_fields << Gedcomx::Field.create(values: [ { text: full_string, type: Gedcomx::TYPES[:original] } ])
      self.create(fields: new_fields)
    end

    def initialize(input = nil)
      @date = input || self.class.java_class.new
      @fields = []
      @fields = @date.fields.map { |field| Gedcomx::Field.new(field) } if @date.fields
    end

    def day
      day_field = @fields.select { |field| field.type == Gedcomx::TYPES[:day] }.first
      day_field.values.first.text if day_field
    end

    def month
      month_field = @fields.select { |field| field.type == Gedcomx::TYPES[:month] }.first
      month_field.values.first.text if month_field
    end

    def year
      year_field = @fields.select { |field| field.type == Gedcomx::TYPES[:year] }.first
      year_field.values.first.text if year_field
    end

    def add_field(field)
      return false unless field.is_a? Gedcomx::Field
      @date.add_field field.to_java
      @fields << field
    end

    def original
      @date.original
    end

    def original=(input_string)
      return false unless input_string.is_a? String
      @date.original = input_string
    end

    def to_java
      @date
    end
  end
end
