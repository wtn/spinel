# STDERR.reopen(io) takes io's sync: false for a File, true again for a
# saved STDERR.dup, and STDERR.dup copies the flag after the restore
require "tmpdir"
path = File.join(Dir.tmpdir, "io_stderr_sync_reopen_file_#{Process.pid}.txt")
saved = STDERR.dup
f = File.open(path, "w")
STDERR.reopen(f)
p STDERR.sync
STDERR.reopen(saved)
p STDERR.sync
p STDERR.dup.sync
f.close
File.delete(path)
