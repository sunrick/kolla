lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kolla/version'

Gem::Specification.new do |spec|
  spec.name = 'kolla'
  spec.version = Kolla::VERSION
  spec.authors = ['Rickard Sunden']
  spec.email = %w[rickard.sunden@outlook.com]

  spec.summary = 'idk'
  spec.description = 'idk'
  spec.homepage = 'https://github.com/sunrick/kolla'
  spec.license = 'MIT'

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] =
    'https://github.com/sunrick/kolla/blob/master/README.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files =
    Dir.chdir(File.expand_path('..', __FILE__)) do
      `git ls-files -z`.split("\x0").reject do |f|
        f.match(%r{^(test|spec|features)/})
      end
    end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.add_dependency 'paint'
  spec.add_dependency 'progressbar'
  spec.add_dependency 'terminal-table'
  spec.add_dependency 'prettier'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
end
