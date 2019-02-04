require_relative "../argsy"
require "test/unit"
 
class TestArgsy < Test::Unit::TestCase

  def test_one_command
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
