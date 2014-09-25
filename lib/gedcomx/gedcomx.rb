require "gedcomx/jruby/version"
Dir.glob('lib/gedcomx_java_jars/*.jar').each { |jar| require jar }

module Gedcomx

  TYPES = {
      birth: 'http://gedcomx.org/Birth',
      birth_place_father: 'http://gedcomx.org/FatherBirthPlace',
      birth_place_mother: 'http://gedcomx.org/MotherBirthPlace',
      census: 'http://gedcomx.org/Census',
      collection: 'http://gedcomx.org/Collection',
      collection_id: 'http://familysearch.org/types/fields/FS_COLLECTION_ID',
      couple: 'http://gedcomx.org/Couple',
      digital_artifact: 'http://gedcomx.org/DigitalArtifact',
      ethnicity: 'http://familysearch.org/types/fields/PR_ETHNICITY_CSS',
      female: 'http://gedcomx.org/Female',
      given: 'http://gedcomx.org/Given',
      household: 'http://familysearch.org/types/fields/HOUSEHOLD_ID',
      image_id: 'http://familysearch.org/types/fields/IMAGE_PAL',
      immigration: 'http://gedcomx.org/Immigration',
      male: 'http://gedcomx.org/Male',
      marital_status: 'http://gedcomx.org/MaritalStatus',
      month: 'http://gedcomx.org/Month',
      parent_child: 'http://gedcomx.org/ParentChild',
      persistent: 'http://gedcomx.org/Persistent',
      race: 'http://gedcomx.org/Race',
      record: 'http://gedcomx.org/Record',
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


