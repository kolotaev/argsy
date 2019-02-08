require_relative 'test_helper'

describe 'Example' do

  let :argsy do
    Argsy.new do
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
    end
  end

  it 'list' do
    stdout = <<-EOX
todos.txt
recipes.doc
EOX
    assert_output stdout, '' do
      with_captured_exit { argsy.run %w[list] }
    end
  end

  it 'list -a -e rb' do
    stdout = <<-EOX
.
..
.hidden.py
todos.txt
recipes.doc
me.rb
EOX
    assert_output stdout, '' do
      with_captured_exit { argsy.run %w[list -a -e rb] }
    end
  end

  it 'print -ab' do
    stdout = <<-EOX
{:A=>true, :b=>true}
EOX
    assert_output stdout, '' do
      with_captured_exit { argsy.run %w[print -ab] }
    end
  end

  it 'hello:world' do
    stdout = <<-EOX
Hello world!
EOX
    assert_output stdout, '' do
      with_captured_exit { argsy.run %w[hello:world] }
    end
  end

  it 'post' do
    stdout = <<-EOX
I'm a command without description
Posting to twitter: You're Tearing Me Apart, Lisa!
Date and time posted: 2007-02-03 04:05:06 UTC
EOX
    assert_output stdout, '' do
      with_captured_exit { argsy.run %w[post --twitter -d 2007-02-03T04:05:06Z] }
    end
  end

end
