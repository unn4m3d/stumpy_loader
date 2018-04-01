require "spec"
require "../src/stumpy_loader"

module StumpyTest
  def self.read(path)
    StumpyCore::Canvas.new(256,256)
  end

  def self.read(io : IO)
    raise "IO"
  end

  def self.write(canvas, path)
    raise "Test!"
  end
end
