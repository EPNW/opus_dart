// Notice that in this file, we import dart:ffi and not proxy_ffi.dart
import 'dart:ffi';
import 'dart:io' show Platform;

// For dart:ffi platforms, this can be a no-op (empty function)
Future<void> initFfi() async {}

DynamicLibrary openOpus() {
  DynamicLibrary lib;
  if (Platform.isWindows) {
    bool x64 = Platform.version.contains('x64');
    if (x64) {
      lib =
          new DynamicLibrary.open('C:/Users/Eric/Desktop/opus/libopus_x64.dll');
    } else {
      lib = new DynamicLibrary.open('path/to/libopus_x86.dll');
    }
  } else if (Platform.isLinux) {
    lib = new DynamicLibrary.open('/usr/local/lib/libopus.so');
  } else {
    throw new UnsupportedError('This programm does not support this platform!');
  }
  return lib;
}
