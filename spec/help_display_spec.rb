require_relative 'test_helper'

describe 'Argsy main help functionality' do
  describe 'shows help if' do
    let :argsy do
      Argsy.new do
        command :list, 'List all files' do
          action { puts 42 }
        end
      end
    end
    let :expected_out do
      stdout = <<-EOX
Usage: rake_test_loader CMD [--help] [--version]
    list                             List all files

EOX
      stderr = ''
      [stdout, stderr]
    end
    it 'zero commands are passed' do
      assert_output(*expected_out) do
        with_captured_exit { argsy.run! %w[] }
      end
    end
    it 'unknown command is passed' do
      assert_output(*expected_out) do
        with_captured_exit { argsy.run! %w[unknown] }
      end
    end
    it 'several unknown command are passed' do
      assert_output(*expected_out) do
        with_captured_exit { argsy.run! %w[unknown unknown2] }
      end
    end
    it '--help option is passed' do
      assert_output(*expected_out) do
        with_captured_exit { argsy.run! %w[--help] }
      end
    end
    it 'unknown option is passed' do
      assert_output(*expected_out) do
        with_captured_exit { argsy.run! %w[--unknown] }
      end
    end
  end

  describe 'shows only banner if ' do
    it 'no commands are listed' do
      argsy = Argsy.new {}
      stdout = <<-EOX
Usage: rake_test_loader CMD [--help] [--version]

EOX
      assert_output stdout, '' do
        with_captured_exit { argsy.run! %w[--help] }
      end
    end
  end

  describe 'lists all commands available' do
    it 'no commands are listed' do
      argsy = Argsy.new do
        command :list, 'List all files' do
          action { puts 42 }
        end
        command 'put', 'Put file' do
          action { puts 84 }
        end
        command 'show-hidden', 'Display only hidden files' do
          action { puts 84 }
        end
      end
      stdout = <<-EOX
Usage: rake_test_loader CMD [--help] [--version]
    list                             List all files
    put                              Put file
    show-hidden                      Display only hidden files

EOX
      assert_output stdout, '' do
        with_captured_exit { argsy.run! %w[--help] }
      end
    end
  end
end


describe 'Argsy commands help functionality' do
  describe 'shows help if' do
    it 'no help option specifed for command' do
      argsy = Argsy.new do
        command :list, 'List all files' do
          action { puts 42 }
          options do
            on('-i', '--hidden', 'Show hidden files?') { |o| opts[:detached] = o }
            on('-e', '--ext EXTENSION', 'List available files with extension') { |o| opts[:extension] = o }
          end
        end
      end
      stdout = <<-EOX
Usage: rake_test_loader list [options] [--help]
    -i, --hidden                     Show hidden files?
    -e, --ext EXTENSION              List available files with extension

EOX
      assert_output stdout, '' do
        with_captured_exit { argsy.run! %w[list --help] }
      end
    end
  end
end