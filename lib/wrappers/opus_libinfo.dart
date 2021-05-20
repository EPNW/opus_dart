/// Contains methods and structs from the opus_libinfo group of opus_defines.h.
/// SHOULD be imported as opus_libinfo and MUST be initalized using its [init] function.
///
/// AUTOMATICALLY GENERATED FILE. DO NOT MODIFY.

library opus_libinfo;

import 'dart:ffi' as ffi;

typedef _opus_get_version_string_C = ffi.Pointer<ffi.Uint8> Function();
typedef _opus_get_version_string_Dart = ffi.Pointer<ffi.Uint8> Function();
typedef _opus_strerror_C = ffi.Pointer<ffi.Uint8> Function(
  ffi.Int32 error,
);
typedef _opus_strerror_Dart = ffi.Pointer<ffi.Uint8> Function(
  int error,
);

class FunctionsAndGlobals {
  FunctionsAndGlobals(ffi.DynamicLibrary _dynamicLibrary)
      : _opus_get_version_string = _dynamicLibrary.lookupFunction<
            _opus_get_version_string_C, _opus_get_version_string_Dart>(
          'opus_get_version_string',
        ),
        _opus_strerror = _dynamicLibrary
            .lookupFunction<_opus_strerror_C, _opus_strerror_Dart>(
          'opus_strerror',
        );

  /// Gets the libopus version string.
  ///
  /// Applications may look for the substring "-fixed" in the version string to determine whether they have a fixed-point or floating-point build at runtime.
  ///
  /// @returns Version string
  ffi.Pointer<ffi.Uint8> opus_get_version_string() {
    return _opus_get_version_string();
  }

  final _opus_get_version_string_Dart _opus_get_version_string;

  /// Converts an opus error code into a human readable string.
  ///
  /// @param[in] error <tt>int</tt>: Error number
  /// @returns Error string
  ffi.Pointer<ffi.Uint8> opus_strerror(
    int error,
  ) {
    return _opus_strerror(error);
  }

  final _opus_strerror_Dart _opus_strerror;
}
