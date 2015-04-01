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

    def initialize(input = nil)
      @name = input || self.class.java_class.new
    end
  end
end
