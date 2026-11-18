# bytes_to_int - big-endian bytes into an Integer, `n = n * 256 + b`
#
# How a length, an offset or a small ASN.1 INTEGER is read out of a binary
# String. Up to six bytes, so the values fit an Integer slot; measures
# that `n` stays a machine word through the multiply and add.

def bytes_to_int(s)
  n = 0
  i = 0
  len = s.bytesize
  while i < len
    n = n * 256 + s.getbyte(i)
    i += 1
  end
  n
end

strs = ["\x01", "\x02\x03", "\x7f\xff\xff", "\x00\x10\x00\x00", "\x01\x02\x03\x04\x05", "\xff\xfe\xfd\xfc\xfb\xfa"]
sum = 0
k = 0
while k < 20_000_000
  sum = (sum + bytes_to_int(strs[k % 6])) % 1_000_000_007
  k += 1
end
p sum
