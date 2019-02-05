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
