# frozen_string_literal: true

require "fileutils"
require "zlib"
require_relative "kubo/version"
require_relative "kubo/base_file"
require_relative "kubo/zip"

module Kubo
  class Error < StandardError; end
end
