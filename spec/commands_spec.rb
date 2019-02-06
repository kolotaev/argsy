require_relative 'test_helper'

describe 'Argsy commands functionality' do

  describe 'allows passing several commands, but only the first is fired' do
    let :argsy do
      $actual = 0
      $opts = {}
      Argsy.new do
        command :list, 'List all files' do
          action { |opts| $actual = 88; $opts = opts }
          options { on('-e', '--extension EXTENSION', 'List available files with extension') }
        end
        command :post, 'Post to twitter' do
          action { |opts| $actual = 99; $opts = opts.merge({foo: 'bar'}) }
          options { on('-e', '--extension EXTENSION', 'List available files with extension') }
        end
     end
    end
    it 'when second command is given' do
      argsy.run! %w[post list]
      assert_equal(99, $actual)
    end
    it 'when first command is given' do
        argsy.run! %w[list post]
        assert_equal(88, $actual)
    end
    it 'when more duplicate first command is given' do
      argsy.run! %w[list list]
      assert_equal(88, $actual)
    end
    it 'when options are given to a second wrong command' do
      argsy.run! %w[list post -e txt]
      assert_equal({:extension=>"txt"}, $opts)
    end
    it 'when options are given and later some otions are passed they go the first command' do
      argsy.run! %w[list -e txt post]
      assert_equal({:extension=>"txt"}, $opts)
    end
    it 'when options are given to a first wrong command (swap example)' do
      argsy.run! %w[post list -e txt]
    assert_equal({:extension=>"txt", :foo=>"bar"}, $opts)
    end
  end

  describe 'allows group commands via ":"' do
    let :argsy do
      $actual = 0
      Argsy.new do
        command 'files:list' do
          action {  $actual = 1 }
        end
        command 'http:post' do
          action {  $actual = 2 }
        end
      end
    end
    it 'when called with 2nd group' do
      argsy.run! %w[http:post]
      assert_equal(2, $actual)
    end
    it 'when called with 2nd group' do
      argsy.run! %w[files:list]
      assert_equal(1, $actual)
    end
    it 'when called with only group' do
      with_silent_exit { argsy.run! %w[files] }
      assert_equal(0, $actual)
      with_silent_exit { argsy.run! %w[files:] }
      assert_equal(0, $actual)
      with_silent_exit { argsy.run! %w[http:] }
      assert_equal(0, $actual)
    end
  end

end
