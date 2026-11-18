# parse_digits - decimal digits into an Integer, `n = n * 10 + c - 48`
#
# The inner step of every hand-written number parser. The values here fit
# an Integer slot with room to spare; measures that `n` stays a machine
# word through the multiply and add.

def parse_digits(s)
  n = 0
  i = 0
  len = s.bytesize
  while i < len
    n = n * 10 + s.getbyte(i) - 48
    i += 1
  end
  n
end

strs = ["12345", "987", "4096", "31337", "7", "100200300", "65535", "42"]
sum = 0
k = 0
while k < 20_000_000
  sum += parse_digits(strs[k & 7])
  k += 1
end
p sum
