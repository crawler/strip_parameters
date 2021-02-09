# frozen_string_literal: true

$LOAD_PATH.push(File.expand_path('lib', __dir__))
require 'strip_parameters/version'

Gem::Specification.new do |s|
  s.name     = 'strip_parameters'
  s.version  = StripParameters::VERSION
  s.authors  = ['Anton Topchii']
  s.email    = ['player1@infinitevoid.net']
  s.summary  = 'Use strip_attributes to nillify empty parameters and forget about ".present?"'
  s.homepage = 'https://github.com/crawler/strip_parameters'
  s.license  = 'MIT'

  s.metadata = {
    'source_code_uri' => "https://github.com/crawler/strip_parameters/tree/v#{StripParameters::VERSION}"
  }

  s.required_ruby_version = '>= 2.4.0'

  s.add_runtime_dependency 'actionpack', '>= 4.0', '< 7.0'

  s.add_development_dependency 'bundler', '>= 2.1.4'
  s.add_development_dependency 'rubocop', '1.9.1'
  s.add_development_dependency 'rubocop-performance'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
end
