$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?('argsy.rb')

Gem::Specification.new do |spec|
  spec.authors = ['Egor Kolotaev']
  spec.summary = 'Tiny helper snippet for writing command line tools.'
  spec.email = %w(ekolotaev@gmail.com)
  spec.homepage = 'https://github.com/samsara/samsara/tree/master/clients/ruby'
  spec.license = 'MIT'
  spec.name = 'argsy'
  spec.require_paths = %w(argsy.rb)
  spec.required_ruby_version = '>= 1.9.3'
  spec.description = spec.summary
  spec.files = %w(LICENSE.txt README.md samsara_sdk.gemspec) + Dir['lib/**/*.rb']
  spec.version = '0.1.0'
end
