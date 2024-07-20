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
Starting version 4 of this package, [ffigen](https://pub.dev/packages/ffigen) is used to generated the bindings.

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
The generated bindings can be found in the library `opus_bindings`. The main class, containing all the functions from the opus c headers is `OpusBindings`.
An example to print the opus version using the bindings api would be:
```dart
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:opus_dart/opus_bindings.dart';

void main(List<String> args) {
  OpusBindings bindings = OpusBindings(lib);
  Pointer<Char> version = bindings.opus_get_version_string();
  String dartVersion = version.cast<Utf8>().toDartString();
  print(dartVersion);
}
```

<a name="init_friendly"></a>
### The Dart Friendly API
If using the dart firendly library opus_dart, you have to initialize it using the toplevel `initOpus` function.
This would look like:
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
`lib` is a [dart:ffi DynamicLibrary](https://api.dart.dev/stable/3.4.3/dart-ffi/DynamicLibrary-class.html) instance, pointing to libopus. You can dynamically load it:
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

**Attention:** This package does not contain any binaries, and even if libopus is open source, no source files (except the headers needed for binding generation) are included in this package either, since there is [no stable native build system for dart:ffi](https://github.com/dart-lang/sdk/issues/36712) at the moment.
It's up to you to get binaries and to distribute them with your application.
Keep in mind that you need a dynamic library for all operating systems and architectures you want to support.
Whether you use prebuild binaries or compile libopus from [source](https://github.com/xiph/opus/) yourself, the version you use should match this packages wrapped version (see above). An example to build Opus can be found in the [Dockerfile on this packages GitHub page](https://github.com/EPNW/opus_dart/blob/master/Dockerfile).

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