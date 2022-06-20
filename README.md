# HexletCode
![hexlet-check Status](https://github.com/Zigreal/rails-project-lvl1/actions/workflows/hexlet-check.yml/badge.svg?branch=main)
![CI Status](https://github.com/Zigreal/rails-project-lvl1/actions/workflows/ci.yml/badge.svg?branch=main)

The form generator allows you to generate forms - it is a simplified conceptual copy of SimpleForm

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add hexlet_code

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install hexlet_code

## Usage
```rb
User = Struct.new(:name, :job, keyword_init: true)
user = User.new name: 'Hexlet', job: 'hexlet'

HexletCode.form_for(user, url: '/users') do |f|
  f.input :name
  f.input :job, as: :text, cols: 30
  f.submit 'Mega save'
end

# <form action="/users" method="post">
#   <label for="name">Name</label>
#   <input type="text" name="name" value="Hexlet">
#   <label for="job">Job</label>
#   <textarea cols="30" rows="40" name="job">hexlet</textarea>
#   <input type="submit" name="commit" value="Mega save">
# </form>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hexlet_code. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/hexlet_code/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HexletCode project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/hexlet_code/blob/master/CODE_OF_CONDUCT.md).
