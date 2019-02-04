class Argsy
  require 'optparse'
  class Command
    attr_reader :do_it, :opts, :op, :desc, :name
    def initialize(name, desc) @name, @desc, @op, @opts = name.to_s, desc, OptionParser.new, {} end
    def options() @op = yield OptionParser.new; @op.banner = "Usage: #{@op.program_name} #{@name} [options]" end
    def action(&block) @do_it = block end
  end
  def initialize() @cmds = {}; yield self end
  def command(name, desc) c = Command.new(name.to_s, desc); @cmds[c.name] = c; yield c end
  def run!(a=ARGV)
    (puts "Usage: #{File.basename($0, '.*')} [cmd]\n" + help; exit) if a == ['--help'] || !@cmds.key?(a[0])
    c = @cmds[a[0]]; c.op.parse!(a); c.do_it.call(c.opts)
  end
  def help() @cmds.map{ |k,c| ' '*4 + c.name + ' '*7 + c.desc}.join("\n") end
end
