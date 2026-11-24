# A String-only Hash passed to `new` before an Integer-valued one, where a
# subclass's or a module's initialize passes the Hash on with super.
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

class Reply < Message
  def initialize(d) = super(d)
end

class Echo < Message
  def initialize(d)
    super
  end
end

p Message.new({"note" => "joined"}).data
p Reply.new({"pong-nonce" => 3}).data
p Echo.new({"ping-nonce" => 4}).data

# through a module's initialize
class Note
  def initialize(input_data)
    @data = input_data.dup
  end

  def data
    hash = @data.dup
    hash.merge!("ack-nonce" => 8)
    hash
  end
end

module Wrap
  def initialize(d) = super(d)
end

class Wrapped < Note
  include Wrap
end

p Note.new({"note" => "left"}).data
p Wrapped.new({"pong-nonce" => 5}).data

# a module's bare super beside another module's, in an unrelated class
class Memo
  def initialize(input_data)
    @data = input_data.dup
  end

  def data
    hash = @data.dup
    hash.merge!("ack-nonce" => 9)
    hash
  end
end

module Pass
  def initialize(d)
    super
  end
end

module Keep
  def initialize(d)
    super
  end
end

class Passed < Memo
  include Pass
end

class Kept
  include Keep

  def initialize(d)
    @kept = d
  end

  def kept = @kept
end

p Memo.new({"note" => "kept"}).data
p Passed.new({"pong-nonce" => 6}).data
p Kept.new(1).kept

# a chain of bare supers
class Link1 < Memo
  def initialize(d)
    super
  end
end

class Link2 < Link1
  def initialize(d)
    super
  end
end

class Link3 < Link2
  def initialize(d)
    super
  end
end

p Link3.new({"ping-nonce" => 7}).data

# two forwarding modules in one class, and in opposite orders in two classes
class Stack1 < Memo
  include Pass
  include Keep
end

class Stack2 < Memo
  include Keep
  include Pass
end

p Stack1.new({"pong" => "six"}).data
p Stack1.new({"pong-nonce" => 8}).data
p Stack2.new({"ping-nonce" => 9}).data

# the same with super(d)
class Slip
  def initialize(input_data)
    @data = input_data.dup
  end

  def data
    hash = @data.dup
    hash.merge!("ack-nonce" => 10)
    hash
  end
end

module Fore
  def initialize(d)
    super(d)
  end
end

module Aft
  def initialize(d)
    super(d)
  end
end

class Slip1 < Slip
  include Fore
  include Aft
end

class Slip2 < Slip
  include Aft
  include Fore
end

class Slip3 < Slip
  include Fore
end

p Slip1.new({"pong" => "six"}).data
p Slip2.new({"ping-nonce" => 11}).data
p Slip3.new({"x" => "y"}).data
