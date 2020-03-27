
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rcellrange/version"

Gem::Specification.new do |spec|
  spec.name          = "rcellrange"
  spec.version       = Rcellrange::VERSION
  spec.authors       = ["iwazer"]
  spec.email         = ["iwazawa@gmail.com"]

  spec.summary       = %q{This is a helper that can handle a range of spreadsheets by cell number.}
  spec.description   = %q{(\\( ⁰⊖⁰)/)}
  spec.homepage      = "https://github.com/iwazer/rcellrange"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.12"
end
