# SIGEMT, the emulator trap of macOS and the BSDs: its name is in Signal.list
# where the platform has it, and trap, Signal.signame and Process.kill take
# it there. Linux has no such signal, and the name is absent, as in CRuby.
has = Signal.list.key?("EMT")
p has == !!(RUBY_PLATFORM =~ /darwin|bsd/)
if has
  got = 0
  trap("EMT") { got += 1 }
  Process.kill("EMT", Process.pid)
  sleep 0.01 while got == 0
  p Signal.signame(Signal.list["EMT"]), got, trap("SIGEMT", "DEFAULT").class
else
  p "EMT", 1, Proc
end
