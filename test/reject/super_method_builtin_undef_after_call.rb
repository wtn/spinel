# An undef_method that runs after the super_method call is not in force at
# the call: the method behind Child#concat is String#concat there.
# spinel: reject-unsupported: Method#super_method is not supported where the method behind is a builtin's (String#concat)
class Parent < String; end
class Child < Parent
  def concat(v) = "child #{v}"
end
m = Child.new("a").method(:concat)
p m.super_method.call("x")
class Parent
  undef_method :concat
end
