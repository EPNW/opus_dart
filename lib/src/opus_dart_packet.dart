import 'dart:ffi';
import 'dart:typed_data';
import 'generated_bindings.dart' as bindings;
import 'opus_dart_misc.dart';

/// Bundles utility functions to examin opus packets.
///
/// All methods copy the input data into native memory.
abstract class OpusPacketUtils {
  /// Returns the amount of samples in a [packet] given a [sampleRate].
  static int getSampleCount(
      {required Uint8List packet, required int sampleRate}) {
    Pointer<Uint8> data = opus.allocator.call<Uint8>(packet.length);
    data.asTypedList(packet.length).setAll(0, packet);
    try {
      int sampleCount = opus.bindings.opus_packet_get_nb_samples(
          data.cast<UnsignedChar>(), packet.length, sampleRate);
      if (sampleCount >= bindings.OPUS_OK) {
        return sampleCount;
      } else {
        throw OpusException(sampleCount);
      }
    } finally {
      opus.allocator.free(data);
    }
  }

  /// Returns the amount of frames in a [packet].
  static int getFrameCount({required Uint8List packet}) {
    Pointer<Uint8> data = opus.allocator.call<Uint8>(packet.length);
    data.asTypedList(packet.length).setAll(0, packet);
    try {
      int frameCount = opus.bindings
          .opus_packet_get_nb_frames(data.cast<UnsignedChar>(), packet.length);
      if (frameCount >= bindings.OPUS_OK) {
        return frameCount;
      } else {
        throw OpusException(frameCount);
      }
    } finally {
      opus.allocator.free(data);
    }
  }

  /// Returns the amount of samples per frame in a [packet] given a [sampleRate].
  static int getSamplesPerFrame(
      {required Uint8List packet, required int sampleRate}) {
    Pointer<Uint8> data = opus.allocator.call<Uint8>(packet.length);
    data.asTypedList(packet.length).setAll(0, packet);
    try {
      int samplesPerFrame = opus.bindings.opus_packet_get_samples_per_frame(
          data.cast<UnsignedChar>(), sampleRate);
      if (samplesPerFrame >= bindings.OPUS_OK) {
        return samplesPerFrame;
      } else {
        throw OpusException(samplesPerFrame);
      }
    } finally {
      opus.allocator.free(data);
    }
  }

  /// Returns the channel count from a [packet]
  static int getChannelCount({required Uint8List packet}) {
    Pointer<Uint8> data = opus.allocator.call<Uint8>(packet.length);
    data.asTypedList(packet.length).setAll(0, packet);
    try {
      int channelCount =
          opus.bindings.opus_packet_get_nb_channels(data.cast<UnsignedChar>());
      if (channelCount >= bindings.OPUS_OK) {
        return channelCount;
      } else {
        throw OpusException(channelCount);
      }
    } finally {
      opus.allocator.free(data);
    }
  }

  /// Returns the bandwidth from a [packet]
  static int getBandwidth({required Uint8List packet}) {
    Pointer<Uint8> data = opus.allocator.call<Uint8>(packet.length);
    data.asTypedList(packet.length).setAll(0, packet);
    try {
      int bandwidth =
          opus.bindings.opus_packet_get_bandwidth(data.cast<UnsignedChar>());
      if (bandwidth >= bindings.OPUS_OK) {
        return bandwidth;
      } else {
        throw OpusException(bandwidth);
      }
    } finally {
      opus.allocator.free(data);
    }
  }
}
