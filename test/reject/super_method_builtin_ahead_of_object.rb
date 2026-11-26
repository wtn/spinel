# The method behind a String subclass's concat is String#concat, which
# comes before a concat the program defines in Object.
# spinel: reject-unsupported: Method#super_method is not supported where the method behind is a builtin's (String#concat)
class Object
  def concat(x) = "object concat #{x}"
end
class SafeBuffer < String
  def concat(value) = super(value.upcase)
end
p SafeBuffer.new("a").method(:concat).super_method.owner
