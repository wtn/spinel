# An undef of downcase keeps a constants loop refused: CRuby's
# `c.downcase` raises NoMethodError, where the unroll writes the
# downcased constant name (`get`).
class Symbol
  undef downcase
end
class M
  GET = 1
  def self.each = constants.each { |c| yield c.downcase, const_get(c) }
  each do |name, value|
    define_method(name) { value }
  end
end
p M.instance_methods(false)
