module Gedcomx
  class Name

    attr_reader :date, :forms

    def self.java_class
      Java::OrgGedcomxConclusion::Name
    end

    def self.build_simple(attributes = {})
      first = attributes[:first]
      last = attributes[:last]
      name_form = Gedcomx::NameForm.new
      name_form.full_text = attributes[:full] if attributes[:full]

      if first
        field = Gedcomx::Field.create( first_attributes = {
          values: [ { text: first, type: Gedcomx::TYPES[:original] } ],
          type: Gedcomx::TYPES[:given]
        } )

        name_part = Gedcomx::NamePart.create( first_attributes = {
          fields: [ field ],
          value: first,
          type: Gedcomx::TYPES[:given]
        })

        name_form.add_part(name_part)
      end

      if last
        field = Gedcomx::Field.create( last_attributes = {
          values: [ { text: last, type: Gedcomx::TYPES[:original] } ],
          type: Gedcomx::TYPES[:surname]
        } )

        name_part = Gedcomx::NamePart.create( last_attributes = {
          fields: [ field ],
          value: last,
          type: Gedcomx::TYPES[:surname]
        })

        name_form.add_part(name_part)
      end

      attributes[:forms] = [name_form]
      self.create(attributes)
    end

    def self.create(attributes = {})
      new_name = self.new
      new_name.confidence = attributes[:confidence] if attributes[:confidence]
      new_name.preferred = attributes[:preferred] if attributes[:preferred]
      new_name.language = attributes[:language] if attributes[:language]
      new_name.type = attributes[:type] if attributes[:type]

      if attributes[:type]
        puts attributes[:type]
      end

      attributes[:forms].each { |form| new_name.add_form(form) } if attributes[:forms].is_a? Array
      new_name
    end

    def initialize(input = nil)
      @name = input || self.class.java_class.new
      @date = Gedcomx::Date.new(@name.get_date) if @name.get_date
      @forms = []
      @forms = @name.get_name_forms.map { |form| Gedcomx::NameForm.new(form) } if @name.get_name_forms
    end

    def add_form(form)
      return false unless form.is_a? Gedcomx::NameForm
      @name.add_name_form form.to_java
      @forms << form
    end

    def date=(date)
      return false unless date.is_a? Gedcomx::Date
      @name.date = date.to_java
      @date = date
    end

    def confidence
      @name.get_confidence
    end

    def confidence=(input_confidence)
      if input_confidence.is_a? Gedcomx.java_uri_class
       @name.confidence = input_confidence
      else
        @name.confidence = Gedcomx.new_uri(input_confidence)
      end
    end

    def preferred?
      @name.get_preferred
    end

    def preferred=(input_boolean)
      return false unless input_boolean.is_a? Boolean
      @name.preferred = input_boolean
    end

    def language
      @name.get_lang
    end

    def language=(input_language)
      return false unless input_language.is_a? String
      @name.lang = input_language
    end

    def type
      @name.get_type.to_s
    end

    def type=(input_type)
      @name.type = ( input_type.is_a? Gedcomx.java_uri_class ) ? input_type : Gedcomx.new_uri(input_type)
    end

    def to_java
      @name
    end

    # Generates accessor methods for each of the types
    TYPES.keys.each do |type|
      define_method type do
        first_value(type)
      end
    end
  end
end
