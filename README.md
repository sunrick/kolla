# Kolla

This is just a fun experiment I was playing with. I was building a command line application that I wanted to show some fun-ish graphics for.

I experimented with code organization here, I wanted to make something that is configurable application wide but also you could use each class as a standalone object if you wanted.

I won't be updating this code any time in the future, it was just a thing I wanted to try out!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kolla'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kolla

## Usage

```ruby
Kolla::Display.start do
  line('Calculating your life expectancy')
  indent do
    spinner(status: 'Calculating age', complete: 'Done!') { sleep 0.5 }
    spinner(status: 'Calculating sex', complete: 'Done!') { sleep 0.2 }
    spinner(status: 'Calculating height', complete: 'Done!') { sleep 0.3 }

    empty_line

    indent do
      line('I am a random line...')
      spinner(
        status: 'Calculating life expectancy...', complete: 'Done!'
      ) do |s|
        sleep 0.1
        s.animation.interval = 200
        sleep 2
      end
      progress(title: 'What is going on?') do |p|
        50.times do |i|
          p.increment
          sleep 0.25
        end
      end
      table { |t| t << ['one', 1] }
    end

    line('Another random line')
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/kolla. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Kolla project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/kolla/blob/master/CODE_OF_CONDUCT.md).
