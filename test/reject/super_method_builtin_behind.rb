# A Method's super_method whose method behind is a builtin's: a String
# subclass's concat calls String#concat through super, and its Method's
# super_method is String#concat in CRuby. Refused where the program is
# built; the call on the nil it answered crashed.
# spinel: reject-unsupported: Method#super_method is not supported where the method behind is a builtin's (String#concat)
class SafeBuffer < String
  def concat(value)
    super(value.upcase)
  end

  def safe_concat(value)
    method(:concat).super_method.call(value)
  end
end
b = SafeBuffer.new("<p>")
b.safe_concat("x")
puts b
