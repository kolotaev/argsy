require_relative 'test_helper'

class TestOneCommand2 < Minitest::Test

  def test_no_options
    $actual = {}
    argsy = Argsy.new do |a|
      a.command :list, 'foo bar' do |c|
        c.action do |opts|
          $actual = opts
        end
      end
    end
    argsy.run! %w[list]
    assert_equal({}, $actual)
    assert_raises OptionParser::InvalidOption do
        argsy.run! %w[list -f -v]
    end
  end

  def test_has_options
    $actual = {}
    argsy = Argsy.new do |a|
      a.command :list, 'List all files' do |c|
        c.action do |opts|
          $actual = opts
        end
        c.options do |op|
          op.on('-x', '--hidden', 'Show hidden files?')
          op.on('-e', '--extension EXTENSION', 'List available files with extension')
        end
      end
    end
    argsy.run! %w[list -x]
    assert_equal({hidden: true}, $actual)
    assert_raises OptionParser::MissingArgument do
      argsy.run! %w[list -x -e]
    end
    argsy.run! %w[list -x -e txt]
    assert_equal({hidden: true, extension: 'txt'}, $actual)
  end
end
