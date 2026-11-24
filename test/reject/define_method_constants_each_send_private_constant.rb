# A send of private_constant ahead of a constants loop hides EXTRA from
# `constants`: the loop stays refused, where the unroll would define the
# method `extra` CRuby does not.
class M
  GET = "GET"
  EXTRA = "EXTRA"
  send(:private_constant, :EXTRA)
  def self.each = constants.each { |c| yield c.downcase, const_get(c) }
  each do |name, value|
    define_method(name) { value }
  end
end
p M.new.respond_to?(:extra)
