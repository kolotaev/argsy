require_relative "../argsy"
require "test/unit"
 
class TestOneCommand < Test::Unit::TestCase

  def test_no_options
    actual = {}
    argsy = Argsy.new do |a|
      a.command :list, "foo bar" do |c|
        c.action do |opts|
          $actual = opts
        end
      end
    end
    argsy.run! %w[list]
    assert_equal({}, actual)
    argsy.run! %w[list -f -v]
    assert_equal({}, actual)
  end

  def test_has_options
    actual = {}
    argsy = Argsy.new do |a|
      a.command :list, "foo bar" do |c|
        c.action do |opts|
          $actual = opts
        end
        c.options do |op|
          op.on("-d", "--detached", "List available docker-composes") { |o| c.opts[:detached] = o }
          op.on("-e", "--ext [EXTENSION]", "List available docker-composes") { |o| c.opts[:extension] = o }
        end
      end
    end
    argsy.run! %w[list]
    assert_equal({}, actual)
  end

end
