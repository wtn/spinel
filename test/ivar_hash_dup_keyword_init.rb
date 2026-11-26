# An Integer-valued Hash and a String-only Hash passed to `new` as a
# keyword argument.
class Message
  def initialize(input_data:, session:)
    @session = session
    @data = input_data.dup
  end

  def data
    hash = @data.dup
    hash.merge!("from-old-session" => @session)
    hash
  end
end

p Message.new(input_data: {"note" => "ack", "ack-nonce" => 5}, session: 99).data
p Message.new(session: 2, input_data: {"note" => "command"}).data

# an optional keyword's default
class Reply
  def initialize(session:, input_data: {"note" => "none"})
    @session = session
    @data = input_data.dup
  end

  def data
    hash = @data.dup
    hash.merge!("from-old-session" => @session)
    hash
  end
end

p Reply.new(session: 3).data
p Reply.new(session: 4, input_data: {"k" => "v"}).data

# a subclass passes the keyword on with super
class Base
  def initialize(input_data:, session:)
    @session = session
    @data = input_data.dup
  end

  def data
    hash = @data.dup
    hash.merge!("from-old-session" => @session)
    hash
  end
end

class Named < Base
  def initialize(d, s) = super(input_data: d, session: s)
end

p Named.new({"n" => 1}, 5).data
p Named.new({"note" => "named"}, 6).data

# a bare super in a subclass
class Root
  def initialize(input_data:, session:)
    @session = session
    @data = input_data.dup
  end

  def data
    hash = @data.dup
    hash.merge!("from-old-session" => @session)
    hash
  end
end

class Bare < Root
  def initialize(input_data:, session:)
    super
  end
end

p Bare.new(input_data: {"n" => 4}, session: 7).data
p Bare.new(input_data: {"note" => "bare"}, session: 11).data

# a class method's bare new
class Built
  def self.build(h, s) = new(input_data: h, session: s)

  def initialize(input_data:, session:)
    @session = session
    @data = input_data.dup
  end

  def data
    hash = @data.dup
    hash.merge!("from-old-session" => @session)
    hash
  end
end

p Built.build({"n" => 2}, 8).data
p Built.build({"note" => "built"}, 9).data

# a new with a `**opts` beside the keyword
class Mixed
  def initialize(input_data:, session:)
    @session = session
    @data = input_data.dup
  end

  def data
    hash = @data.dup
    hash.merge!("from-old-session" => @session)
    hash
  end
end

opts = {session: 10}
p Mixed.new(input_data: {"n" => 3}, **opts).data
p Mixed.new(input_data: {"note" => "mixed"}, **opts).data
