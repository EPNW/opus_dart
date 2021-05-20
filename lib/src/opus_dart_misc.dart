import 'dart:ffi';
import 'dart:convert';

import 'package:ffi/ffi.dart' as ffipackage;

import '../wrappers/opus_libinfo.dart' as opus_libinfo;
import '../wrappers/opus_encoder.dart' as opus_encoder;
import '../wrappers/opus_decoder.dart' as opus_decoder;

/// Max bitstream size of a single opus packet.
///
/// See [here](https://stackoverflow.com/questions/55698317/what-value-to-use-for-libopus-encoder-max-data-bytes-field)
/// for an explanation how this was calculated.
const int maxDataBytes = 3 * 1275;

/// Calculates, how much sampels a single opus package at [sampleRate] with [channels] may contain.
///
/// A single package may contain up 120ms of audio. This value is reached by combining up to 3 frames of 40ms audio.
int maxSamplesPerPacket(int sampleRate, int channels) => ((sampleRate *
            channels *
            120) /
        1000)
    .ceil(); //Some sample rates may not be dividable by 1000, so use ceiling instead of integer division.

final Map<Type, int> _sizes = {
  Double: sizeOf<Double>(),
  Float: sizeOf<Float>(),
  Int8: sizeOf<Int8>(),
  Int16: sizeOf<Int16>(),
  Int32: sizeOf<Int32>(),
  Int64: sizeOf<Int64>(),
  IntPtr: sizeOf<IntPtr>(),
  Pointer: sizeOf<Pointer>(),
  Uint8: sizeOf<Uint8>(),
  Uint16: sizeOf<Uint16>(),
  Uint32: sizeOf<Uint32>(),
  Uint64: sizeOf<Uint64>()
};

Pointer<T> allocate<T extends NativeType>({required int count}) {
  int? elementSize = _sizes[T];
  if (elementSize == null) {
    throw new UnsupportedError(
        'The size of type $T could not be calculated! Alloacting this type is not allowed!');
  }
  int byteCount = count * elementSize;
  return ffipackage.malloc.allocate<T>(byteCount);
}

void free(Pointer<NativeType> pointer) {
  ffipackage.malloc.free(pointer);
}

/// Returns the version of the native libopus library.
String getOpusVersion() {
  return _asString(opus.libinfo.opus_get_version_string());
}

String _asString(Pointer<Uint8> pointer) {
  int i = 0;
  while (pointer.elementAt(i).value != 0) {
    i++;
  }
  return utf8.decode(pointer.asTypedList(i));
}

/// Thrown when a native exception occurs.
class OpusException implements Exception {
  final int errorCode;
  const OpusException(this.errorCode);
  @override
  String toString() {
    String error = _asString(opus.libinfo.opus_strerror(errorCode));
    return 'OpusException $errorCode: $error';
  }
}

/// Thrown when attempting to call an method on an already destroyed encoder or decoder.
class OpusDestroyedError extends StateError {
  OpusDestroyedError.encoder()
      : super(
            'OpusDestroyedException: This OpusEncoder was already destroyed!');
  OpusDestroyedError.decoder()
      : super(
            'OpusDestroyedException: This OpusDecoder was already destroyed!');
}

late final ApiObject opus;

class ApiObject {
  final opus_libinfo.FunctionsAndGlobals libinfo;
  final opus_encoder.FunctionsAndGlobals encoder;
  final opus_decoder.FunctionsAndGlobals decoder;

  ApiObject(DynamicLibrary opus)
      : libinfo = new opus_libinfo.FunctionsAndGlobals(opus),
        encoder = new opus_encoder.FunctionsAndGlobals(opus),
        decoder = new opus_decoder.FunctionsAndGlobals(opus);
}

/// Must be called to initalize this library.
///
/// The [DynamicLibrary] `opusLib` must point to a platform native libopus library with the appropriate version.
/// See the README for more information about loading and versioning.
void initOpus(DynamicLibrary opusLib) {
  opus = new ApiObject(opusLib);
}
