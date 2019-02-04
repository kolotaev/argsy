def capture_stdout(&block)  
  begin
    stdout_orig = $stdout
    stdout_mock = StringIO.new
    $stdout = stdout_mock
    block.call
  ensure
    $stdout = stdout_orig
  end
  stdout_mock.string
end
