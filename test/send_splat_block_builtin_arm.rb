# A send of a run-time name with a splat and a forwarded block compiles: a
# builtin's arm, which took the splat array as one argument and wrote C
# that did not compile, is left out (the name raises NoMethodError, so the
# call below is compiled, not run). A method of the program keeps its arm.
class Box
  def pair(a, b) = [a, b, block_given?]
end
def g(t, m, *args, &block) = t.__send__(m, *args, &block)
x = [%w[a b], "s"][0]
p g(x, :join, "-") if ARGV.size > 5
p g(Box.new, :pair, 1, 2)
p g(Box.new, :pair, 1, 2) { }
