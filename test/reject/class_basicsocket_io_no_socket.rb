# Without `require "socket"`, a class BasicSocket of the program's own is
# a plain class, and its IO superclass is refused as any IO subclass is.
class BasicSocket < IO
end
p BasicSocket.superclass
