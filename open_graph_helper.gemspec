# -*- encoding: utf-8 -*-
require File.expand_path('../lib/open_graph_helper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["xdite"]
  gem.email         = ["xdite@techbang.com.tw"]
  gem.description   = %q{OpenGraph Helper}
  gem.summary       = %q{OpenGraph Helper}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "open_graph_helper"
  gem.require_paths = ["lib"]
  gem.version       = OpenGraphHelper::VERSION
end
