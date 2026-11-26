# A send of a run-time name that forwards `&block` reaches a builtin's
# method whether or not a block is given: with no block, the arm calls the
# builtin without one. The arm of a route that serves a literal block
# raised NoMethodError for a forwarded nil block.
def fwd(obj, name, &block) = obj.__send__(name, &block)
p fwd("b", :upcase)
p fwd([3, 1], :sort)
p fwd([3, 1], :map) { |x| x * 2 }
p fwd(1..4, :select) { |x| x.even? }
p fwd({a: 1}, :keys)

class Fw
  def initialize(blk) = @blk = blk
  def go(obj, name) = obj.__send__(name, &@blk)
end
p Fw.new(nil).go([3, 1], :sort)
p Fw.new(proc { |x| x * 3 }).go([3, 1], :map)
p Fw.new(proc { |x| x.odd? }).go([1, 2, 3], :count)
p Fw.new(nil).go([1, 2, 3], :count)
p Fw.new(nil).go([1, 3, 2], :sort)

[:sort, :reverse, :first].each { |n| p fwd([5, 4, 6], n) }

def anon(obj, name, &) = obj.__send__(name, &)
p anon([3, 1], :sort)
