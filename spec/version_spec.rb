require_relative 'test_helper'

describe 'Argsy version functionality' do
  
  it 'shows default version if --version option is given' do
    argsy = Argsy.new {}
    stdout = <<-EOX
rake_test_loader version 0.0.1

EOX
    assert_output stdout, '' do
      with_captured_exit { argsy.run! %w[--version] }
    end
  end

  it 'shows custom version if --version option is given' do
    argsy = Argsy.new '5.5.9.patch' do
    end
    stdout = <<-EOX
rake_test_loader version 5.5.9.patch

EOX
    assert_output stdout, '' do
      with_captured_exit { argsy.run! %w[--version] }
    end
  end

  it 'you can specify version for perticular comand via OptionParser' do
    argsy = Argsy.new do
      command :list, 'foo bar' do
        options do |op|
          op.version = '999'
          op.release = 'beta'
        end
      end
    end
    stdout = <<-EOX
rake_test_loader 999 (beta)

EOX
    assert_output stdout, '' do
      with_captured_exit { argsy.run! %w[list --version] }
    end
  end

end