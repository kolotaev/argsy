class Argsy
  require 'optparse'
  class Command
    attr_reader :do_it, :opts, :op, :desc
    def initialize(name, desc) @name, @desc, @op, @opts = name, desc, OptionParser.new, {} end
    def options() @op = yield OptionParser.new; @op.banner = "Usage: #{@op.program_name} #{@name} [options]" end
    def action(&block) @do_it = block end
  end
  def initialize() @commands = {}; yield self end
  def command(name, desc) c = Command.new(name, desc); @commands[name.to_s] = c; yield c end
  def run!(a=ARGV)
    (puts "foo"; exit) if a.empty? || a == ['-h']
    c = @commands[a[0]]
    c.op.parse!(a)
    c.do_it.call(c.opts)
  end
end
