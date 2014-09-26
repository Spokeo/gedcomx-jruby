module Gedcomx
  class Writer

    def initialize
      @output_stream = java.io.ByteArrayOutputStream.new
      @writer = org.gedcomx.util.RecordSetWriter.new(@output_stream)
    end

    def add_record(record)
      @writer.writeRecord(record.record)
    end

    def close
      @writer.close
      java.lang.String.new(@output_stream.toByteArray).to_s
    end
  end
end
