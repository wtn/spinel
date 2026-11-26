# super_method is nil where no method is behind, though a builtin has a
# method of the name: an alias looks up its definition's own name (`to_s`
# here is `fresh`, not Kernel#to_s), and an undef above the method stops
# the lookup before String#concat.
class A
  def fresh = 1
  alias to_s fresh
end
p A.new.method(:to_s).super_method
p A.new.to_s

class Parent < String
  undef_method :concat
end
class Child < Parent
  def concat(v) = "child #{v}"
end
p Child.new("a").method(:concat).super_method
p Child.new("a").concat("x")
