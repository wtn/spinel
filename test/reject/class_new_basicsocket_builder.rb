# Socket = Class.new(BasicSocket) { } makes a new subclass of BasicSocket,
# where `class Socket < BasicSocket` reopens the builtin.
require "socket"
Socket = Class.new(BasicSocket) { }
p Socket.superclass
