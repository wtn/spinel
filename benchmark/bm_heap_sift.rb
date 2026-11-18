# heap_sift - heapsort's sift-down, `l = 2 * i + 1; i = l`
#
# The index of a binary heap doubles on the way down and is bounded by the
# array's length. Measures that `i` and `l` stay machine words and index
# the Integer array without a box.

def sift_down(a, i, n)
  while true
    l = 2 * i + 1
    break if l >= n
    r = l + 1
    l = r if r < n && a[r] > a[l]
    break if a[i] >= a[l]
    t = a[i]
    a[i] = a[l]
    a[l] = t
    i = l
  end
end

def heapsort(a)
  n = a.length
  i = n / 2 - 1
  while i >= 0
    sift_down(a, i, n)
    i -= 1
  end
  e = n - 1
  while e > 0
    t = a[0]
    a[0] = a[e]
    a[e] = t
    sift_down(a, 0, e)
    e -= 1
  end
  a
end

n = 200_000
check = 0
r = 0
while r < 10
  a = Array.new(n) { |i| (i * 7919 + r * 104_729) % 1_000_003 }
  heapsort(a)
  check += a[0] + a[n / 2] + a[n - 1]
  r += 1
end
p check
