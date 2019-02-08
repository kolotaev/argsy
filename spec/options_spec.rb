require_relative 'test_helper'

describe 'Argsy options functionality' do
  
  it 'raises error when invalid options given to script an does not run action' do
    $actual = 0
    argsy = Argsy.new do
      command :list, 'foo bar' do
        action { $actual = 90 }
      end
    end
    assert_raises OptionParser::InvalidOption do
      argsy.run %w[list -f -v]
    end
    assert_equal(0, $actual)
  end
  
  it 'runs action when no options given to a script that does not require any options' do
    $actual = 0
    argsy = Argsy.new do
      command :list, 'foo bar' do
        action { $actual = 90 }
      end
    end
    argsy.run %w[list]
    assert_equal(90, $actual)
  end

  describe 'passes all given options to action' do
    let :argsy do
      $actual = {}
      Argsy.new do
        command :list, 'List all files' do
          action do |opts|
            $actual = opts
          end
          options do
            on('-a', '--all', 'Show all, even hidden files?')
            on('-e', '--extension EXTENSION', 'List available files with extension')
          end
        end
      end
    end
    it 'when no options given' do
      argsy.run %w[list]
      assert_equal({}, $actual)
    end
    it 'when one option given' do
      argsy.run %w[list -a]
      assert_equal({all: true}, $actual)
    end
    it 'when one option with argument given' do
      argsy.run %w[list -e rb]
      assert_equal({extension: 'rb'}, $actual)
    end
    it 'when all options given' do
      argsy.run %w[list -a -e txt]
      assert_equal({all: true, extension: 'txt'}, $actual)
    end
    it 'when all fully-qualified options given' do
      argsy.run %w[list --all --extension py]
      assert_equal({all: true, extension: 'py'}, $actual)
    end
  end

  it 'raises error when required option argument is missing and does not run action' do
    $actual = 0
    argsy = Argsy.new do
      command :list, 'List all files' do
        action do |opts|
          $actual = 88
        end
        options do
          on('-a', '--all', 'Show all, even hidden files?')
          on('-e', '--extension EXTENSION', 'List available files with extension')
        end
      end
    end
    assert_raises OptionParser::MissingArgument do
      argsy.run %w[list -a -e]
    end
    assert_equal(0, $actual)
  end

  it 'allows to specify block for options handling' do
    $actual = {}
    argsy = Argsy.new do
      command :list, 'List all files' do |c|
        action do |opts|
          $actual = opts
        end
        options do
          on('-a', '--all', 'Show all, even hidden files?') { |o| c.opts[:custom_all] = 'my val'; true }
          on('-e', '--extension EXTENSION', 'List available files with extension')
        end
      end
    end
    argsy.run %w[list -a]
    assert_equal({:custom_all=>"my val", :all=>true}, $actual)
  end

end
