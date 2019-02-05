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

  def test_help_call
    argsy = Argsy.new do |a|
      a.command :list, 'foo bar' do |c|
        c.action do |opts|
          puts 42
        end
        c.options do |op|
          op.on('-i', '--hidden', 'Show hidden files?') { |o| c.opts[:detached] = o }
          op.on('-e', '--ext EXTENSION', 'List available files with extension') { |o| c.opts[:extension] = o }
          # op.on('-h', '--help', 'hjjjh') { puts op }
        end
      end
    end
    exp = <<-EOX
Usage: rake_test_loader list [options]
    -i, --hidden                     Show hidden files?
    -e, --ext EXTENSION              List available files with extension

EOX
    assert_output exp do
      begin
        argsy.run! %w[list --help]
      rescue SystemExit => e
        puts e.to_s.gsub(/\s*exit\s*$/, '')
      end
    end
  end
end
