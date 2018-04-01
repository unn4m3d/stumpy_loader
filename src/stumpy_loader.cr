require "./stumpy_loader/*"
require "stumpy_core"

module StumpyLoader
  class_property loaders = {} of String => Proc(String, StumpyCore::Canvas)
  class_property savers = {} of String => StumpyCore::Canvas, String ->
  class_property io_loaders = {} of String => IO -> StumpyCore::Canvas

  def self.load(path : String)
    extname = File.extname path
    if loaders.has_key? extname
      loaders[extname].call path
    else
      raise "Error loading #{path} : cannot found appropriate loader"
    end
  end

  def self.load(filename : String, io : IO)
    extname = File.extname filename
    if io_loaders.has_key? extname
      io_loaders[extname].call io
    else
      raise "Error loading #{filename} : cannot found appropriate loader"
    end
  end

  def self.save(canvas : StumpyCore::Canvas, path : String)
    extname = File.extname path
    if savers.has_key? extname
      savers[extname].call canvas, path
    else
      raise "Error saving #{path} : cannot found appropriate saver"
    end
  end
end

macro stumpy_load!
{% for const in @type.constants.select do |name|
    name =~ /^Stumpy[A-Z]/ &&
    @type.constant(name).is_a? TypeNode &&
    @type.constant(name).class.methods.any? do |x|
      x.name.stringify == "read" &&
      (!x.args.first.restriction || x.args.first.restriction.stringify == "String")
    end
  end %}
  {% extname = const.stringify.gsub(/^Stumpy/, ".").downcase %}
  StumpyLoader.loaders[{{extname}}] = ->(name : String) do
    {{const.id}}.read(name)
  end
{% end %}

{% for const in @type.constants.select do |name|
    name =~ /^Stumpy[A-Z]/ &&
    @type.constant(name).is_a? TypeNode &&
    @type.constant(name).class.methods.any? do |x|
      x.name.stringify == "read" &&
      (x.args.first.restriction.stringify == "IO")
    end
  end %}
  {% extname = const.stringify.gsub(/^Stumpy/, ".").downcase %}
  StumpyLoader.io_loaders[{{extname}}] = ->(name : IO) do
    {{const.id}}.read(name)
  end
{% end %}

{% for const in @type.constants.select do |name|
    name =~ /^Stumpy[A-Z]/ &&
    @type.constant(name).is_a? TypeNode &&
    @type.constant(name).class.methods.any? do |x|
      x.name.stringify == "write" &&
      x.args.size >= 2 &&
      !(x.args.first.restriction.stringify =~ /^Array/)
    end
  end %}
  {% extname = const.stringify.gsub(/^Stumpy/, ".").downcase %}
  StumpyLoader.savers[{{extname}}] = ->(canvas : StumpyCore::Canvas, name : String) do
    {{const.id}}.write(canvas, name)
  end
{% end %}
end
