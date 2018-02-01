$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'resumable_file_upload/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'resumable_file_upload'
  s.version     = ResumableFileUpload::VERSION
  s.authors     = ['Rene van Lieshout']
  s.email       = ['rene@lico.nl']
  s.homepage    = 'https://github.com/bluerail/resumable_file_upload'
  s.summary     = 'Resumable file uploads using resumable.js'
  s.description = 'Resumable file uploads using resumable.js'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.1.0'

  # s.add_development_dependency 'sqlite3'
end
