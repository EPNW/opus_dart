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

1. Retrive a modular emscripten build of opus with export name `libopus`
   * For more information take a look at step 3 of [web_ffi's example](https://github.com/EPNW/web_ffi/blob/master/example/README.md)
   * Hint: You can get prebuild files from [opus_flutter_web's assets](https://github.com/EPNW/opus_flutter/tree/master/opus_flutter_web/assets)
2. Place `libopus.wasm` and `libopus.js` into the `web` folder
3. Decide on an example from the `bin` folder and convert it to JavaScript, e.g. `example.dart`:
   ```shell
    dart compile js ./bin/example.dart -o ./web/main.dart.js
   ```
4. Open a terminal in the `web` folder and server it over http, e.g. with [`dhttpd`](https://pub.dev/packages/dhttpd):
   * Install `dhttpd`: `dart pub global activate dhttpd`
   * Serve it: `dart pub global run dhttpd -p 8080`
   * Open it in the browser: [http://localhost:8080](http://localhost:8080)
   * To see the dart prints, open the JavaScript console of your browser