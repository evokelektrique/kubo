# frozen_string_literal: true

module Kubo
  # Base caching class
  class Cache
    attr_accessor :type

    def initialize(type)
      @type = type
    end
  end
end
