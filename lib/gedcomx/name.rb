module Gedcomx
  class Name

    def self.java_class
      Java::OrgGedcomxConclusion::Name
    end

    def self.java_name_form_class
      Java::OrgGedcomxConclusion::NameForm
    end

    def self.java_name_part_class
      Java::OrgGedcomxConclusion::NamePart
    end

    def self.create(attributes = {})
      first = attributes[:first]
      middle = attributes[:middle]
      last = attributes[:last]
      full = attributes[:full]
      type = attributes[:type]
    end

    def initialize(input = nil)
      @name = input || self.class.java_class.new
    end

    def add_part

    end


    def add_full_name(full_name)

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
