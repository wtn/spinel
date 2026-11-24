# A String-only Hash passed to `new` before an Integer-valued one, in a
# program where a method that never runs calls `new` on a constant the
# program does not define.
class Message
  def initialize(input_data)
    @data = input_data.dup
  end

  def data
    hash = @data.dup
    hash.merge!("ack-nonce" => 7)
    hash
  end
end

def unused
  Foo.new
end

def unused_args(message)
  Package.new([message])
end

p Message.new({"note" => "joined"}).data
p Message.new({"pong-nonce" => 3}).data
