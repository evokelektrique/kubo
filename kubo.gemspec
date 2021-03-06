# frozen_string_literal: true

require_relative "lib/kubo/version"

Gem::Specification.new do |spec|
  spec.name          = "kubo"
  spec.version       = Kubo::VERSION
  spec.authors       = ["EVOKE"]
  spec.email         = ["evoke.lektrique@gmail.com"]
  spec.license       = "AGPL-3.0-or-later"
  spec.summary       = "Cache files."
  spec.description   = "Cache files long description here."
  spec.homepage      = "http://github.com/evokelektrique/kubo"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "http://github.com/evokelektrique/kubo/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
