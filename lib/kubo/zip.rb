# frozen_string_literal: true

module Kubo
  # Base caching class
  class Zip < BaseFile
    # Write the compressed value to file
    def save(key, value)
      path = get_file_path(key.to_s)
      file = File.new(path, "w+")
      file.puts(compress(value))
      file.close
    end

    # Decompress file
    def read(key)
      path = get_file_path(key.to_s)
      file = File.read(path)
      Zlib::Inflate.inflate(file)
    end

    private

    # Compress file to gz
    def compress(value)
      Zlib::Deflate.deflate(value)
    end
  end
end
