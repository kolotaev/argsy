lib = 'lib/argsy.rb'

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.authors = ['Egor Kolotaev']
  spec.summary = 'Tiny "commands & options" DSL for your CLI scripts'
  spec.email = %w(ekolotaev@gmail.com)
  spec.homepage = 'https://github.com/kolotaev/argsy'
  spec.license = 'The Unlicense'
  spec.name = 'argsy'
  spec.require_paths = [lib]
  spec.required_ruby_version = '>= 2.4.5'
  spec.description = spec.summary
  spec.files = %w(LICENSE.txt README.md argsy.gemspec) + Dir[lib]
  spec.version = '0.1.0'
end
