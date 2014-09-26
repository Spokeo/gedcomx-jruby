
module Gedcomx
  class Record

    attr_reader :people, :record, :relationships

    def initialize(input)
      @record = input
      @people = @record.persons.map{|person| Person.new(person) }
      @relationships = @record.relationships.map{|relationship| Relationship.new(relationship) }
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
  end
end
