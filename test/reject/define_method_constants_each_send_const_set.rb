# A statement ahead of a constants loop that is no literal constant write
# or def (here a send of const_set, which adds EXTRA) keeps the loop
# refused: the unroll would leave out the method `extra` CRuby defines.
class M
  GET = "GET"
  send(:const_set, :EXTRA, "EXTRA")
  def self.each = constants.each { |c| yield c.downcase, const_get(c) }
  each do |name, value|
    define_method(name) { value }
  end
end
p M.new.extra
