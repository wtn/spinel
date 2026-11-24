# An Integer-valued Hash and a String-only Hash passed to `new`, in a
# program where a method that is never called passes its parameter to
# `new`.
class Message
  def initialize(input_data, session)
    @session = session
    @data = input_data.dup
  end

  def data
    hash = @data.dup
    hash.merge!("from-old-session" => @session)
    hash
  end
end

def enqueue_write(data)
  Message.new(data, 1)
end

p Message.new({"note" => "ack", "ack-nonce" => 5}, 99).data
p Message.new({"note" => "command"}, 2).data
