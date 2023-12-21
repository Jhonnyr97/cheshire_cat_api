# frozen_string_literal: true

require_relative "lib/cheshire_cat_api/version"

Gem::Specification.new do |spec|
  spec.name = "cheshire_cat_api"
  spec.version = CheshireCatApi::VERSION
  spec.authors = ["Nilthon Jhon Rojas Apumayta"]
  spec.email = ["oneill.jhon97@gmail.com"]

  spec.summary = "The 'cheshire_cat_api' gem is a flexible and efficient client for the 'Cheshire Cat' framework in the field of Artificial Intelligence. It provides both a Large Language Model (LLM) and a sophisticated embedding system that are ready to use to enhance your project."
  spec.homepage = "https://github.com/Jhonnyr97/cheshire_cat_api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = 'https://github.com/Jhonnyr97/cheshire_cat_api'
  spec.metadata["source_code_uri"] = "https://github.com/Jhonnyr97/cheshire_cat_api"
  spec.metadata["changelog_uri"] = "https://github.com/Jhonnyr97/cheshire_cat_api/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "httparty", "~> 0.21.0"
  spec.add_dependency "faye-websocket", "~> 0.11.3"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "webmock", '~> 3.19.1'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
