class Argsy
  require 'optparse'
  class Command
    attr_reader :name, :desc, :do_it, :op, :opts
    def initialize(name, desc, &bl) @name, @desc, @op, @opts = name, desc, OptionParser.new, {}; instance_eval(&bl) end
    def options(&bl) @op.banner = "Usage: #{op.program_name} #{@name} [options] [--help]"; @op.instance_eval(&bl) end
    def action(&block) @do_it = block end
    def to_s() ' ' * 4 + @name + ' ' * (33 - @name.length).abs + @desc end
  end
  def initialize(ver='0.0.1', &bl) @name = File.basename($0, '.*'); @ver = ver; @cmds = {}; instance_eval(&bl) end
  def command(name, desc='', &bl) @cmds[name.to_s] = Command.new(name.to_s, desc, &bl) end
  def run!(a=ARGV)
    (puts "#{@name} version #{@ver}"; exit) if a == ['--version']
    (puts "Usage: #{@name} CMD [--help] [--version]\n" + @cmds.values.map(&:to_s).join("\n"); exit) if !@cmds.key?(a[0])
    c = @cmds[a[0]]; c.op.parse(a, into: c.opts); c.do_it.call(c.opts)
  end
end
