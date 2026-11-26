# A constants loop in `class Object` is refused: Object.constants has the
# builtin constants (String, Integer, ...) as well as the ones the body
# writes, and the unroll would define a method for the written ones only.
class Object
  ZZTOP = 1
  def self.each = constants.each { |c| yield c.downcase, const_get(c) }
  each do |name, value|
    define_method(name) { value } if name == :zztop || name == :string
  end
end
p Object.new.respond_to?(:string), Object.new.zztop
