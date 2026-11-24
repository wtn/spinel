# A method that forwards `*a, **k, &b` to the method of its own name on
# another object: an empty `**k` passes nothing, also to a builtin.
class A
  def as_json = {a: 1}
  def to_s(*a, **k, &b) = as_json.to_s(*a, **k, &b)
end
puts A.new.to_s

class Wrap
  def initialize(x) = @x = x
  def first(*a, **k) = @x.first(*a, **k)
  def each(*a, **k, &b) = @x.each(*a, **k, &b)
  def sum(*a, **k, &b) = @x.sum(*a, **k, &b)
end
w = Wrap.new([3, 4, 5])
p w.first, w.first(2)
w.each { |v| print v, " " }
puts
p w.each.class, w.each.to_a
p w.sum { |v| v * 2 }, w.sum, w.sum(10)

class Rec
  def first(*a, **k) = [a, k]
end
class RecWrap
  def initialize = @x = Rec.new
  def first(*a, **k) = @x.first(*a, **k)
end
p RecWrap.new.first(1, z: 2), RecWrap.new.first
