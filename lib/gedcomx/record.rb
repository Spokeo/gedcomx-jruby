module Gedcomx
  class Record

    attr_reader :people, :relationships

    def initialize(input)
      @record = input
      @people = @record.persons
      unless @people.nil?
        @people = @people.map{|person| Person.new(person) }
      end
      @relationships = @record.relationships
      unless @relationships.nil?
        @relationships = @relationships.map{|relationship| Relationship.new(relationship) }
      end
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
