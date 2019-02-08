# Argsy

Tiny helper snippet you can paste into your CLI script(s) to obtain "commands + options" DSL without
external dependencies.

[![Build](https://travis-ci.org/kolotaev/argsy.svg?branch=master)](https://travis-ci.org/kolotaev/argsy)
[![Gem Version](https://badge.fury.io/rb/argsy.svg)](https://badge.fury.io/rb/argsy)
[![License](https://upload.wikimedia.org/wikipedia/commons/e/ee/Unlicense_Blue_Badge.svg)](https://raw.githubusercontent.com/kolotaev/argsy/master/LICENSE.txt)

## Rationale

As you already know, Ruby is awesome for scripting and any sort of CLI tools: it gives you a superb OS commands 
interaction interface, JSON/YAML parsing, HTTP tools, etc... All out of the box! But built-in `OptionParser` doesn't
provide easy-to-write functionality to create CLIs like `./script command --option 1`. The problem here is: how to
declare command, action and options conveniently?

> Sometimes, for any imaginable reason, you do not want you script to be dependent on external gems (say, you want to
> pass a script that "just works!" to your co-workers without telling them "Hey, you also need to install this or that 
> gem")

`Argsy` gives you such possibility. It's [just 17 lines of code](lib/argsy.rb), published under `The Unlicense`, 
so you can just copy-paste it inside your script and have a nice 
tiny DSL. You can of course use it as a gem as well, if you want to.

**Disclaimer**: `Argsy` doesn't claim itself as a profound CLI DSL like `Thor` and the company, 
thus for complex scripts, please, opt for those gems instead.

## Usage

```ruby
Argsy.new '1.0.0' do
  command :list, 'List all files' do
    action do |o|
      puts %w(. .. .hidden.py).join("\n") if o[:all]
      puts %w(todos.txt recipes.doc).join("\n")
      puts "me.#{o[:extension]}" if o[:extension]
    end
    options do
      on '-a', '--all', 'Show all, even hidden files'
      on '-e', '--extension EXTENSION', 'List available files with extension'
    end
  end
  
  command 'print', 'Print all given options' do
    action &method(:puts)
    options do
      on '-a', '--A', 'A option'
      on '-b', 'B option'
    end
  end
  
  command 'hello:world', 'Greet the World group without options' do
    action { puts 'Hello world!' }
  end
  
  command :post do |c|
    action do |opts|
      puts "I'm a command without description"
      puts "Posting to facebook: #{opts[:message]}" if opts[:facebook]
      puts "Posting to twitter: You're Tearing Me Apart, Lisa!" if opts[:twitter]
      puts "Date and time posted: #{opts[:date]}"
    end
    options do
      require 'optparse/time'
      on_tail '-d', '--date=DATE', Time, 'Date when message was posted'
      on '-f', '--facebook' do
        c.opts[:message] = 'Oh, Hi Mark'
      end
      on '-t', '--twitter'
    end
  end
end.run
```

In console:
```
$ ./example
Usage: playground CMD [--help] [--version]
    list                             List all files
    print                            Print all given options
    hello                            Greet the World without options
    post                             

$ ./example post --help
Usage: playground post [options] [--help]
    -f, --facebook
    -t, --twitter
    -d, --date=DATE                  Date when message was posted

$ ./example post -f -d 12-8-2016
I'm a command without description
Posting to facebook: Oh, Hi Mark
Date and time posted: 2016-08-12 00:00:00 +0300


$ ./example post --version
example version 1.0.0
```

## FAQ

| Q:       | A:          |
| ------------- |-------------|
| Does it support groups/subcommands?      | Only in a way of declaring commands as `'group:subcommand'`      |
| What can I do inside options block?      | Anything that is possible inside a stdlib's `OptionParser`      |
| Why not Thor, Commander, etc.?     | See rationale |
| Can I use it as a gem?    | Yes. `gem install argsy` |
| Why does it look like a minified jQuery?      | Yes, it's not an idiomatic Ruby formatting. I wanted to make it terse, still readable |
| Copy-pasting is bad. It's not DRY!      | Absolutely agree with you |

## License
The Unlicense
