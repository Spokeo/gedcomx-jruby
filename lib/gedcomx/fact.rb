module Gedcomx
  class Fact

    def self.java_class
      Java::OrgGedcomxConclusion::Fact
    end

    def initialize(input = nil)
      @fact = input || self.class.java_class
    end

    def type
      @fact.get_type.to_s
    end

    def type= (type_key)
      type_string = Gedcomx::TYPES[type_key]
      @fact.type= Gedcomx.java_uri_class.new(type_string) if type_string
    end

    def value
      @fact.get_value
    end

    def value= (value_string)
      @fact.value= value_string
    end
  end
end
