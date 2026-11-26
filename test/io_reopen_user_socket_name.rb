# Without `require "socket"`, a class of the program's own named Socket is
# a plain class, not the builtin's reopening.
class Socket
  def initialize(h) = @h = h
  def h = @h
end
module Net
  class Socket
    def x = "x"
  end
end
p Socket.new(3).h, Net::Socket.new.x

# A subclass of the program's own Socket or TCPSocket is a plain subclass.
class WebSock < Socket
end
class TCPSocket
  attr_reader :a
  def initialize(a) = @a = a
end
class My < TCPSocket
end
p WebSock.new(4).h, My.new(5).a
