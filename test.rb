require 'optparse'
require_relative "./argsy"

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
# end.parse!(into: opts)


# puts opts

argsy = Argsy.new '4.8.0' do |a|
    a.command 'list-all', "List all files" do |c|
        c.options do |op|
            op.on("-x", "--hidden", "Show hidden files?")
            op.on("-e", "--extension EXTENSION", "List available files with extension")
        end
        c.action { |o| puts o }
    end
    a.command :post, "Post data to twitter" do |c|
        c.action do |opts|
            $actual = opts
        end
        c.options do |op|
            op.on("-d", "--data DATA", "All data")
        end
    end
end.run!
