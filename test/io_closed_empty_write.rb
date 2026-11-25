# An empty write to a closed IO writes nothing and raises nothing
require "tmpdir"
require "socket"

def try(label)
  puts "#{label}: #{yield.inspect}"
rescue IOError => e
  puts "#{label}: IOError: #{e.message}"
end

e = ""

path = File.join(Dir.tmpdir, "io_closed_empty_write_#{Process.pid}.txt")
f = File.open(path, "w")
f.close
File.delete(path)
try("file write") { f.write("") }
try("file write var") { f.write(e) }
try("file write nil") { f.write(nil) }
try("file write sym") { f.write(:"") }
try("file print") { f.print("") }
try("file print var") { f.print(e) }
try("file print two") { f.print("", e) }
try("file print nil") { f.print(nil) }
try("file <<") { (f << "").equal?(f) }
try("file << chain") { (f << "" << e).equal?(f) }
try("file printf") { f.printf("") }
try("file printf %s") { f.printf("%s", e) }
try("file putc") { f.putc("") }
one = [""]
two = ["", ""]
try("file write splat one") { f.write(*one) }
try("file write x") { f.write("x") }
try("file write two") { f.write("", "") }
try("file write int") { f.write(1) }
try("file print x") { f.print("x") }
try("file print two x") { f.print("", "x") }
try("file << x") { f << "x" }
try("file << chain x") { f << "" << "x" }
try("file printf x") { f.printf("%d", 1) }
try("file putc x") { f.putc("x") }
try("file putc int") { f.putc(65) }
try("file putc nul") { f.putc("\0") }
try("file write splat two") { f.write(*two) }
try("file puts") { f.puts }
try("file puts empty") { f.puts("") }
try("file syswrite") { f.syswrite("") }
try("file write_nonblock") { f.write_nonblock("") }

r, w = IO.pipe
r.close
w.close
try("pipe write") { w.write("") }
try("pipe write var") { w.write(e) }
try("pipe print") { w.print("") }
try("pipe <<") { (w << "").equal?(w) }
try("pipe printf") { w.printf("") }
try("pipe putc") { w.putc("") }
try("pipe write x") { w.write("x") }
try("pipe puts") { w.puts }
try("pipe syswrite") { w.syswrite("") }
try("pipe write_nonblock") { w.write_nonblock("") }
try("read end write") { r.write("") }
try("read end print") { r.print("") }
try("read end <<") { (r << "").equal?(r) }
try("read end write x") { r.write("x") }

a, b = UNIXSocket.pair
b.close
a.close
try("unix write") { a.write("") }
try("unix write var") { a.write(e) }
try("unix print") { a.print("") }
try("unix <<") { (a << "").equal?(a) }
try("unix printf") { a.printf("") }
try("unix putc") { a.putc("") }
try("unix write x") { a.write("x") }
try("unix puts") { a.puts }
try("unix syswrite") { a.syswrite("") }
try("unix write_nonblock") { a.write_nonblock("") }
try("unix send") { a.send("", 0) }

srv = TCPServer.new("127.0.0.1", 0)
c = TCPSocket.new("127.0.0.1", srv.addr[1])
srv.close
c.close
try("tcp write") { c.write("") }
try("tcp write var") { c.write(e) }
try("tcp print") { c.print("") }
try("tcp <<") { (c << "").equal?(c) }
try("tcp printf") { c.printf("") }
try("tcp putc") { c.putc("") }
try("tcp write x") { c.write("x") }
try("tcp puts") { c.puts }
try("tcp syswrite") { c.syswrite("") }
try("tcp write_nonblock") { c.write_nonblock("") }
try("tcp send") { c.send("", 0) }

o = STDOUT.dup
o.close
try("stdout dup write") { o.write("") }
try("stdout dup print") { o.print("") }
try("stdout dup <<") { (o << "").equal?(o) }
try("stdout dup write x") { o.write("x") }

[f, a, 1].each do |io|
  next if io.is_a?(Integer)
  try("boxed write") { io.write("") }
  try("boxed print") { io.print("") }
  try("boxed <<") { (io << "").equal?(io) }
  try("boxed printf") { io.printf("") }
  try("boxed write x") { io.write("x") }
  try("boxed write two") { io.write("", "") }
  try("boxed write splat one") { io.write(*one) }
  try("boxed write splat two") { io.write(*two) }
end
