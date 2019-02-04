require_relative "../argsy"
require "test/unit"
 
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
          op.on("-d", "--detached", "List available docker-composes") { |o| c.opts[:detached] = o }
          op.on("-e", "--ext EXTENSION", "List available docker-composes") { |o| c.opts[:extension] = o }
        end
      end
    end
    argsy.run! %w[list -d]
    assert_equal({detached: true}, $actual)
    assert_raise OptionParser::MissingArgument do
        argsy.run! %w[list -d -e]
    end
    argsy.run! %w[list -d -e txt]
    assert_equal({detached: true, extension: 'txt'}, $actual)
  end

end
