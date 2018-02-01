# ResumableFileUpload
Short description and motivation.

depends on jquery...

## Usage

Add it to your routes:

```ruby
mount ResumableFileUpload::Engine, at: '/upload'
```

Include JS:

```coffeescript
  #= require resumable_file_upload/application
```

Include provided helpers

```ruby
class ApplicationController < ActionController::Base
  helper ResumableFileUpload::Engine.helpers
end
```

Convert your inputs:

```haml
  = resumable_file_upload_tag 'input_name'
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'resumable_file_upload'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install resumable_file_upload
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
