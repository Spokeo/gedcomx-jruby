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
      return TYPES[:male] if male?
      TYPES[:female] if female?
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

    def event_date
      primary_date = self.primary_fact.andand.get_date
      return if primary_date.nil?
      get_date(primary_date)
    end

    def birth_date
      birth_date_obj = Gedcomx.get_first_fact(@person, :birth).andand.get_date
      get_date(birth_date_obj)
    end

    def first_value(type)
      field = Gedcomx.get_first_field(@person, type)
      unless field.nil?
        return Gedcomx.interpreted_value(field).andand.get_text
      end
      Gedcomx.get_first_fact(@person, type).andand.get_value
    end

    def location
      primary_fact = @person.facts.find{|fact| fact.get_primary }

      location = primary_fact.get_place
      location_params = {}
      location_params[:name] = location.get_original

      # Fill in the location level definitions
      location_levels = {}
      location_fields = @person.fields.select{|field| field.get_type.to_s.include? 'EVENT_PLACE_LEVEL_' }
      location_fields.each do |field|
        value = field.get_values[0].get_text
        level = /EVENT_PLACE_LEVEL_\d/.match(field.get_type.to_s)[0]
        location_levels[level] = value
      end

      # Match the location name to the appropriate level
      location.get_fields.each do |field|
        value = Gedcomx.interpreted_value(field)

        # Store the level if it is valid
        level = location_levels[value.label_id]
        next if level.nil?
        mapped_value = Gedcomx.location_mapping(level)
        next if mapped_value.nil?
        location_params[mapped_value] = value.get_text
      end

      location_params
    end

    def relative_id
      @person.get_id
    end

    # Generates accessor methods for each of the types
    TYPES.keys.each do |type|
      define_method type do
        first_value(type)
      end
    end

    protected

    def primary_fact
      @person.facts.find{|fact| fact.get_primary }
    end

    def get_date(date_obj)
      year = Gedcomx.interpreted_value( Gedcomx.get_first_field(date_obj, :year) ).andand.get_text.andand.to_i
      month = Gedcomx.interpreted_value( Gedcomx.get_first_field(date_obj, :month) ).andand.get_text
      month = Gedcomx::MONTH_MAP[month.downcase.to_sym] unless month.nil?
      day = Gedcomx.interpreted_value( Gedcomx.get_first_field(date_obj, :day) ).andand.get_text
      {
          year: year,
          month: month,
          day: day
      }
    end

  end
end
