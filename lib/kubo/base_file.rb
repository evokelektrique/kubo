# frozen_string_literal: true

module Kubo
  # Base file class
  class BaseFile
    attr_accessor :path, :time

    def initialize(time = "1h", path = "./cache")
      @time = parse_time(time)
      @path = parse_path(path)
      generate_path
    end

    def parse_path(path)
      File.expand_path(path)
    end

    # Convert given time to seconds
    def parse_time(time)
      duration_time = time[...-1].to_i

      raise(StandardError, "Expiration time has to be greater than zero") if duration_time <= 0

      duration_type = time[-1..]
      convert_to_seconds(duration_type, duration_time)
    end

    def expired?(key)
      path = get_file_path(key)
      (Time.now - File.mtime(path)) >= @time
    end

    def delete_if_expired(key)
      return false unless file_empty?(key) || file_exists(key)

      delete(key) if expired?(key)

      true
    end

    def delete(key)
      path = get_file_path(key)
      File.delete(path)
    end

    def flush(key)
      path = get_file_path(key)
      File.truncate(path, 0)
    end

    # Check whether the files is empty or not
    def file_empty?(key)
      path = get_file_path(key)
      File.size(path)
    end

    def file_exists?(key)
      path = get_file_path(key)

      return false unless File.exist?(path)

      true
    end

    # Concatenate absolute path with key
    def get_file_path(key)
      "#{@path}/#{key}"
    end

    private

    def generate_path
      FileUtils.mkdir_p @path
    end

    def convert_to_seconds(type, time)
      case type
      when "s"
        time
      when "m"
        time * 60
      when "h"
        time * 60 * 60
      when "d"
        time * 60 * 60 * 24
      end
    end
  end
end
