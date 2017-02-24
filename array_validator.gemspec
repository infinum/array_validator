# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'array_validator'
  spec.version       = '0.1.0'
  spec.authors       = ['Damir Svrtan']
  spec.email         = ['damir.svrtan@gmail.com']

  spec.summary       = 'Array validations for Rails'
  spec.description   = 'Array validations for Rails (e.g. Postgres jsonb columns)'
  spec.homepage      = 'https://github.com/infinum/array_validator'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activemodel', '~> 5.0'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'simplecov', '~> 0.12.0'
end
