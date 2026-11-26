# A class body loop over a class method that yields the class's own
# constants (`constants.each { |name| yield name.downcase, const_get(name) }`)
# defines one method per constant, as Protocol::HTTP::Methods does.
class Methods
  GET = +"GET"
  HEAD = "HEAD"
  POST = "POST"

  def self.each
    return to_enum(:each) unless block_given?

    constants.each do |name|
      yield name.downcase, const_get(name)
    end
  end

  def call(request) = request

  self.each do |name, method|
    define_method(name) do |*arguments, **options|
      self.call([method, arguments, options])
    end
  end
end

class Upper
  A = 1
  B = 2

  def self.each
    constants.each { |c| yield c, const_get(c) }
  end

  each do |name, value|
    define_method(name) { |scale = value| value * scale }
  end
end

m = Methods.new
p m.get
p m.head("/", 1)
p m.post("/x", body: "b")
p m.get.first.equal?(Methods::GET)
p Methods.instance_methods(false).sort
p Upper.new.A
p Upper.new.B
p Upper.new.B(3)
