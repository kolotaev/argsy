class Argsy
  require 'optparse'
  class Command
    attr_reader :do_it, :opts, :op, :desc
    def initialize(desc) @desc, @op, @opts = desc, OptionParser.new, {} end
    def options() @op = yield OptionParser.new end
    def action(&block) @do_it = block end
  end
  def initialize() @commands = {}; yield self end
  def command(name, desc) c = Command.new(desc); @commands[name.to_s] = c; yield c end
  def run!(a=ARGV) c = @commands[a[0]]; c.op.parse; c.do_it.call(c.opts) end
  def help() puts "" end
end
