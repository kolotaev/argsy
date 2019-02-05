require_relative "lib/argsy"

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

Argsy.new do
  command :post, 'Post all files' do
    options do
      on_tail("-x", "--extract", "Extract files?")
      on("-e", "--extension EXTENSION", "List available files with extension")
    end
    action { |o| p 909; p o }
  end
    # a.command :post, "Post data to twitter" do |c|
    #     c.action do |opts|
    #         $actual = opts
    #     end
    #     c.options do
    #         on("-d", "--data DATA", "All data")
    #     end
    # end
end.run!

