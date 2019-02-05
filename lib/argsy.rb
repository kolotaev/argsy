class Argsy
  require 'optparse'
  class Command
    attr_reader :name, :desc, :do_it, :op, :opts
    def initialize(name, desc) @name, @desc, @op, @opts = name.to_s, desc, OptionParser.new, {} end
    def options() @op.banner = "Usage: #{File.basename($0, '.*')} #{@name} [options] [--help]"; yield @op end
    def action(&block) @do_it = block end
    def to_s() ' ' * 4 + @name + ' ' * (33 - @name.length).abs + @desc end
  end
  def initialize(ver='0.0.1'); @name = File.basename($0, '.*'); @ver = ver; @cmds = {}; yield self end
  def command(name, desc='') c = Command.new(name.to_s, desc); @cmds[c.name] = c; yield c end
  def run!(a=ARGV)
    (puts "#{@name} version #{@ver}"; exit) if a == ['--version']
    (puts "Usage: #{@name} CMD [--help] [--version]\n" + @cmds.values.map(&:to_s).join("\n"); exit) if !@cmds.key?(a[0])
    c = @cmds[a[0]]; c.op.parse(a, into: c.opts); c.do_it.call(c.opts)
  end
end
