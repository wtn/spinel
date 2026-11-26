# A local from `r, w = IO.pipe` or `a, b = UNIXSocket.pair` that a rescue
# arm or a later write binds to another value holds both kinds of value.
require "socket"

r, w = IO.pipe
w.write("hi")
w.close
p r.read
begin
  raise "boom"
rescue => r
  p r
end
p r.message

a, b = UNIXSocket.pair
a.write("x")
p b.recv(1)
b = 5
p b + 1

def reader
  r, w = IO.pipe
  w.close
  begin
    r.read_nonblock(1)
  rescue EOFError => r
    p r.class
  end
  p r.class
end
reader

r, w = IO.pipe
w.write("ab")
w.close_write
p r.getbyte
begin
  raise "again"
rescue => w
  p w.message
end
p r.getbyte
r = r.read
p r

def ends
  r, w = IO.pipe
  w.write("z")
  p r.getbyte
  r = 5
  w.close_write
  p [r, w.closed?]
end
ends

def reads
  r, w = IO.pipe
  w.write("ab\ncd\n")
  w.close
  begin
    p r.getc
    p r.readchar
    p r.readbyte
    p r.eof
    r.ungetc("x")
    a = []
    r.each_line { |l| a << l }
    p a, r.lineno
    raise "rebound"
  rescue => r
    p r.message
  end
  r2, w2 = IO.pipe
  w2.write("yz")
  w2.close
  b = []
  begin
    r2.each_byte { |x| b << x }
    raise "again"
  rescue => r2
    p b, r2.message
  end
end
reads
