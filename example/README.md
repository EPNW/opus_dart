This readme explains very briefly what steps are needed to get the example running.

## For dart:ffi platforms

1. Retrive a shared library of opus for your platform
  * If you want to build yourself, take a look at this [Dockerfile](../Dockerfile)
  * Hint: For Windows there are some prebuild libraries in [opus_flutter_windows's assets](https://github.com/EPNW/opus_flutter/tree/master/opus_flutter_windows/assets)
2. Edit `lib/src/init_ffi.dart` to point to your shared library
3. Run one of the examples, e.g. `example.dart` from this folder:
   ```shell
    dart ./bin/example.dart
   ``` 


## For web_ffi platforms

Web support was removed in version 4 of this package.