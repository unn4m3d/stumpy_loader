# stumpy_loader

[![Build Status](https://travis-ci.org/unn4m3d/stumpy_loader.svg?branch=master)](https://travis-ci.org/unn4m3d/stumpy_loader)

(**EXPERIMENTAL**) Extension-based loader for image files

:warning: This project is experimental, so you can experience compilation errors with third-party loaders

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  stumpy_loader:
    github: unn4m3d/stumpy_loader
```

## Usage

```crystal
require "stumpy_loader"
# Require some loaders (StumpyPNG and StumpyTGA)
require "stumpy_png"
require "stumpy_tga"

# You MUST call stumpy_load! macro AFTER all loaders are defined
stumpy_load!

canvas1 = StumpyLoader.load "some/png/file.png"
canvas2 = StumpyLoader.load "some/file.tga"
canvas3 = StumpyLoader.loag "file.jpg" # Raises exception because there is no loader for JPEG

StumpyLoader.save canvas1, "file.png" # OK
StumpyLoader.save canvas1, "file.tga" # Raises exception because there is no saver for TGA
```

In above example, [stumpy_png](https://github.com/stumpycr/stumpy_png) and
[stumpy_tga](https://github.com/unn4m3d/stumpy_tga) are used

:warning: You **MUST** call stumpy_load! macro **AFTER** all loaders are defined

## Contributing

1. Fork it ( https://github.com/unn4m3d/stumpy_loader/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [unn4m3d](https://github.com/unn4m3d) - creator, maintainer
