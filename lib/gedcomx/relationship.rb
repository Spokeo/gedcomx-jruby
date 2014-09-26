module Gedcomx
  class Relationship

    attr_reader :person1, :person2

    def initialize(input)
      @relationship = input
      @person1 = @relationship.get_person1.get_resource.to_s[1..-1]
      @person2 = @relationship.get_person2.get_resource.to_s[1..-1]
    end

    def couple?
      type == TYPES[:couple]
    end

    def parent_child?
      type == TYPES[:parent_child]
    end

    protected

    def type
      @relationship.get_type.to_s
    end
  end
end
