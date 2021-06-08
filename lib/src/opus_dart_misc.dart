import 'dart:convert';
import 'proxy_ffi.dart';

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
  final Allocator allocator;

  ApiObject(DynamicLibrary opus, this.allocator)
      : libinfo = new opus_libinfo.FunctionsAndGlobals(opus),
        encoder = new opus_encoder.FunctionsAndGlobals(opus),
        decoder = new opus_decoder.FunctionsAndGlobals(opus);
}

/// Must be called to initalize this library.
///
/// On platforms where dart:ffi is available, the [dart:ffi DynamicLibrary](https://api.dart.dev/stable/2.12.0/dart-ffi/DynamicLibrary-class.html) `opusLib`
/// must point to a platform native libopus library with the appropriate version.
///
/// On platforms where there is no dart:ffi, most notabley on the web, `opusLib`
/// should be a [web_ffi DynamicLibrary](https://pub.dev/documentation/web_ffi/latest/web_ffi/DynamicLibrary-class.html). The [web_ffi Memory](https://pub.dev/documentation/web_ffi/latest/web_ffi_modules/Memory/init.html) object should
/// have been initalized before calling this function. This function registers all
/// Opaque types for you.
///
/// See the README for more information about loading and versioning.
void initOpus(DynamicLibrary opusLib) {
  opus = createApiObject(opusLib);
}
