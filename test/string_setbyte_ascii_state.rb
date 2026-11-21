# String#setbyte keeps what a scan proved (all bytes ASCII, the character
# count) for a byte below 0x80 and forgets it for another byte.
s = +"abcdef"
p s.length, s.ascii_only?
s.setbyte(1, 0x41)
p s, s.length, s.ascii_only?
s.setbyte(1, 0xC3)
s.setbyte(2, 0xA9)
p s, s.length, s.ascii_only?, s.valid_encoding?
s.setbyte(1, 0x62)
p s.length, s.ascii_only?, s.valid_encoding?
s.setbyte(2, 0x63)
p s, s.length, s.ascii_only?
b = "abc".b
p b.length
b.setbyte(0, 0xff)
p b.length, b.ascii_only?, b.bytes
b.setbyte(-1, 0x7a)
p b.bytes
