# A File class method given a nil path raises TypeError, as a nil literal
# does; a String and an object with to_path or to_str are taken as before.

def chk(name)
  yield
  puts "#{name}: no error"
rescue TypeError => e
  puts "#{name}: #{e.message}"
end

path = ARGV[0]
chk("exist?") { File.exist?(path) }
chk("file?") { File.file?(path) }
chk("directory?") { File.directory?(path) }
chk("readable?") { File.readable?(path) }
chk("writable?") { File.writable?(path) }
chk("executable?") { File.executable?(path) }
chk("readable_real?") { File.readable_real?(path) }
chk("writable_real?") { File.writable_real?(path) }
chk("executable_real?") { File.executable_real?(path) }
chk("size?") { File.size?(path) }
chk("zero?") { File.zero?(path) }
chk("empty?") { File.empty?(path) }
chk("symlink?") { File.symlink?(path) }
chk("pipe?") { File.pipe?(path) }
chk("socket?") { File.socket?(path) }
chk("blockdev?") { File.blockdev?(path) }
chk("chardev?") { File.chardev?(path) }
chk("owned?") { File.owned?(path) }
chk("grpowned?") { File.grpowned?(path) }
chk("setuid?") { File.setuid?(path) }
chk("setgid?") { File.setgid?(path) }
chk("sticky?") { File.sticky?(path) }
chk("world_readable?") { File.world_readable?(path) }
chk("world_writable?") { File.world_writable?(path) }
chk("absolute_path?") { File.absolute_path?(path) }
chk("size") { File.size(path) }
chk("stat") { File.stat(path) }
chk("lstat") { File.lstat(path) }
chk("ftype") { File.ftype(path) }
chk("basename") { File.basename(path) }
chk("dirname") { File.dirname(path) }
chk("extname") { File.extname(path) }
chk("split") { File.split(path) }
chk("expand_path") { File.expand_path(path) }
chk("absolute_path") { File.absolute_path(path) }
chk("realpath") { File.realpath(path) }
chk("readlink") { File.readlink(path) }
chk("read") { File.read(path) }
chk("binread") { File.binread(path) }
chk("readlines") { File.readlines(path) }
chk("open") { File.open(path) }
chk("new") { File.new(path) }
chk("join") { File.join("a", path) }
chk("identical?") { File.identical?(path, ".") }
chk("chmod") { File.chmod(0644, path) }
chk("write") { File.write(path, "") }
chk("link") { File.link(path, "x") }
chk("symlink") { File.symlink(path, "x") }
chk("mkfifo") { File.mkfifo(path) }
chk("foreach") { File.foreach(path) { |l| l } }
chk("utime") { File.utime(nil, nil, path) }
chk("read len") { File.read(path, 3) }
chk("read len off") { File.read(path, 3, 1) }
chk("read nil off") { File.read(path, nil, 1) }
chk("binread len") { File.binread(path, 3) }
chk("binread len off") { File.binread(path, 3, 1) }
chk("binread bytes") { File.binread(path).bytes }
chk("readlines chomp") { File.readlines(path, chomp: true) }
chk("readlines sep") { File.readlines(path, ",") }
chk("basename suffix") { File.basename(path, ".rb") }
chk("realdirpath") { File.realdirpath(path) }
chk("chown") { File.chown(nil, nil, path) }
chk("write off") { File.write(path, "x", 1) }
chk("write mode") { File.write(path, "x", mode: "a") }
chk("write perm") { File.write(path, "x", perm: 0600) }
chk("binwrite") { File.binwrite(path, "x") }
chk("open mode") { File.open(path, "w") }
chk("open flags") { File.open(path, File::RDONLY) }
chk("open flags perm") { File.open(path, File::WRONLY | File::CREAT, 0600) }
chk("open mode perm") { File.open(path, "w", 0600) }
chk("open block") { File.open(path) { |f| f.read } }
chk("new mode") { File.new(path, "r") }
chk("foreach sep") { File.foreach(path, ",") { |l| l } }
chk("fnmatch") { File.fnmatch("*", path) }
chk("fnmatch?") { File.fnmatch?("*", path) }
chk("lutime") { File.lutime(nil, nil, path) }
chk("link to") { File.link("no_such_file_here", path) }
chk("symlink to") { File.symlink("no_such_file_here", path) }
chk("identical 2nd") { File.identical?(".", path) }
chk("expand base") { File.expand_path("a", path).size > 0 }
chk("join first") { File.join(path, "a") }

class AsPath
  def to_path = "."
end
class AsStr
  def to_str = "."
end
here = "."
p File.exist?(here), File.directory?(here), File.file?(here), File.zero?(here)
p File.exist?(AsPath.new), File.directory?(AsStr.new), File.readable?(AsPath.new)
p File.basename("a/b.rb"), File.extname("a/b.rb"), File.dirname("a/b.rb")
p File.exist?("no_such_file_here"), File.size?("no_such_file_here")
