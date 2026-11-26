# With another thread alive, File.open of a FIFO for reading sleeps in the
# scheduler until a writer sends a byte. A Thread#kill or Thread#raise ends
# the wait, and the open closes its descriptor before the thread unwinds.
require "tmpdir"
dir = File.join(Dir.tmpdir, "sp_fifo_kill_#{Process.pid}")
Dir.mkdir(dir)
fifo = File.join(dir, "fifo")
File.mkfifo(fifo)
st = File.stat(fifo)

def on_fifo(st)
  Dir.children("/dev/fd").count do |n|
    s = begin
      File.stat("/dev/fd/#{n}")
    rescue SystemCallError
      nil
    end
    s && s.ino == st.ino
  end
end

keep = Thread.new { sleep }
3.times do
  t = Thread.new { File.open(fifo, "r") }
  sleep 0.01 until t.status == "sleep"
  t.kill
  t.join
end
puts "after kill: #{on_fifo(st)}"
2.times do
  t = Thread.new do
    File.open(fifo, "r")
    "opened"
  rescue RuntimeError => e
    e.message
  end
  sleep 0.01 until t.status == "sleep"
  t.raise("stop")
  puts t.value
end
puts "after raise: #{on_fifo(st)}"
main = Thread.current
t = Thread.new do
  sleep 0.01 until main.status == "sleep"
  main.raise("stop main")
end
begin
  File.open(fifo, "r")
rescue RuntimeError => e
  puts e.message
end
t.join
puts "after raise of main: #{on_fifo(st)}"
t = Thread.new { Fiber.new { File.open(fifo, "r") }.resume }
sleep 0.01 until t.status == "sleep"
t.kill
p t.join(5).nil?
puts "after kill in a fiber: #{on_fifo(st)}"
t = Thread.new do
  Fiber.new { File.open(fifo, "r"); "opened" }.resume
rescue RuntimeError => e
  e.message
end
sleep 0.01 until t.status == "sleep"
t.raise("stop")
puts t.join(5)&.value
puts "after raise in a fiber: #{on_fifo(st)}"
keep.kill
keep.join
File.delete(fifo)
Dir.rmdir(dir)
