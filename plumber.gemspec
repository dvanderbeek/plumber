$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "plumber/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "plumber"
  s.version     = Plumber::VERSION
  s.authors     = ["David Van Der Beek"]
  s.email       = ["earlynovrock@gmail.com"]
  s.homepage    = "https://github.com/dvanderbeek/plumber"
  s.summary     = "Drip campaigns for Rails! Fix your leaky user acquisition pipes."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"
  s.add_dependency "ransack"

  s.add_development_dependency "pg"
end
