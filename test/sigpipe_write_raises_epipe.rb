# A write to a pipe whose reader is closed raises Errno::EPIPE: the program
# installs an empty SIGPIPE handler at startup, as CRuby does. A child
# process has SIGPIPE at its default, and trap("PIPE", "DEFAULT") keeps the
# EPIPE.
r, w = IO.pipe
r.close
p((w.write("x") rescue $!.class))
p((w.write_nonblock("x") rescue $!.class))
p((w.syswrite("x") rescue $!.class))
p `sh -c 'trap | grep PIPE; echo done'`.chomp
p trap("PIPE", "DEFAULT")
p((w.write("x") rescue $!.class))
w.close
# a syswrite flushes stdio's buffered bytes first, and that flush's EPIPE
# raises too
$VERBOSE = nil
r2, w2 = IO.pipe
w2.sync = false
w2.write("a")
r2.close
p((w2.syswrite("b") rescue $!.class))
