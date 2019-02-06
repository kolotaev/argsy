require "minitest/autorun"
require "minitest/spec"
require_relative "../lib/argsy"

def with_captured_exit(&block)
  begin
    yield block
  rescue SystemExit => e
    puts e.to_s.gsub(/exit\s*$/, '')
  end
end

def with_silent_exit(&block)
  stdout_orig = $stdout
  $stdout = StringIO.new
  begin
    yield block
  ensure
    $stdout = stdout_orig
  end
end
