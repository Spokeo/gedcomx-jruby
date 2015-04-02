module Gedcomx
  class FieldValue

    def self.java_class
      Java::OrgGedcomxRecords::FieldValue
    end

    def initialize(input = nil)
      @value = input || self.class.java_class.new
    end

    def text
      @value.get_text
    end

    def text=(input_string)
      @value.text= input_string
    end

    def type
      @value.get_type.to_s
    end

    def type= (input_type)
      @value.type= ( input_type.is_a? Gedcomx.java_uri_class ) ? input_type : Gedcomx.new_uri(input_type)
    end

    def to_java
      @value
    end
  end
end
