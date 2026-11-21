# spinel: int64
# A Bignum-typed value small enough for a machine word, read back out of a
# poly slot, grows into a Bignum under + - * ** and << as the Bignum-typed
# arithmetic does. The box used to hold a plain Integer, so `x * x * x`
# raised RangeError in the default mode.
class Node
  attr_reader :children

  def initialize(children)
    @children = children
  end
end

def cube(x)
  x * x * x
end

big = 340282366920938463463374607431768211456
small = big - big + 3_000_000_000
x = Node.new([small, "pad"]).children[0]
p cube(small)
p cube(x)
p x * 4_000_000_000 * 4_000_000_000
p 4_000_000_000 * x * 4_000_000_000
p x + 9_223_372_036_854_775_000 + 9_223_372_036_854_775_000
p x - 9_223_372_036_854_775_000 - 9_223_372_036_854_775_000
p x ** 3
p x.pow(3)
p x << 40
p x >> 3
z = x * 2
p z, z * z * z
p x == 3_000_000_000, x.eql?(3_000_000_000), x.equal?(3_000_000_000)
p({ 3_000_000_000 => :found }[x])
p({ x => :found, "k" => 1 }[3_000_000_000])
