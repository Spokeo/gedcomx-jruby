module Gedcomx

  class Person

    def initialize(input)
      @person = input
    end

    def male?
      gender = @person.get_gender.get_type.to_s
      gender == TYPES[:male]
    end

    def female?
      gender = @person.get_gender.get_type.to_s
      gender == TYPES[:female]
    end

    def gender
      return TYPES[:male] if self.male?
      TYPES[:female] if self.female?
    end

    # Returns a list of name hashes
    def names
      names_list = []
      @person.names.each do |name_obj|
        name_obj.name_forms.each do |name_form_obj|
          name_hash = {}
          name_hash[:full] = name_form_obj.get_full_text
          name_hash[:first] = name_form_obj.parts.find{|part| part.get_type.to_s == TYPES[:given] }.andand.get_value
          name_hash[:last] = name_form_obj.parts.find{|part| part.get_type.to_s == TYPES[:surname] }.andand.get_value
          names_list << name_hash
        end
      end
      names_list
    end
  end
end
