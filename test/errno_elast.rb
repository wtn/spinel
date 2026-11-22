# Errno::ELAST is Errno::ENOTCAPABLE (107) on macOS, where <errno.h>
# defines ELAST as ENOTCAPABLE. On Linux, CRuby's Errno::ELAST is
# Errno::NOERROR, with Errno 0.
mac = !!(RUBY_PLATFORM =~ /darwin/)
p !mac || Errno::ELAST::Errno == Errno::ENOTCAPABLE::Errno
p !mac || Errno::ELAST::Errno == 107
p !mac || Errno::ELAST.equal?(Errno::ENOTCAPABLE)
e = (raise Errno::ELAST rescue $!)
p e.errno == Errno::ELAST::Errno
p !mac || e.is_a?(Errno::ENOTCAPABLE)
