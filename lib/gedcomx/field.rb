module Gedcomx
  class Field

    def self.java_class
      Java::OrgGedcomxRecords::Field
    end

    def initialize(input = nil)
      @field = input || self.class.java_class.new
    end



  end
end
