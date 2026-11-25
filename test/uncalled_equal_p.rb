class Path
  def self.[](path)
    if path.is_a?(self)
      return path
    elsif path.is_a?(Array)
      return self.new
    end
  end
  def encoded
    @segments.join("/")
  end
  alias to_s encoded
  def local_path(root)
    root + File::SEPARATOR
  end
  def simplify!
    @segments = simplified
  end
  def join(other)
    other = Path[other]
    other.empty?
  end
end
class Relative
  def initialize(path)
    @path = Path[path]
  end
  def to_ary
    [@path]
  end
  def base
    self.class.new(@path)
  end
  def equal?(other)
    to_ary == other.to_ary
  end
end
Relative.new("/search")
puts "ok"
