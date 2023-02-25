# Ruby autograding for PrairieLearn

This autograder assumes a Docker container with `rvm` installed and
the necessary versions of Ruby and all gems to grade a question.

This package includes RSpec and Cucumber test formatters whose JSON
output matches what PrairieLearn wants, and `rake` tasks to run RSpec
and Cucumber using these formatters that know where to look for
various files PrairieLearn provides or expects.

When the autograder wakes up, `/grade/student/` will contain file(s)
submitted by the student, `/grade/tests/` will contain everything in
the `tests/` directory of your PL question.

To autograde a Ruby question by running some collection of specs and
features, configure your PL question directory as follows:

In `info.json`:

```json
"gradingMethod": "External",
"externalGradingOptions": {
    "enabled": true,
    "image" : "nasloon/rspec-autograder",
    "entrypoint": "/grader/run.py",
    "timeout" : 60
}
```


Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/pl/ruby/autograder`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pl-ruby-autograder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pl-ruby-autograder

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pl-ruby-autograder. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Pl::Ruby::Autograder project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/pl-ruby-autograder/blob/master/CODE_OF_CONDUCT.md).
