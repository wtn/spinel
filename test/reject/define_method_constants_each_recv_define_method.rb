# A define_method of downcase on Symbol from another class's list loop
# keeps a constants loop refused: CRuby's `c.downcase` calls the defined
# method (here `:other`), where the unroll writes the downcased name.
class Other
  [:downcase].each { |v| Symbol.send(:define_method, v) { :other } }
end
class M
  GET = 1
  def self.each = constants.each { |c| yield c.downcase, const_get(c) }
  each do |name, value|
    define_method(name) { value }
  end
end
p M.instance_methods(false)
