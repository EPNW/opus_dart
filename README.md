# opus_dart
Wraps libopus in dart, and additionally provides a dart friendly API for encoding and decoding.

<a name="toc"></a>
##### Table of Contents  
1. [Versioning](#versioning)  
2. [Choosing The Right Library](#choosing)<br>
    2.1 [The Bindings](#choosing_bindings)<br>
    2.2 [The Dart Friendly API](#choosing_firendly)<br>
3. [Initialization](#init)<br>
    3.1 [The Bindings](#init_bindings)<br>
    3.2 [The Dart Friendly API](#init_friendly)<br>
    3.3 [What is `lib`?](#init_lib)<br>
    3.4 [Flutter](#init_flutter)<br>

<a name="versioning"></a>
## Versioning
Current libopus version: 1.3.1

See the changelog for other versions of libopus.

On small patches, the patch version of this package will increase, if a new Opus version is wrapped (but there are no API changes), the minor version will increase, and on breaking API changes, the major version will increase. So to ensure to get a specific version of Opus, lock in on major and minor version (e.g. `opus_dart: ">=3.0.0 <3.1.0"`), to always use the newest Opus version with compatible API, lock on the major version (e.g. `opus_dart: ">=4.0.0 <4.0.0"`). 

<a name="choosing"></a>
## Choosing The Right Library
<a name="choosing_bindings"></a>
### The Bindings
There are automatically generated bindings for most functions of the Opus include headers.
The generated bindings can all be found in the /wrappers section and are named after the group they are from.
Documentation of the bounded functions was copied from the Opus headers (and is thus not very well formated).
For sake of completeness the tool folder contains the code that was used for generation. NOTE that [ffi_tool](https://github.com/dart-interop/ffi_tool) ^0.4.0 is needed for generation, which might not be yet available on pub, so it's used directly from GitHub. Also, since in the meantime a somewhat official package to create ffi bindings - [ffigen](https://pub.dev/packages/ffigen) - emerged, this should be used to generate bindings for further opus versions.

<a name="choosing_firendly"></a>
### The Dart Friendly API
Most users are interested in a more Dart like API to encode and decode Opus packages.
The opus_dart library provides this, so you don't have to take care of memory allocation and
similar tasks. The OpusEncoder and OpusDecoder are both implemented in two ways:
* SimpleOpusEncoder / SimpleOpusDecoder <br>
  These coders are very simple to use as they handle memory allocation/deallocation for you.
  As consequence, they make heavy use of buffer allocation.
* BufferedOpusEncoder / BufferedOpusDecoder <br>
  These coders allocate native memory just once. You can then directly write to the memory.
  When writing to the memory, you have to update the corresponding input index.

Performance gains of using the buffered versions over the simple versions varies.
Befor trying to optimize your code using a buffered version, try the simple version first.

There are also StreamTransformers that can help you encoding PCM streams to Opus packets,
or decode Opus packets to PCM streams.

WARNING: All classes have to be destroyed manually by calling their appropriate methods,
so that the allocated native memory can be released. Otherwise, a memory leak may occur!


<a name="init"></a>
## Initialization
<a name="init_bindings"></a>
### The Bindings
Each generated library in /wrappers (except opus_defines.h) need to be initialized if used.
The generated libraries are intended to be used with a prefix, because they sometimes have
functions with the same signature. For example, you would import them using
```dart
import 'package:opus_dart/wrappers/opus_libinfo.dart' as opus_libinfo;
import 'package:opus_dart/wrappers/opus_custom.dart' as opus_custom;
```
and then you can call in your startup logic
```dart
late final opus_libinfo.FunctionsAndGlobals libinfo;
late final opus_custom.FunctionsAndGlobals custom;
void main(){
    libinfo=opus_libinfo.FunctionsAndGlobals(lib);
    custom=opus_custom.FunctionsAndGlobals(lib);
}
```
Finally, you can use the objects `libinfo` and `custom` to access the functions and globals.

<a name="init_friendly"></a>
### The Dart Friendly API
If using the dart firendly library opus_dart, you also have to initialize it using the toplevel `initOpus` function,
but unlike the bindings, there is no need to import it with a prefix. This would look like:
```dart
import 'package:opus_dart/opus_dart.dart';

void main(){
    initOpus(lib);
    // Check if you loaded the right version
    print(getOpusVersion());
}
```

<a name="init_lib"></a>
### What is `lib`?
As you may have noticed above, both, the Dart friendly API and the bindings need `lib` to initalize.
Since web support was introduced in vesion `3.0.0` of this package, `lib` is something different on platforms
that support `dart:ffi`, and on the web, where `dart:ffi` is not available, and where [web_ffi](https://pub.dev/packages/web_ffi) is used to emulate `dart:ffi`.

On a `dart:ffi` platform, `lib` is a [dart:ffi DynamicLibrary](https://api.dart.dev/stable/2.12.0/dart-ffi/DynamicLibrary-class.html) instance, pointing to libopus. You can dynamically load it:
```dart
import 'dart:ffi';
import 'dart:io' show Platform;

void main() {
  DynamicLibrary lib;
  if (Platform.isWindows) {
    bool x64 = Platform.version.contains('x64');
    if (x64) {
      lib = new DynamicLibrary.open('path/to/libopus_x64.dll');
    } else {
      lib = new DynamicLibrary.open('path/to/libopus_x86.dll');
    }
  } else if (Platform.isLinux) {
    lib = new DynamicLibrary.open('/usr/local/lib/libopus.so');
  }
}
```

On the web, `lib` is a [web_ffi DynamicLibrary](https://pub.dev/documentation/web_ffi/latest/web_ffi/DynamicLibrary-class.html) instance.
You can also dynamically load it, but you have to inject some JavaScript into your page first. A detailed walkthrough can be found in [web_ffi's example](https://github.com/EPNW/web_ffi/blob/master/example/README.md).
Note: If you use the dart fiendly API with `web_ffi`, all `Opaque` types are registered automatically. If you use the bindings with `web_ffi`, you have to register them manually!

Also, it might be interesting to study the [example](https://github.com/EPNW/opus_dart/tree/master/example), what makes use of conditional imports and initalization.

**Attention:** This package does not contain any binaries, and even if libopus is open source, no source files are included in this package either,
since there is [no native build system for dart:ffi](https://github.com/dart-lang/sdk/issues/36712) at the moment.
There is also no build system for WebAssembly integrated in dart at the moment.
It's up to you to get binaries and to distribute them with your application.
Keep in mind that you need a dynamic library for all operating systems and architectures you want to support.
Whether you use prebuild binaries or compile libopus from [source](https://github.com/xiph/opus/) yourself, the version you use should match this packages wrapped version (see above). An example to build Opus can be found in the [Dockerfile on this packages GitHub page](https://github.com/EPNW/opus_dart/blob/master/Dockerfile).
An example to build it for the web can be found in [web_ffi's example](https://github.com/EPNW/web_ffi/blob/master/example/README.md).

<a name="init_flutter"></a>
### Flutter
If you are using Flutter, you can use [opus_flutter](https://pub.dev/packages/opus_flutter) to easily obtain a `DynamicLibrary` of libopus, for both, `dart:ffi` and web platforms:
```dart
import 'package:opus_dart/opus_dart.dart';
import 'package:opus_flutter/opus_flutter.dart' as opus_flutter;

void main(){
    initOpus(await opus_flutter.load());
    print(getOpusVersion());
}
```


<a name="init_encoder_ctl"></a>
### Encoder CTL
To perform a CTL function on an Opus encoder, you can use encoderCtl() with the request and the value. Please note that although encoderCtl allows variadic arguments in the original Opus library, the dart implementation only allows one argument. This is fine for most use cases.
Be sure to include opus_defines.dart as it contains all the request names.
```dart
import 'package:opus_dart/opus_dart.dart';
import 'package:opus_dart/wrappers/opus_defines.dart';
import 'package:opus_flutter/opus_flutter.dart' as opus_flutter;

static const AUDIO_CHANNELS = 1;
static const SAMPLE_RATE = 8000;
static const OPUS_BITRATE = 15200;

SimpleOpusEncoder openCbrEncoder() {
  final opusEncoder = SimpleOpusEncoder(sampleRate: SAMPLE_RATE, channels: AUDIO_CHANNELS, application: Application.restrictedLowdely);
  opusEncoder.encoderCtl(request: OPUS_SET_VBR_REQUEST, value: 0);
  opusEncoder.encoderCtl(request: OPUS_SET_BITRATE_REQUEST, value: OPUS_BITRATE);
  return opusEncoder;
}
```