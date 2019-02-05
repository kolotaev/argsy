require_relative 'test_helper'

class TestOneCommand2 < Minitest::Test

  def test_no_options
    $actual = {}
    argsy = Argsy.new do
      command :list, 'foo bar' do
        action do |opts|
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
    argsy = Argsy.new do
      command :list, 'List all files' do
        action do |opts|
          $actual = opts
        end
        options do
          on('-x', '--hidden', 'Show hidden files?')
          on('-e', '--extension EXTENSION', 'List available files with extension')
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
