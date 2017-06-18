require "./spec_helper"

stumpy_load!

describe StumpyLoader do
  # TODO: Write tests

  it "works" do
    StumpyLoader.loaders.keys.should eq([".test"])

    canvas = StumpyLoader.load "123.test"
    canvas.width.should eq(canvas.height)

    expect_raises(Exception, "Test!") do
      StumpyLoader.save canvas, "456.test"
    end
  end
end
