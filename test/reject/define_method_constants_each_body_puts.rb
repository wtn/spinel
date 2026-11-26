# A statement other than define_method in the loop body keeps a constants
# loop refused: CRuby's `constants` returns the order of its constant
# table (here q, aa, b, zed, alpha, mid, beta), where the unroll copies the
# body in the order of the writes.
class M
  ZED = 1
  ALPHA = 2
  MID = 3
  BETA = 4
  Q = 5
  AA = 6
  B = 7
  def self.each = constants.each { |c| yield c.downcase, const_get(c) }
  each do |name, value|
    define_method(name) { value }
    puts name
  end
end
