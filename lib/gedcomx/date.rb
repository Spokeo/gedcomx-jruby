module Gedcomx
  class Date

    def self.java_class
      Java::OrgGedcomxConclusion::Date
    end

    def initialize(input = nil)
      @date = input || self.java_class.new
    end

    def to_java
      @date
    end
  end
end
