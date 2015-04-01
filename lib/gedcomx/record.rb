module Gedcomx
  class Record

    attr_accessor :people, :relationships

    def self.java_class
      Java::OrgGedcomx::Gedcomx
    end

    def initialize(input = nil)
      @record = input || self.class.java_class.new
      @people = @record.persons
      unless @people.nil?
        @people = @people.map{|person| Person.new(person) }
      end
      @relationships = @record.relationships
      unless @relationships.nil?
        @relationships = @relationships.map{|relationship| Relationship.new(relationship) }
      end
    end

    def add_person(person)
      return false unless person.is_a? Gedcomx::Person
      @record.add_person(person)
      new_person = Person.new(person)
      @people << new_person
      new_person
    end

    def add_relationship(relationship)
      return false unless relationship.is_a? Gedcomx::Relationship
      @record.add_relationship(relationship)
      new_relationship = Relationship.new(relationship)
      @relationships << new_relationship
      new_relationship
    end

    def each_person
      @people.each do |person|
        yield person
      end
    end

    def each_relationship
      @relationships.each do |relationship|
        yield relationship
      end
    end

    def to_java
      @record
    end
  end
end
