
module Gedcomx
  class Iterator
    def initialize(input)
      unless File.file?(input)
        input = Gedcomx.input_stream(input)
      end
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

    def to_java
      @iter
    end
  end
end
