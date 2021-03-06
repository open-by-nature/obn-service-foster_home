require_relative 'lib/obn/service/foster_home/version'

Gem::Specification.new do |spec|
  spec.name          = "obn-service-foster_home"
  spec.version       = Obn::Service::FosterHome::VERSION
  spec.authors       = ["Víctor Bermúdez"]
  spec.email         = ["vbermudez@outlook.es"]

  spec.summary       = "Open by Nature Service for Foster Homes"
  spec.description   = "Open by Nature Service for Foster Homes"
  spec.homepage      = "https://github.com/open-by-nature"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/open-by-nature/obn-service-foster_home"
  spec.metadata["changelog_uri"] = "https://github.com/open-by-nature/obn-service-foster_home/CHANGE_LOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "rake", "~> 13.0.1"
  spec.add_development_dependency "standalone_migrations"
  spec.add_dependency "dotenv"
  spec.add_dependency "grpc"
  spec.add_dependency "grpc-tools"
  spec.add_dependency "pg"
  spec.add_dependency "activerecord"
  spec.add_dependency "logging"
end
