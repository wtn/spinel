# A socket handle has no room for a program class, so MySock.new took the
# program's zero-argument initialize (CRuby connects); refused like IO and
# File.
require "socket"
class MySock < TCPSocket
end
srv = TCPServer.new("127.0.0.1", 0)
p MySock.new("127.0.0.1", srv.addr[1]).write("ab")
