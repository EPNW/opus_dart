import 'dart:ffi';
import 'package:ffi/ffi.dart' as ffipackage;
import 'opus_dart_misc.dart' show ApiObject;

ApiObject createApiObject(DynamicLibrary library) {
  return new ApiObject(library, ffipackage.malloc);
}
