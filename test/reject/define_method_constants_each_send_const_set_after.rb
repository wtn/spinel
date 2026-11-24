# A send of const_set after the class body that rebinds one of the
# constants keeps the loop refused: the unrolled method would read the
# constant ("new"), where CRuby's block returns the value it saw ("old").
class M
  TOKEN = +"old"
  def self.each = constants.each { |c| yield c.downcase, const_get(c) }
  each do |name, value|
    define_method(name) { value }
  end
end
M.send(:const_set, :TOKEN, +"new")
p M.new.token
