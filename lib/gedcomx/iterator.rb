
module Gedcomx
  class Iterator
    def initialize(input)
      @iter = org.gedcomx.util.RecordSetIterator.new(input)
    end

    def has_next?
      @iter.hasNext
    end

    def done?
      !@iter.hasNext
    end

    def next
      Record.new(@iter.next)
    end
  end
end
