import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:meta/meta.dart';
import '../wrappers/opus_decoder.dart' as opus_decoder;
import '../wrappers/opus_defines.dart' as opus_defines;
import 'opus_dart_misc.dart';

/// Bundles utility functions to examin opus packets.
///
/// All methods copy the input data into native memory.
abstract class OpusPacketUtils {
  /// Returns the amount of samples in a [packet] given a [sampleRate].
  static int getSampleCount(
      {@required Uint8List packet, @required int sampleRate}) {
    Pointer<Uint8> data = allocate<Uint8>(count: packet.length);
    data.asTypedList(packet.length).setAll(0, packet);
    try {
      int sampleCount = opus_decoder.opus_packet_get_nb_samples(
          data, packet.length, sampleRate);
      if (sampleCount >= opus_defines.OPUS_OK) {
        return sampleCount;
      } else {
        throw new OpusException(sampleCount);
      }
    } finally {
      free(data);
    }
  }

  /// Returns the amount of frames in a [packet].
  static int getFrameCount({@required Uint8List packet}) {
    Pointer<Uint8> data = allocate<Uint8>(count: packet.length);
    data.asTypedList(packet.length).setAll(0, packet);
    try {
      int frameCount =
          opus_decoder.opus_packet_get_nb_frames(data, packet.length);
      if (frameCount >= opus_defines.OPUS_OK) {
        return frameCount;
      } else {
        throw new OpusException(frameCount);
      }
    } finally {
      free(data);
    }
  }

  /// Returns the amount of samples per frame in a [packet] given a [sampleRate].
  static int getSamplesPerFrame(
      {@required Uint8List packet, @required int sampleRate}) {
    Pointer<Uint8> data = allocate<Uint8>(count: packet.length);
    data.asTypedList(packet.length).setAll(0, packet);
    try {
      int samplesPerFrame =
          opus_decoder.opus_packet_get_samples_per_frame(data, sampleRate);
      if (samplesPerFrame >= opus_defines.OPUS_OK) {
        return samplesPerFrame;
      } else {
        throw new OpusException(samplesPerFrame);
      }
    } finally {
      free(data);
    }
  }

  /// Returns the channel count from a [packet]
  static int getChannelCount({@required Uint8List packet}) {
    Pointer<Uint8> data = allocate<Uint8>(count: packet.length);
    data.asTypedList(packet.length).setAll(0, packet);
    try {
      int channelCount = opus_decoder.opus_packet_get_nb_channels(data);
      if (channelCount >= opus_defines.OPUS_OK) {
        return channelCount;
      } else {
        throw new OpusException(channelCount);
      }
    } finally {
      free(data);
    }
  }

  /// Returns the bandwidth from a [packet]
  static int getBandwidth({@required Uint8List packet}) {
    Pointer<Uint8> data = allocate<Uint8>(count: packet.length);
    data.asTypedList(packet.length).setAll(0, packet);
    try {
      int bandwidth = opus_decoder.opus_packet_get_bandwidth(data);
      if (bandwidth >= opus_defines.OPUS_OK) {
        return bandwidth;
      } else {
        throw new OpusException(bandwidth);
      }
    } finally {
      free(data);
    }
  }
}
