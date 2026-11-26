# STDERR.sync after STDERR.reopen: unchanged for a path with the mode
# omitted, the pipe's sync for an IO, false for a path with a mode
require "tmpdir"
path = File.join(Dir.tmpdir, "io_stderr_sync_reopen_#{Process.pid}.txt")
STDERR.reopen(path)
p STDERR.sync
r, w = IO.pipe
STDERR.reopen(w)
p STDERR.sync
STDERR.reopen(path, "w+")
p STDERR.sync
STDERR.write "a"
p File.read(path)
STDERR.flush
p File.read(path)
File.delete(path)
STDERR.sync = true
STDERR.reopen(w)
p STDERR.sync
p STDERR.dup.sync
