# A const_added hook keeps a constants loop refused: CRuby's hook here
# makes HEAD private, so `constants` leaves HEAD out and CRuby defines
# only `get`, where the unroll would define `head` too.
class Module
  def const_added(name)
    private_constant(name) if name == :HEAD
  end
end
class M
  GET = 1
  HEAD = 2
  def self.each = constants.each { |c| yield c.downcase, const_get(c) }
  each do |name, value|
    define_method(name) { value }
  end
end
p M.instance_methods(false).sort
