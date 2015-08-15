require "gedcomx/jruby/version"

module Gedcomx
  TYPES = {
      age: 'http://gedcomx.org/Age',
      birth: 'http://gedcomx.org/Birth',
      birth_name: 'http://gedcomx.org/BirthName',
      birth_place_father: 'http://gedcomx.org/FatherBirthPlace',
      birth_place_mother: 'http://gedcomx.org/MotherBirthPlace',
      census: 'http://gedcomx.org/Census',
      collection: 'http://gedcomx.org/Collection',
      collection_id: 'http://familysearch.org/types/fields/FS_COLLECTION_ID',
      couple: 'http://gedcomx.org/Couple',
      date: 'http://gedcomx.org/Date',
      day: 'http://gedcomx.org/Day',
      digital_artifact: 'http://gedcomx.org/DigitalArtifact',
      ethnicity: 'http://familysearch.org/types/fields/PR_ETHNICITY_CSS',
      event_city: 'http://familysearch.org/types/fields/EVENT_TOWNSHIP',
      event_country: 'http://familysearch.org/types/fields/EVENT_COUNTRY',
      event_county: 'http://familysearch.org/types/fields/EVENT_COUNTY',
      event_district: 'http://familysearch.org/types/fields/EVENT_DISTRICT',
      event_state: 'http://familysearch.org/types/fields/EVENT_STATE',
      event_type: 'http://familysearch.org/types/fields/EVENT_TYPE',
      female: 'http://gedcomx.org/Female',
      film_number: 'http://familysearch.org/types/fields/FILM_NUMBER',
      folder: 'http://familysearch.org/types/fields/FOLDER',
      folder_image_seq: 'http://familysearch.org/types/fields/FOLDER_IMAGE_SEQ',
      gender: 'http://gedcomx.org/Gender',
      given: 'http://gedcomx.org/Given',
      household: 'http://familysearch.org/types/fields/HOUSEHOLD_ID',
      image_apid: 'http://familysearch.org/types/fields/IMAGE_APID',
      image_ark: 'http://familysearch.org/types/fields/ImageArk',
      image_id: 'http://familysearch.org/types/fields/IMAGE_PAL',
      image_number: 'http://familysearch.org/types/fields/IMAGE_NBR',
      image_pal: 'http://familysearch.org/types/fields/IMAGE_PAL',
      immigration: 'http://gedcomx.org/Immigration',
      interpreted: 'http://gedcomx.org/Interpreted',
      male: 'http://gedcomx.org/Male',
      marital_status: 'http://gedcomx.org/MaritalStatus',
      month: 'http://gedcomx.org/Month',
      name: 'http://gedcomx.org/Name',
      original: 'http://gedcomx.org/Original',
      parent_child: 'http://gedcomx.org/ParentChild',
      persistent: 'http://gedcomx.org/Persistent',
      race: 'http://gedcomx.org/Race',
      record: 'http://gedcomx.org/Record',
      record_group: 'http://familysearch.org/types/fields/RECORD_GROUP',
      relation_to_head: 'http://gedcomx.org/RelationshipToHead',
      source_line: 'http://familysearch.org/types/fields/SOURCE_LINE_NBR',
      source_sheet: 'http://familysearch.org/types/fields/SOURCE_SHEET_NBR_LTR',
      source_sheet_letter: 'http://familysearch.org/types/fields/SOURCE_SHEET_LTR',
      source_sheet_number: 'http://familysearch.org/types/fields/SOURCE_SHEET_NBR',
      surname: 'http://gedcomx.org/Surname',
      unique_id: 'http://familysearch.org/types/fields/UNIQUE_IDENTIFIER',
      year: 'http://gedcomx.org/Year',
      years_married: 'http://familysearch.org/types/fields/PR_CNT_YEARS_MARR'
  }
end

require 'gedcomx/writer'
require 'gedcomx/person'
require 'gedcomx/relationship'
require 'gedcomx/record'
require 'gedcomx/iterator'
require 'gedcomx/fact'
require 'gedcomx/field'
require 'gedcomx/field_value'
require 'gedcomx/name'
require 'gedcomx/name_part'
require 'gedcomx/name_form'
require 'gedcomx/date'
require 'gedcomx/place'
require 'gedcomx/gender'
require 'gedcomx/identifier'
require 'gedcomx/resource_reference'

# Load all the java jars
require "gedcomx_java_jars/enunciate-gedcomx-support-1.0.82.M1-SNAPSHOT-sources.jar"
require "gedcomx_java_jars/enunciate-gedcomx-support-1.0.82.M1-SNAPSHOT.jar"
require "gedcomx_java_jars/familysearch-api-client-1.0.82.M1-SNAPSHOT-sources.jar"
require "gedcomx_java_jars/familysearch-api-client-1.0.82.M1-SNAPSHOT.jar"
require "gedcomx_java_jars/familysearch-api-model-1.0.82.M1-SNAPSHOT-sources.jar"
require "gedcomx_java_jars/familysearch-api-model-1.0.82.M1-SNAPSHOT.jar"
require "gedcomx_java_jars/gedcomx-atom-1.0.82.M1-SNAPSHOT-sources.jar"
require "gedcomx_java_jars/gedcomx-atom-1.0.82.M1-SNAPSHOT.jar"
require "gedcomx_java_jars/gedcomx-date-1.0.82.M1-SNAPSHOT-sources.jar"
require "gedcomx_java_jars/gedcomx-date-1.0.82.M1-SNAPSHOT.jar"
require "gedcomx_java_jars/gedcomx-fileformat-1.0.82.M1-SNAPSHOT-sources.jar"
require "gedcomx_java_jars/gedcomx-fileformat-1.0.82.M1-SNAPSHOT.jar"
require "gedcomx_java_jars/gedcomx-model-1.0.82.M1-SNAPSHOT-sources.jar"
require "gedcomx_java_jars/gedcomx-model-1.0.82.M1-SNAPSHOT.jar"
require "gedcomx_java_jars/gedcomx-rs-client-1.0.82.M1-SNAPSHOT-sources.jar"
require "gedcomx_java_jars/gedcomx-rs-client-1.0.82.M1-SNAPSHOT.jar"
require "gedcomx_java_jars/gedcomx-rs-rt-support-1.0.82.M1-SNAPSHOT-sources.jar"
require "gedcomx_java_jars/gedcomx-rs-rt-support-1.0.82.M1-SNAPSHOT.jar"
require "gedcomx_java_jars/gedcomx-rt-support-1.0.82.M1-SNAPSHOT-sources.jar"
require "gedcomx_java_jars/gedcomx-rt-support-1.0.82.M1-SNAPSHOT.jar"
require "gedcomx_java_jars/gedcomx-test-support-1.0.82.M1-SNAPSHOT-sources.jar"
require "gedcomx_java_jars/gedcomx-test-support-1.0.82.M1-SNAPSHOT.jar"
require "gedcomx_java_jars/jaxb-all.osgi-2.1.6.jar"

module Gedcomx
  MONTH_MAP = {
      jan: 1,
      feb: 2,
      mar: 3,
      apr: 4,
      may: 5,
      jun: 6,
      jul: 7,
      aug: 8,
      sep: 9,
      oct: 10,
      nov: 11,
      dec: 12
  }

  LOCATION_MAP = {
      country: :country,
      state: :state,
      county: :region
  }

  def self.java_uri_class
    Java::OrgGedcomxCommon::URI
  end

  def self.new_uri(uri_string)
    self.java_uri_class.new(uri_string.to_s)
  end

  def self.get_facts(obj, type)
    return unless obj
    obj.facts.select{|fact| fact.get_type.to_s == TYPES[type] }
  end

  def self.get_first_fact(obj, type)
    return unless obj
    obj.facts.find{|fact| fact.get_type.to_s == TYPES[type] }
  end

  def self.get_fields(obj, type)
    return unless obj
    obj.fields.select{|field| field.get_type.to_s == TYPES[type] }
  end

  def self.get_first_field(obj, type)
    return unless obj
    obj.fields.find{|field| field.get_type.to_s == TYPES[type] }
  end

  def self.interpreted_value(field_obj)
    return if field_obj.nil?
    values = field_obj.get_values

    # If more than 1 value exists, we will choose 'Interpreted'
    if values.length > 1
      value = values.select{|val| val.get_type.to_s.include? 'Interpreted' }.first
    else
      value = values[0]
    end

    return value
  end

  def self.location_mapping(key)
    value = LOCATION_MAP[key.downcase.to_sym]
    return value unless value.nil?
    return :city if key.downcase.include? 'town'
  end

  def self.to_java_string(ruby_string)
    java.lang.String.new(ruby_string)
  end

  def self.input_stream(ruby_string)
    java.io.ByteArrayInputStream.new( to_java_string(ruby_string).getBytes )
  end

end


