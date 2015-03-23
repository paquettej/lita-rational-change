Gem::Specification.new do |spec|
  spec.name          = "lita-rational-change"
  spec.version       = "0.0.3"
  spec.authors       = ["Jeff Paquette"]
  spec.email         = ["jeff@snowmoonsoftware.com"]
  spec.description   = "Generates a CR link from a defect number for Rational Change"
  spec.summary       = "Generates a CR link from a defect number for Rational Change"
  spec.homepage      = "https://github.com/snowmoonsoftware/lita-rational-change"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.3"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
end
