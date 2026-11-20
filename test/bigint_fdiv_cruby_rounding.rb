# spinel: int64
# Integer#to_f, Integer#fdiv and Rational#to_f on Bignums as CRuby computes
# them. to_f rounds once to the nearest double (big2dbl); folding the limbs
# in as doubles rounded twice. A ratio of parts past the Float range divides
# the shifted integers (big_fdiv), where converting each part first gave
# Infinity / Infinity = NaN.

def box(x) = [x, :pad][0]

# to_f near a rounding boundary: a tie goes to the even double, anything
# above it rounds up
p 2**53 + 1, (2**53 + 1).to_f, (2**54 + 2).to_f, (2**54 + 6).to_f
p (2**200 + 2**147).to_f, (2**200 + 2**147 + 1).to_f, (2**200 + 3 * 2**147).to_f
p 197231728795753176794710505450114835361908638922407601520567557925103613352.to_f
p 105021546966451333290002075491861859717215538823819592460814046401.to_f
p 8445153249636658240975672567304261885347780605059706530.to_f
p (-1568838584798866136907767599094026261242116817).to_f
p (2**1024 - 2**970).to_f, (2**1024 - 2**970 - 1).to_f, (2**1024 - 2**969).to_f

# Rational#to_f with parts past the Float range, and arithmetic with a Float
q = Rational(2**2000 + 1, 2**2001)
p q.to_f, q + 0.0, q * 1.5, Rational(10**400, 3 * 10**399).to_f, Rational(-(10**500) - 7, 10**499).to_f
p Rational(7 * 10**330, 10**10).to_f, Rational(1, 3 * 10**400).to_f
p box(q).to_f, box(q) + 0.0, box(1.5) * box(q)

# Integer#fdiv with a Bignum on either side
p (2**2000 + 1).fdiv(2**2001), (10**400).fdiv(3 * 10**399), (10**400).fdiv(7)
p (10**400).fdiv(1e300), (-(10**400)).fdiv(3), (2**100 + 1).fdiv(2**60 + 3)
p box(2**2000 + 1).fdiv(box(2**2001)), box(10**400).fdiv(box(7)), box(10**400).fdiv(box(1e300))

# parts past 53 bits that still fit in 64: the shifted division rounds the
# last digit differently from dividing the two doubles
a = 3538039492203454669
b = 2929308758765857857
p a.fdiv(b), Rational(a, b).to_f, Rational(a, b) + 0.0, box(a).fdiv(box(b)), box(Rational(a, b)).to_f
p 7.fdiv(2), (2**53 + 1).fdiv(3), Rational(1, 3).to_f

# the Fixnum and 53-bit boundaries: -2**62 is a Fixnum, -2**53 is not
# accurate in a double
p (-(2**62)).fdiv(2**53 + 1), Rational(-(2**62), 2**53 + 1).to_f, box(-(2**62)).fdiv(box(2**53 + 1))
p 5.fdiv(-(2**53)), (-(2**53)).fdiv(2**53 + 3), box(-(2**53)).fdiv(box(2**53 + 3))

# a zero receiver keeps the divisor's sign
p 0.fdiv(-(2**53)), 0.fdiv(-(2**60)), 0.fdiv(-(2**100)), box(0).fdiv(box(-(2**100)))

# a negative divisor moves the sign to the numerator; CRuby picks the path
# from the receiver's side of the Fixnum boundary
p (-(2**62)).fdiv(-(2**53 + 1)), (2**62).fdiv(-(2**53 + 1))
p box(-(2**62)).fdiv(box(-(2**53 + 1))), box(2**62).fdiv(box(-(2**53 + 1)))

# a divisor of -2**63 cannot be negated in an int64; a reduced divisor of
# -2**62 is a Fixnum to CRuby, so a Bignum receiver divides as doubles
m = -9223372036854775807 - 1
x = 2**200 + 2**147 + 1
p 5.fdiv(m), (2**62 + 1).fdiv(m), m.fdiv(m), x.fdiv(m), box(5).fdiv(box(m))
p x.fdiv(-(2**62)), x.fdiv(2**62), box(x).fdiv(box(-(2**62)))
p m.fdiv(3), m.fdiv(2**60), m.fdiv(-(2**62) + 1), box(m).fdiv(box(-(2**62) + 1))
p (2 * x).fdiv(m), (-2 * x).fdiv(m), (4 * x + 4).fdiv(m), (2**63 * x).fdiv(m), box(2 * x).fdiv(box(m))

# send and Method#call reach the typed Bignum arm
p (2**2000 + 1).send(:fdiv, 2**2001), (2**2000 + 1).method(:fdiv).call(2**2001), (10**400).send(:fdiv, 1e300)

# a Bignum past the Float range over a zero, infinite or NaN Float
p ((10**400).fdiv(0.0) rescue $!.class), ((10**400).fdiv(-0.0) rescue $!.class), ((10**400).fdiv(-Float::INFINITY) rescue $!.message)
p (10**400).fdiv(Float::NAN), (-(10**400)).fdiv(-1e300), box(-(10**400)).fdiv(box(1e-300))
