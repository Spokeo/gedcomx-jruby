
module Gedcomx
  class Record

    attr_reader :people, :relationships

    def initialize(input)
      @record = input
      @people = @record.persons.map{|person| Person.new(person) }
    end

    def each_person
      @people.each do |person|
        yield person
      end
    end

  end
end
