# Two threads pass lines through one FIFO: the reader's read returns at the
# writer's close. On macOS poll(2) and kqueue on the reader's descriptor
# report the bytes but not the close, so the read waited on.
require "tmpdir"
fifo = File.join(Dir.tmpdir, "sp_fifo_writer_close_#{Process.pid}")
File.mkfifo(fifo)
reader = Thread.new { File.open(fifo, "r") { |io| io.read } }
writer = Thread.new { File.open(fifo, "w") { |io| 3.times { |i| io.puts "line #{i}" } } }
p reader.join(5)&.value
p writer.join(5) ? :writer_done : :writer_stuck
# the writer holds the FIFO open past the reader's first bytes
reader = Thread.new { File.open(fifo, "r") { |io| io.read } }
writer = Thread.new do
  File.open(fifo, "w") do |io|
    io.puts "first"
    io.flush
    sleep 0.3
    io.puts "second"
  end
end
p reader.join(5)&.value
p writer.join(5) ? :writer_done : :writer_stuck
File.delete(fifo)
puts "end"
