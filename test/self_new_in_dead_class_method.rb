# A `self.new(block)` in a class method nothing calls builds no Middleware,
# so the call `@delegate.close` in Middleware#close compiles.
require "time"
class Methods
  def self.each
    constants.each { }
  end
end
class Cookie
  def to_h
    Time.parse("1")
  end
end
class Readable
  def call(stream)
    stream.close
  end
end
class Middleware < Methods
  def self.for(&block)
    self.new(block)
  end
  def initialize(delegate)
    @delegate = delegate
  end
  attr :delegate
  def close
    @delegate.close
  end
end

class Box
  def self.make(v)
    self.new(v)
  end
  def initialize(v)
    @v = v
  end
  attr_reader :v
end
class SubBox < Box; end
p SubBox.make(3).class
p SubBox.make(4).v
p Box.make("x").v
class Pt
  def self.two
    [1, 2].map { |i| self.new }
  end
end
p Pt.two.map(&:class)
puts "ok"
