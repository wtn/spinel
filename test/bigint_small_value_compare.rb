# spinel: int64
# A Bignum slot holding a small Integer compares equal to that Integer
# `case five when 5` compared the Bignum's pointer with 5 and took the else
# arm, Array#count and #delete and Hash#value? decided at compile time that
# no element equals a Bignum, and eql? / equal? were refused.
big = 2**64
five = big - big + 5

# case / when, either side a Bignum
case five when 5 then p :hit else p :miss end
case five when 1, 5 then p :hit else p :miss end
case 5 when five then p :hit else p :miss end
case five when 5.0 then p :hit else p :miss end
case five when 6, "5", nil then p :hit else p :miss end
case big when 5 then p :hit else p :miss end
case 5 when big then p :hit else p :miss end
def kind(v) = case v when 5 then :five when 2**64 then :big else :other end
p kind(5), kind(2**64), kind(6)

# typed Array searches
p [5, 1, 5].count(five), [5, 1].count(big), [5.0, 1.0].count(five), [5.5].count(five)
p [5, 1].any?(five), [5, 5].all?(five), [5, 1].none?(five), [5, 1].one?(five)
a = [5, 1]
p a.delete(five), a.delete(big), a
f = [5.0, 1.0]
p f.delete(five), f.delete(big), f
g = [5, 1]
p g.delete(five) { :none }, g.delete(big) { :none }, g

# Hash#value?
p({1 => 5}.value?(five), {1 => 5}.value?(big), {"a" => 5.0}.value?(five), {"a" => 5.5}.value?(five))

# eql? and equal?
p five.eql?(5), five.eql?(6), five.eql?(5.0), five.eql?("5"), five.eql?(nil), big.eql?(2**64)
p five.equal?(5), five.equal?(6), big.equal?(big), big.equal?(5)
n = 5
p n.eql?(five), n.equal?(five), n.eql?(big)
def same(a, b) = a.eql?(b)
p same(5, 5), same(5, 2**64 - 2**64 + 5), same(5, "s")
