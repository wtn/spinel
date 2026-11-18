# str_hash - a multiplicative String hash, `h = (h * 33 + c) & 0xffffffff`
#
# The mask bounds `h` on each step, so the multiply cannot pass an Integer
# slot. Measures that `h` stays a machine word through the multiply, add
# and mask.

def str_hash(s)
  h = 5381
  i = 0
  len = s.bytesize
  while i < len
    h = (h * 33 + s.getbyte(i)) & 0xffffffff
    i += 1
  end
  h
end

words = ["alpha", "beta", "gamma", "delta", "epsilon", "zeta", "eta", "theta"]
acc = 0
k = 0
while k < 20_000_000
  acc = (acc + str_hash(words[k & 7])) & 0xffffffff
  k += 1
end
p acc
