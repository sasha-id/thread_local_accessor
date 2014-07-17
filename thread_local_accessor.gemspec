# -*- encoding: utf-8 -*-
require File.expand_path('../lib/thread_local_accessor/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alexey Vakhov"]
  gem.email         = ["vakhov@gmail.com"]
  gem.description   = %q{Thread Local Accessor}
  gem.summary       = %q{Thread Safe Local Accessor}
  gem.homepage      = "https://github.com/avakhov/thread_local_accessor"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "thread_local_accessor"
  gem.require_paths = ["lib"]
  gem.version       = ThreadLocalAccessor::VERSION

  gem.add_development_dependency 'rake'
end
