# minmax_scan - a running minimum and maximum, `lo = v if v < lo`
#
# Each bound is written on one arm of a branch and kept on the other.
# Measures that the two arms join as an Integer and the scan stays on
# machine words.

def minmax_scan(a)
  lo = a[0]
  hi = a[0]
  i = 1
  n = a.length
  while i < n
    v = a[i]
    lo = v if v < lo
    hi = v if v > hi
    i += 1
  end
  hi - lo
end

n = 100_000
a = Array.new(n) { |i| (i * 7919 + 17) % 1_000_003 }
total = 0
r = 0
while r < 500
  a[r] = r - 250
  total += minmax_scan(a)
  r += 1
end
p total
