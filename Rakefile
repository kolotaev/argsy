require 'rake/testtask'
require 'bundler'
Bundler::GemHelper.install_tasks

task default: :test

Rake::TestTask.new do |t|
  t.test_files = FileList[ "spec/**/*_spec.rb"]
  t.verbose = true
  t.options = "-p"
end
