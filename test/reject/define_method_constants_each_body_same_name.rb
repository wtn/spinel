# A define_method of one name in each copy keeps a constants loop
# refused: CRuby yields q, aa, b, zed, alpha, mid, beta, so `last`
# returns 4 (BETA), where the unroll's last copy defines it for B (7).
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
    define_method(:last) { value }
  end
end
p M.new.last
