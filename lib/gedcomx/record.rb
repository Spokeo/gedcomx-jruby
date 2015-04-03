module Gedcomx
  class Record

    attr_reader :people, :relationships

    def self.java_class
      Java::OrgGedcomx::Gedcomx
    end

    def initialize(input = nil)
      @record = input || self.class.java_class.new

      @people = []
      @people = @record.persons.map { |person| Gedcomx::Person.new(person) } if @record.persons

      @relationships = []
      if @record.relationships
        @relationships = @record.relationships.map { |relationship| Gedcomx::Relationship.new(relationship) }
      end
    end

    def add_person(person)
      return false unless person.is_a? Gedcomx::Person
      @record.add_person(person.to_java)
      @people << person
    end

    def add_relationship(relationship)
      return false unless relationship.is_a? Gedcomx::Relationship
      @record.add_relationship(relationship.to_java)
      @relationships << relationship
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
