# STDERR is sync from the start, and #sync= and #dup carry the flag
p STDERR.sync
p $stderr.sync
p STDOUT.sync
p STDERR.dup.sync
STDERR.sync = false
p STDERR.sync
p STDERR.dup.sync
STDERR.sync = true
p STDERR.sync
