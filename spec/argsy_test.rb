require "test/unit"
require_relative "../argsy"
require_relative "test_helper"
 

class TestOneCommand < Test::Unit::TestCase

  def test_no_options
    $actual = {}
    argsy = Argsy.new do |a|
      a.command :list, "foo bar" do |c|
        c.action do |opts|
          $actual = opts
        end
      end
    end
    argsy.run! %w[list]
    assert_equal({}, $actual)
    assert_raise OptionParser::InvalidOption do
        argsy.run! %w[list -f -v]
    end
  end

  def test_has_options
    $actual = {}
    argsy = Argsy.new do |a|
      a.command :list, "foo bar" do |c|
        c.action do |opts|
          $actual = opts
        end
        c.options do |op|
          op.on("-x", "--hidden", "Show hidden files?") { |o| c.opts[:detached] = o }
          op.on("-e", "--ext EXTENSION", "List available files with extension") { |o| c.opts[:extension] = o }
        end
      end
    end
    argsy.run! %w[list -x]
    assert_equal({detached: true}, $actual)
    assert_raise OptionParser::MissingArgument do
        argsy.run! %w[list -x -e]
    end
    argsy.run! %w[list -x -e txt]
    assert_equal({detached: true, extension: 'txt'}, $actual)
  end

  def test_help
    argsy = Argsy.new do |a|
      a.command :list, "foo bar" do |c|
        c.action do |opts|
          puts 42
        end
        c.options do |op|
          op.on("-x", "--hidden", "Show hidden files?") { |o| c.opts[:detached] = o }
          op.on("-e", "--ext EXTENSION", "List available files with extension") { |o| c.opts[:extension] = o }
        end
      end
    end
    output = capture_stdout do
      argsy.run! %w[list -h]
    end
    
    assert_equal('ooo', output)
  end

end
