import 'dart:ffi';

import 'package:ffi/ffi.dart';

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

/// Must be called to initalize this library.
///
/// The [DynamicLibrary] `opus` must point to a platform native libopus library with the appropriate version.
/// See the README for more information about loading and versioning.
void initOpus(DynamicLibrary opus) {
  opus_libinfo.init(opus);
  opus_encoder.init(opus);
  opus_decoder.init(opus);
}

/// Returns the version of the native libopus library.
String getOpusVersion() {
  return Utf8.fromUtf8(opus_libinfo.opus_get_version_string());
}

/// Thrown when a native exception occurs.
class OpusException implements Exception {
  final int errorCode;
  const OpusException(this.errorCode);
  @override
  String toString() {
    String error = Utf8.fromUtf8(opus_libinfo.opus_strerror(errorCode));
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
