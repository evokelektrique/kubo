# frozen_string_literal: true

module Kubo
  # Base file class
  class BaseFile
    attr_writer :time, :path

    def initialize(time = "1h", path = "cache")
      @time = parse_time(time)
      @path = parse_path(path)
    end

    # Convert given time to seconds
    def parse_time(time)
      duration_time = time[...-1].to_i
      duration_type = time[-1..]
      convert_to_seconds(duration_type, duration_time)
    end

    def parse_path(path)
      path
    end

    private

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
