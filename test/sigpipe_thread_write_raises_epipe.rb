# A write in a thread to a pipe whose reader is closed raises Errno::EPIPE.
# Darwin sends the SIGPIPE to the process, where another thread can take it.
r, w = IO.pipe
r.close
t = Thread.new do
  [(w.write("x") rescue $!.class), (w.syswrite("x") rescue $!.class)]
end
p t.value
w.close
