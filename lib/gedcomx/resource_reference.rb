module Gedcomx
  class ResourceReference

    def self.java_class
      Java::OrgGedcomxCommon::ResourceReference
    end

    def self.create(attributes = {})
      reference = self.new
      reference.resource = attributes[:resource] if attributes[:resource]
      reference.resource_id = attributes[:resource_id] if attributes[:resource_id]
      reference
    end

    def initialize(input = nil)
      @reference = input || self.class.java_class.new
    end

    def resource
      @reference.get_resource.to_s
    end

    def resource=(new_resource)
      @reference.resource = ( new_resource.is_a? Gedcomx.java_uri_class ) ? new_resource : Gedcomx.new_uri(new_resource)
    end

    def resource_id
      @reference.get_resource_id
    end

    def resource_id=(new_resource_id)
      @reference.resource_id = new_resource_id
    end

    def to_java
      @reference
    end
  end
end
