# is_a?, kind_of?, === and case/when on an instance of a class that includes
# IO::WaitReadable or IO::WaitWritable by path, directly or through a module.
class P; include IO::WaitReadable; end
x = P.new
p x.is_a?(IO::WaitReadable)
p x.kind_of?(IO::WaitReadable)
p IO::WaitReadable === x
p [x, 1].map { |v| v.is_a?(IO::WaitReadable) }
case x
when IO::WaitReadable then p :yes
else p :no
end
class Q; include Math; end
p Q.new.is_a?(Math)
class R; include Comparable; def <=>(o) = 0; end
p R.new.is_a?(Comparable)
class Sub < P; end
module Wrap; include IO::WaitWritable; end
class W; include Wrap; end
class Base; end
class Kid < Base; include IO::WaitReadable; end
class Plain; end
p Sub.new.is_a?(IO::WaitReadable)
p W.new.is_a?(IO::WaitWritable)
p W.new.is_a?(IO::WaitReadable)
p IO::WaitWritable === W.new
b = [Base.new, Kid.new].map { |o| o.is_a?(IO::WaitReadable) }
p b
def check(o) = o.is_a?(IO::WaitReadable)
p check(Kid.new)
p check(Base.new)
p Plain.new.is_a?(IO::WaitReadable)
x = [Base.new, Kid.new][1]
p x.is_a?(IO::WaitReadable)
y = [Base.new, Kid.new][0]
p y.is_a?(IO::WaitReadable)
n = [P.new, nil][1]
p n.is_a?(IO::WaitReadable)
[Kid.new, Base.new, 3].each do |v|
  case v
  when IO::WaitReadable then p :r
  else p :other
  end
end
