import 'dart:ffi';
import 'dart:io' show Platform;
import 'package:opus_dart/opus_dart.dart';

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
  initOpus(lib);
  print(getOpusVersion());
}
