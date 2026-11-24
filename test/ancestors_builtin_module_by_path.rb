# A class that includes IO::WaitReadable by path lists the module in
# ancestors, and include? takes the module. Same for a prepend.
module T; class Other < StandardError; include IO::WaitReadable; end; end
p T::Other.ancestors
p T::Other.include?(IO::WaitReadable)
p T::Other.new.is_a?(IO::WaitReadable)
p IO::WaitReadable === T::Other.new
p T::Other < IO::WaitReadable
p T::Other.included_modules
module M; end
class K; include M; include IO::WaitWritable; include Comparable; end
p K.ancestors
p K.included_modules
module N; include IO::WaitReadable; end
class J; include N; end
p J.ancestors
p J.include?(IO::WaitReadable)
p N.include?(IO::WaitReadable)
begin
  raise T::Other, "x"
rescue IO::WaitReadable => e
  p e.class
end
p IO::WaitReadable.include?(IO::WaitReadable)
p IO::WaitReadable.is_a?(Module)
p IO::WaitReadable.instance_of?(Class)
p IO::EAGAINWaitReadable.include?(IO::WaitReadable)
p IO::WaitReadable.class
class P; prepend IO::WaitReadable; end
p P.ancestors
p P.include?(IO::WaitReadable)
class PE < StandardError; prepend IO::WaitWritable; end
begin
  raise PE
rescue IO::WaitWritable => e
  p e.class
end
