class E < StandardError
  def initialize(m = "a")
    $log << "v1"
    super("v1 #{m}")
  end
end
$log = []
begin
  Kernel.raise E
rescue => e
  p e.message
end
class E
  def initialize(m = "b")
    $log << "v2"
    super("v2 #{m}")
  end
end
begin
  Kernel.raise E
rescue => e
  p e.message
end
begin
  raise E, "c"
rescue => e
  p e.message
end
p $log
