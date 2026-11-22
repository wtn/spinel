# A reader of a FIFO reads on after the writer's close: a last line with no
# newline, a short read followed by another read, a read into a buffer and a
# readpartial each return the bytes and then nil (EOFError for readpartial).
# On macOS select(2) returns the descriptor readable at the close until a
# read(2) has returned 0, so the read after that one waited on.
require "tmpdir"
fifo = File.join(Dir.tmpdir, "sp_fifo_past_close_#{Process.pid}")
File.mkfifo(fifo)

def pass(fifo, data)
  reader = Thread.new { File.open(fifo, "r") { |io| yield io } }
  writer = Thread.new { File.open(fifo, "w") { |io| io.write(data) } }
  p reader.join(5)&.value
  p writer.join(5) ? :writer_done : :writer_stuck
end

pass(fifo, "a\nb") { |io| [io.gets, io.gets, io.gets, io.eof?] }
pass(fifo, "abcd") { |io| [io.read(3), io.read(3), io.read(3), io.read] }
pass(fifo, "abcd") { |io| buf = +""; a = io.read(10, buf).dup; [a, io.read(10, buf), buf] }
pass(fifo, "abcd") { |io| [io.readpartial(2), io.readpartial(8), (io.readpartial(8) rescue $!.class), io.read, io.gets] }
pass(fifo, "a\nb\nc") { |io| a = []; io.each_line { |l| a << l }; [a, io.read, io.getc, io.readlines] }
File.delete(fifo)
puts "end"
