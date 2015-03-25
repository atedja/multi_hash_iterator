require './lib/multi_hash_iterator'

Gem::Specification.new do |s|
  s.name = "multi_hash_iterator"
  s.version = "0.1.3"
  s.authors = ["Albert Tedja"]
  s.email = "nicho_tedja@yahoo.com"
  s.homepage = "https://github.com/atedja/multi_hash_iterator"
  s.summary = "Iterate through multiple hashmaps at once"
  s.description = "multi_hash_iterator allows you iterate through multiple hashmaps at once"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency 'minitest',  '~> 5.3'
  s.add_development_dependency 'mocha', '~> 1.1'
  s.add_development_dependency 'rake', '~> 10.3'

  s.license = "BSD"
end
