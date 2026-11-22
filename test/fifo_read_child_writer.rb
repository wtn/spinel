# A program with one thread reads a FIFO a child writes: the read returns
# at the child's close. On macOS poll(2) on the reader's descriptor reports
# the bytes but not the close, so the read waited on.
require "tmpdir"
fifo = File.join(Dir.tmpdir, "sp_fifo_child_writer_#{Process.pid}")
File.mkfifo(fifo)
w = spawn("sh", "-c", 'exec 3> "$1"; sleep 0.2; echo one >&3; sleep 0.2; echo two >&3', "sh", fifo)
p File.open(fifo, "r") { |io| io.read }
Process.wait(w)
w = spawn("sh", "-c", 'exec 3> "$1"; sleep 0.2; echo one >&3; sleep 0.2; echo two >&3', "sh", fifo)
p File.open(fifo, "r") { |io| a = []; while (l = io.gets); a << l; end; a }
Process.wait(w)
File.delete(fifo)
puts "end"
