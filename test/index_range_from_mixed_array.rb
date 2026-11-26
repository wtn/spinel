# A Range read from a mixed Array indexes a String as a span: the class
# facts of the index say it may be a Range.
positions = [0, 1..2, 1...3, 2.., ..2, ...2, /l+/, "ell", -1, 9]
positions.each { |pos| p "hello"[pos] }

def at(s, pos) = s[pos]
p at("hello", 1..3)
p at("hello", 4)
r = (..2)
p "hello"[r]
