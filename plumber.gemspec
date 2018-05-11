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
  s.add_dependency "ransack", "~> 1.8"
  s.add_dependency "maildown", "~> 3.0"
  s.add_dependency "liquid", "~> 4.0"
  s.add_dependency 'simple_form', '~> 4.0'
  s.add_dependency 'jquery-rails', '~> 4.3'
  s.add_dependency 'bootstrap', '~> 4.1'
  s.add_dependency 'kaminari', '~> 1.1'
  s.add_dependency 'bootstrap4-kaminari-views', '~> 1.0'
  s.add_dependency 'kramdown', '~> 1.16'

  s.add_development_dependency "pg"
end
