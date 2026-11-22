# Process::CLOCK_MONOTONIC_RAW, which Linux and macOS have, and
# CLOCK_MONOTONIC_RAW_APPROX, CLOCK_UPTIME_RAW and CLOCK_UPTIME_RAW_APPROX,
# which macOS has: each is defined where <time.h> has the clock.
darwin = RUBY_PLATFORM.include?("darwin")

p Process::CLOCK_MONOTONIC_RAW.class
p Process.clock_gettime(Process::CLOCK_MONOTONIC_RAW).class
p defined?(Process::CLOCK_MONOTONIC_RAW)

p defined?(Process::CLOCK_MONOTONIC_RAW_APPROX).nil? == !darwin
p defined?(Process::CLOCK_UPTIME_RAW).nil? == !darwin
p defined?(Process::CLOCK_UPTIME_RAW_APPROX).nil? == !darwin

up = begin
  Process.clock_gettime(Process::CLOCK_UPTIME_RAW)
rescue NameError => e
  e.message
end
p darwin ? up.is_a?(Float) : up == "uninitialized constant Process::CLOCK_UPTIME_RAW"

p defined?(::Process::CLOCK_UPTIME_RAW).nil? == !darwin
p((defined?(Process::CLOCK_UPTIME_RAW) ? Process::CLOCK_UPTIME_RAW.class : :none) == (darwin ? Integer : :none))
