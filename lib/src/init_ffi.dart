import 'dart:ffi';
import 'package:ffi/ffi.dart' as ffipackage;
import 'opus_dart_misc.dart' show ApiObject;

ApiObject createApiObject(DynamicLibrary library) {
  // The casts to dynamics are necessary to pass static analysis since
  // dart analysis does not get the imports right when differentiating
  // between web_ffi and dart:ffi
  return new ApiObject(library as dynamic, ffipackage.malloc as dynamic);
}
