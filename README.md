# ThreadLocalAccessor

Thread local accessor. An idea and big part of code from [here](http://coderrr.wordpress.com/2008/04/10/lets-stop-polluting-the-threadcurrent-hash/).

## Installation

Add this line to your application's Gemfile:

    gem 'thread_local_accessor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thread_local_accessor

## Usage

It implement thread-safe class accessor implemented via Thread.current:

``` ruby
class ThreadedLib
  thread_local_accessor :some_setting, :default => :default
end

instance = ThreadedLib.new
ThreadedLib.some_setting = 5

ThreadedLib.some_setting # => 5
instance.some_setting    # => 5

Thread.new {
  ThreadedLib.some_setting # => :default
  instance.some_setting    # => :default
end
```

