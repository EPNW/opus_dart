import 'dart:ffi';

import 'package:example/example.dart';
import 'package:ffi/ffi.dart';
import 'package:opus_dart/opus_bindings.dart';

void main(List<String> args) {
  DynamicLibrary lib = openOpus();
  OpusBindings bindings = OpusBindings(lib);
  Pointer<Char> version = bindings.opus_get_version_string();
  String dartVersion = version.cast<Utf8>().toDartString();
  print(dartVersion);
}
