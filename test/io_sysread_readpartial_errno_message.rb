# The Errno message of sysread and readpartial: the bare strerror for a
# socket, and "@ rb_io_sysread - <path>" or "@ io_getpartial - <path>" for
# a File, with and without an output buffer.
require "socket"
require "tmpdir"

def attempt(dir = nil)
  yield
  :ok
rescue SystemCallError => e
  msg = dir ? e.message.sub(dir, "DIR") : e.message
  # glibc's strerror reads "Transport endpoint is not connected"
  msg = "ENOTCONN" if msg == Errno::ENOTCONN.new.message
  "#{e.class}: #{msg}"
end

un = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM)
p attempt { un.sysread(10) }
p attempt { un.readpartial(10) }
p attempt { un.sysread(10, +"") }
p attempt { un.readpartial(10, +"") }
un.close

dir = Dir.mktmpdir
d = File.open(dir)
p attempt(dir) { d.sysread(10) }
p attempt(dir) { d.readpartial(10) }
p attempt(dir) { d.sysread(10, +"") }
p attempt(dir) { d.readpartial(10, +"") }
buf = +"x"
buf << "y"
p attempt(dir) { d.sysread(10, buf) }
p attempt(dir) { d.readpartial(10, buf) }
boxed = [d, "s"][ARGV.size]
p attempt(dir) { boxed.sysread(10) }
p attempt(dir) { boxed.readpartial(10) }
p attempt(dir) { boxed.sysread(10, buf) }
p attempt(dir) { boxed.readpartial(10, buf) }
d.close
Dir.rmdir(dir)
