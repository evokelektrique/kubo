# Kubo
Kubo is a Ruby gem to file cache easily.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kubo'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install kubo

## Usage
```ruby
# Initializing a Zip instance to compress data to GZip and the Zip class
# takes two arguments for expiration and a path for storing keys.
# Kubo::Zip.new(time, path)
# `time` argument could be "1s", "1h", "1d" which it will be converted to seconds later.
kubo = Kubo::Zip.new("1h", "./cache/my_cache_folder")

# Save a key with value
key = "my_key"
value = "My value"
kubo.save(key, value)

# Read a key
kubo.read(key) # => "My value"

# Check expiration of a key
kubo.expired?(key)

# Flush / Truncate a key
kubo.flush(key)

# Delete a key
kubo.delete(key)
kubo.delete_if_expired(key) # Deletes the key if it's expired.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/evokelektrique/kubo.
