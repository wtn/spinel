# File::SHARE_DELETE is 0 off Windows, as in CRuby
require "tmpdir"
p File::SHARE_DELETE
p defined?(File::SHARE_DELETE)
Dir.mktmpdir("spinel_share_delete") do |dir|
  path = File.join(dir, "out")
  File.open(path, File::WRONLY | File::CREAT | File::SHARE_DELETE) { |f| f.write("x") }
  p File.read(path)
end
