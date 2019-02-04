require 'minitest/autorun'
require_relative "../argsy"
 

class TestOneCommand < Minitest::Test

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
    assert_raises OptionParser::InvalidOption do
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
    assert_raises OptionParser::MissingArgument do
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
          op.on("-h") { puts op }
        end
      end
    end

    assert_output "42\n" do
      argsy.run! %w[list -h]
    end
  end

  def test_generic_help
    argsy = Argsy.new do |a|
      a.command :list, "foo bar" do |c|
        c.action { puts 42 }
      end
    end

    assert_output 'tthhj', 'jj' do
      argsy.run! %w[list -h]
    end
  end

end

    # argsy = Argsy.new do |a|
    #   a.command :list, "foo bar" do |c|
    #     c.action { |opts| puts opts }
    #     c.options do |op|
    #       op.on('foo') { |o| c.opts[:foo] = o }
    #       # op.on("-x", "--hidden", "Show hidden files?") { |o| c.opts[:detached] = o }
    #       # op.on("-e", "--ext EXTENSION", "List available files with extension") { |o| c.opts[:extension] = o }
    #     end
    #   end
    # end

    # argsy.run! %w[list]
