module Gedcomx
  class NameForm

    attr_reader :parts

    def self.java_class
      Java::OrgGedcomxConclusion::NameForm
    end

    def self.create(attributes = {})
      new_form = self.new
      new_form.full_text = attributes[:full_text] if attributes[:full_text]
      attributes[:fields].each { |field| new_form.add_field field } if attributes[:fields].is_a? Array
      attributes[:parts].each { |part| new_form.add_part part } if attributes[:parts].is_a? Array
    end

    def initialize(input = nil)
      @name_form = input || self.class.java_class.new
      @parts = []
      @parts = @name_form.parts.map { |part| Gedcomx::NamePart.new(part) } if @name_form.parts
    end

    def add_part(part)
      return false unless part.is_a? Gedcomx::NamePart
      @name_form.add_part part.to_java
      @parts << part
    end

    def full_text
      @name_form.get_full_text
    end

    def full_text=(full_text)
      @name_form.full_text = full_text
    end

    def to_java
      @name_form
    end
  end
end
