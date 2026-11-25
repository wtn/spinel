# A String-only Hash passed to `new` before an Integer-valued one, in a
# program where a class method of another class calls `new` with no
# receiver (Set.[] in the set package, Box.[] here).
require "set"

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

class Box
  def self.[](*items) = new(items)

  def initialize(items)
    @items = items
  end

  def size = @items.size
end

class Tag
  def self.make = new

  def name = "tag"
end

p Set.new([1, 2]).size
p Tag.make.name
p Box[1, 2, 3].size
p Message.new({"note" => "joined"}).data
p Message.new({"pong-nonce" => 3}).data

# a bare `new` in the class's own class method passes its argument on
class Note
  def self.build(h) = new(h)

  def initialize(input_data)
    @data = input_data.dup
  end

  def data
    hash = @data.dup
    hash.merge!("ack-nonce" => 8)
    hash
  end
end

class Memo < Note
end

p Note.new({"note" => "left"}).data
p Note.build({"pong-nonce" => 4}).data
p Memo.build({"ping-nonce" => 5}).data
