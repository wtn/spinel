class Pair
  def initialize(a)
    @a = a
  end
  def a
    @a
  end
  def base
    self.class.new(@a)
  end
  def equal?(other)
    @a == other.a
  end
end
q = Pair.new(1)
p q.equal?(q.base)
p q.base.equal?(Pair.new(2))
p q.base.a
