# After STDERR.sync = true, STDERR.reopen(w) for a pipe keeps the write path
# that STDERR.timeout bounds: a full pipe raises IO::TimeoutError
r, w = IO.pipe
STDERR.sync = true
STDERR.reopen(w)
STDERR.timeout = 0.2
t = Thread.new do
  begin
    loop { STDERR.syswrite("x" * 65536) }
  rescue IO::TimeoutError => e
    e.class
  end
end
p t.join(5) ? t.value : :hung
$stdout.flush
exit!(0)
