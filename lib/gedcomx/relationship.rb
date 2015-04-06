module Gedcomx
  class Relationship

    attr_reader :person1, :person2

    def self.java_class
      Java::OrgGedcomxConclusion::Relationship
    end

    def self.create(attributes = {})
      new_relationship = self.new
      new_relationship.type = attributes[:type] if attributes[:type]
      new_relationship.person1 = attributes[:person1] if attributes[:person1]
      new_relationship.person2 = attributes[:person2] if attributes[:person2]
      new_relationship
    end

    def initialize(input = nil)
      @relationship = input || self.class.java_class.new
      @person1 = Gedcomx::ResourceReference.new(@relationship.get_person1) if @relationship.get_person1
      @person2 = Gedcomx::ResourceReference.new(@relationship.get_person2) if @relationship.get_person2
    end

    def couple?
      type == TYPES[:couple]
    end

    def parent_child?
      type == TYPES[:parent_child]
    end

    def person1=(person_reference)
      return false unless person_reference.is_a? Gedcomx::ResourceReference
      @relationship.person1 = person_reference.to_java
      @person1 = person_reference
    end

    def person2=(person_reference)
      return false unless person_reference.is_a? Gedcomx::ResourceReference
      @relationship.person2 = person_reference.to_java
      @person2 = person_reference
    end

    def type
      @relationship.get_type.to_s
    end

    def type=(input_type)
      @relationship.type = ( input_type.is_a? Gedcomx.java_uri_class ) ? input_type : Gedcomx.new_uri(input_type)
    end

    def to_java
      @relationship
    end
  end
end
