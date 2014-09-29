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
          first_name = name_form_obj.parts.find{|part| part.get_type.to_s == TYPES[:given] }
          unless first_name.nil?
            name_hash[:first] = first_name.get_value
          end
          last_name = name_form_obj.parts.find{|part| part.get_type.to_s == TYPES[:surname] }
          unless last_name.nil?
            name_hash[:last] = last_name.get_value
          end
          names_list << name_hash
        end
      end
      names_list
    end

    def event_date
      primary_fact = self.primary_fact
      unless primary_fact.nil?
        primary_date = primary_fact.get_date
        return get_date(primary_date) unless primary_date.nil?
      end
    end

    def birth_date
      birthday_obj = Gedcomx.get_first_fact(@person, :birth)
      unless birthday_obj.nil?
        birth_date_obj = birthday_obj.get_date
        get_date(birth_date_obj)
      end
    end

    def first_value(type)
      field = Gedcomx.get_first_field(@person, type)
      unless field.nil?
        interpreted = Gedcomx.interpreted_value(field)
        return interpreted.get_text unless interpreted.nil?
        return nil
      end
      fact = Gedcomx.get_first_fact(@person, type)
      unless fact.nil?
        fact.get_value
      end
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

    def to_java
      @person
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
      date_hash = {}
      year_field = Gedcomx.interpreted_value( Gedcomx.get_first_field(date_obj, :year) )
      unless year_field.nil?
        year = year_field.get_text.to_i
        date_hash[:year] = year
      end
      month_field = Gedcomx.interpreted_value( Gedcomx.get_first_field(date_obj, :month) )
      unless month_field.nil?
        month = month_field.get_text
        month = MONTH_MAP[month.downcase.to_sym] unless month.nil?
        date_hash[:month] = month
      end
      day_field = Gedcomx.interpreted_value( Gedcomx.get_first_field(date_obj, :day) )
      unless day_field.nil?
        day = day_field.get_text
        date_hash[:day] = day
      end
      date_hash
    end
  end
end
