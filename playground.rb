require_relative "lib/argsy"

# require 'optparse'
# opts = {}
# OptionParser.new do |opts|
#     opts.banner = "Usage: example.rb [options]"
#     opts.on("-nNAME", "--name=NAME", "Name to say hello to hjgjhgg jhg jg jhg jhgjhg jhg g jhg jjgjjjjjgjhjg j gjgj jg jg jg jhjgjhgjhgjhgj jhg")
#     opts.on("-nNAME", "--name=NAME", "Name to say hello to hjgjhgg jhg jg jhg jhgjhg jhg g jhg jjgjjjjjgjhjg j gjgj jg jg jg jhjgjhgjhgjhgj jhg")
#     opts.on("-h", "--help", "Prints this help") do
#       puts opts
#       exit
#     end
#     opts.on("-foo", "-foohjhgjhhjnhhghjgjhgghgfhgfhgfhgfg [IOIOIOI]", "Name to say hello to") do
#         puts 12
#     end
# end.parse!
# puts opts

$actual = 0
argsy = Argsy.new do
  command :list, 'List all files' do
    action { $actual = 88 }
    options { on('-e', '--extension EXTENSION', 'List available files with extension') }
  end
  command :post, 'Post to twitter' do
    action { $actual = 99 }
    options { on('-e', '--extension EXTENSION', 'List available files with extension') }
  end
end.run!
puts $actual


# require 'optparse'
# opts = {}
# OptionParser.new do |op|
#     op.banner = "Usage: example.rb [options]"
#     op.on('-a', '--all', 'Show all, even hidden files?') 
#     op.on('-e', '--extension EXTENSION', 'List available files with extension') { |o| opts[:custom_all] = 'my val' }
#     op.on("-foo", "--foo [IOIOIOI]", "Name to say hello to") do
#         puts 12
#     end
# end.parse!(into: opts)
# puts opts