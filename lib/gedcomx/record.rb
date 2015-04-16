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

    def relate_people(person1, person2, type)
      return false unless ( person1.is_a?(Gedcomx::Person) && person2.is_a?(Gedcomx::Person) )
      reference1 = Gedcomx::ResourceReference.create(resource: person1.relative_id)
      reference2 = Gedcomx::ResourceReference.create(resource: person2.relative_id)
      relationship = Gedcomx::Relationship.create(person1: reference1, person2: reference2, type: type)
      add_relationship(relationship)
    end

    def add_couple(person1, person2)
      relate_people(person1, person2, Gedcomx::TYPES[:couple])
    end

    def add_parent_child(parent, child)
      relate_people(parent, child, Gedcomx::TYPES[:parent_child])
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
