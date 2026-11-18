# spinel: int64
# A loop local rebuilt as `n = n * k + d` grows as `n = n * k` does
# The loop-growth scan read only the outermost call of the write, so the
# multiplication under a `+` or `-` was not seen: the local stayed an Integer
# and the multiply raised RangeError where CRuby answers the Bignum.
def bytes_to_i(s)
  n = 0
  i = 0
  while i < s.bytesize
    n = n * 256 + s.getbyte(i)
    i += 1
  end
  n
end
p bytes_to_i("\x01" * 12)
p bytes_to_i("\x7f")

def digits_to_i(ds)
  n = 0
  i = 0
  while i < ds.size
    n = ds[i] + n * 10
    i += 1
  end
  n
end
p digits_to_i([9] * 30)

def countdown(k)
  n = 1
  i = 0
  while i < k
    n = (n * 1000) - i
    i += 1
  end
  n
end
p countdown(9)

def ascii_to_i(s)
  n = 0
  i = 0
  while i < s.bytesize
    n = n * 10 + s.getbyte(i) - 48
    i += 1
  end
  n
end
p ascii_to_i("123456789012345678901234567890")

def offset_sum(k)
  n = 3
  i = 0
  while i < k
    n = 1 + (n * 1000 + i)
    i += 1
  end
  n
end
p offset_sum(8)

# a heap index is no accumulator: `l` is rebuilt from a copy, and stays small
def sift_steps(size)
  i = 0
  steps = 0
  while true
    l = 2 * i + 1
    break if l >= size
    i = l
    steps += 1
  end
  steps
end
p sift_steps(1000)

# the promoted local still answers Integer#chr
def hex_char(s)
  cp = 0
  i = 0
  while i < s.bytesize
    cp = cp * 16 + s.getbyte(i) - 48
    i += 1
  end
  cp.chr
end
p hex_char("41")
begin
  hex_char("1" * 20)
rescue RangeError => e
  p e.message
end
