import 'dart:async';
import 'dart:typed_data';

import 'package:meta/meta.dart';

import 'opus_dart_encoder.dart';
import 'opus_dart_decoder.dart';
import 'opus_dart_misc.dart';

/// Represents different frame times supported by opus.
enum FrameTime {
  /// 2.5ms
  ms2_5,
  // 5ms
  ms5,
  // 10ms
  ms10,
  // 20ms
  ms20,
  // 40ms
  ms40,
  // 60ms
  ms60
}

/// Used to encode a stream of pcm data to opus frames of constant time.
/// Each StreamOpusEncoder MUST ONLY be used once!
///
/// The different constructors determine, how the input stream is interpreted,
/// and of what type they have to be ([Float32List], [Int16List] or [Uint8List]).
/// If a [TypeError] occurs the stream you bound this transformer to is most
/// likly not a [Stream<Float32List>], [Stream<Float32List>] or [Stream<Float32List>].
///
/// When using a [Float32List] set the instances type parameter T to [double],
/// otherwise  (for [Int16List] or [Uint8List]) to [int].
class StreamOpusEncoder<T extends num>
    extends StreamTransformerBase<List<T>, Uint8List> {
  static int _calculateMaxSampleSize(
      int sampleRate, int channels, FrameTime frameTime) {
    int samplesPerMs = (channels * sampleRate) ~/ 1000;
    switch (frameTime) {
      case FrameTime.ms2_5:
        return 2 * samplesPerMs + (samplesPerMs ~/ 2);
      case FrameTime.ms5:
        return 5 * samplesPerMs;
      case FrameTime.ms10:
        return 10 * samplesPerMs;
      case FrameTime.ms20:
        return 20 * samplesPerMs;
      case FrameTime.ms40:
        return 40 * samplesPerMs;
      case FrameTime.ms60:
        return 60 * samplesPerMs;
      default:
        return null;
    }
  }

  final BufferedOpusEncoder _encoder;
  final Type _expect;

  /// The frames time determines, how much data need to be buffered before producing an encoded opus packet.
  final FrameTime frameTime;

  /// If the underlying stream is closed and this is `true`, the missing samples are filled up with zero to produce a final frame.
  /// If its set to `false`, an [UnfinishedFrameException] is thrown instead.
  final bool fillUpLastFrame;

  /// Indicates if the input data is interpreted as floats (`true`) or as s16le (`false`).
  final bool floats;

  /// If `true`, the encoded output is copied into dart memory befor passig it to any consumers.
  ///
  /// Otherwise, consumers get the output in native memory (and acutally, each time the same buffer).
  /// For most applicatons using the native memory (`false`) might be dangerous.
  final bool copyOutput;

  /// The sample rate in Hz for this encoder.
  /// Opus supports sample rates from 8kHz to 48kHz so this value must be between 8000 and 48000.
  int get sampleRate => _encoder.sampleRate;

  /// Number of channels, must be 1 for mono or 2 for stereo.
  int get channels => _encoder.channels;

  /// The kind of application for which this encoders output is used.
  /// Setting the right application type can increase quality of the encoded frames.
  Application get application => _encoder.application;

  /// Creates a new StreamOpusEncoder with [sampleRate], [channels] and
  /// [application] type that expects its input Lists to be [Float32List].
  ///
  /// For more information of the parameters see the documentation of [fillUpLastFrame] and [copyOutput].
  StreamOpusEncoder.float(
      {@required FrameTime frameTime,
      @required int sampleRate,
      @required int channels,
      @required Application application,
      bool fillUpLastFrame = true,
      bool copyOutput = true})
      : this._(frameTime, true, Float32List, sampleRate, channels, application,
            fillUpLastFrame, copyOutput);

  /// Creates a new StreamOpusEncoder with [sampleRate], [channels] and
  /// [application] type that expects its input Lists to be [Int16List].
  ///
  /// For more information of the parameters see the documentation of [fillUpLastFrame] and [copyOutput].
  StreamOpusEncoder.s16le(
      {@required FrameTime frameTime,
      @required int sampleRate,
      @required int channels,
      @required Application application,
      bool fillUpLastFrame = true,
      bool copyOutput = true})
      : this._(frameTime, false, Int16List, sampleRate, channels, application,
            fillUpLastFrame, copyOutput);

  /// Creates a new StreamOpusEncoder with [sampleRate], [channels] and
  /// [application] type that expects its input Lists to be bytes
  /// in form of [Uint8List].
  ///
  /// The bytes are either interpreted as floats (if [floatInput] is `true`),
  /// or as s16le (if [floatInput] is `false`).
  ///
  /// For more information of the parameters see the documentation of [fillUpLastFrame] and [copyOutput].
  StreamOpusEncoder.bytes(
      {@required FrameTime frameTime,
      @required bool floatInput,
      @required int sampleRate,
      @required int channels,
      @required Application application,
      bool fillUpLastFrame = true,
      bool copyOutput = true})
      : this._(frameTime, floatInput, Uint8List, sampleRate, channels,
            application, fillUpLastFrame, copyOutput);

  StreamOpusEncoder._(
      this.frameTime,
      this.floats,
      this._expect,
      int sampleRate,
      int channels,
      Application application,
      this.fillUpLastFrame,
      this.copyOutput)
      : this._encoder = BufferedOpusEncoder(
            sampleRate: sampleRate,
            channels: channels,
            application: application,
            maxInputBufferSizeBytes: (floats ? 4 : 2) *
                _calculateMaxSampleSize(sampleRate, channels, frameTime));

  /// Binds this stream to transfrom an other stream.
  /// The runtime type of the input `stream` must be castable to either
  /// [Stream<Float32List>], [Stream<Int16List>] or [Stream<Uint8List>]
  /// depending on what constructor was used or a [TypeError] will be thrown.
  @override
  Stream<Uint8List> bind(Stream<List<T>> stream) async* {
    try {
      int dataIndex;
      Uint8List bytes;
      int available;
      int max;
      int use;
      Uint8List inputBuffer = _encoder.inputBuffer;
      Stream<Uint8List> mapped;
      if (_expect == Int16List) {
        mapped = stream.cast<Int16List>().map<Uint8List>((Int16List s16le) =>
            s16le.buffer.asUint8List(s16le.offsetInBytes, s16le.lengthInBytes));
      } else if (_expect == Float32List) {
        mapped = stream.cast<Float32List>().map<Uint8List>(
            (Float32List floats) => floats.buffer
                .asUint8List(floats.offsetInBytes, floats.lengthInBytes));
      } else {
        mapped = stream.cast<Uint8List>();
      }
      await for (Uint8List pcm in mapped) {
        bytes = pcm;
        dataIndex = 0;
        available = bytes.lengthInBytes;
        while (available > 0) {
          max = _encoder.maxInputBufferSizeBytes - _encoder.inputBufferIndex;
          use = max < available ? max : available;
          inputBuffer.setRange(_encoder.inputBufferIndex,
              _encoder.inputBufferIndex + use, bytes, dataIndex);
          dataIndex += use;
          _encoder.inputBufferIndex += use;
          available = bytes.lengthInBytes - dataIndex;
          if (_encoder.inputBufferIndex == _encoder.maxInputBufferSizeBytes) {
            Uint8List bytes =
                floats ? _encoder.encodeFloat() : _encoder.encode();
            yield copyOutput ? Uint8List.fromList(bytes) : bytes;
            _encoder.inputBufferIndex = 0;
          }
        }
      }
      if (_encoder.maxInputBufferSizeBytes != 0) {
        if (fillUpLastFrame) {
          _encoder.inputBuffer.setAll(
              _encoder.inputBufferIndex,
              Uint8List(_encoder.maxInputBufferSizeBytes -
                  _encoder.inputBufferIndex));
          _encoder.inputBufferIndex = _encoder.maxInputBufferSizeBytes;
          Uint8List bytes = floats ? _encoder.encodeFloat() : _encoder.encode();
          yield copyOutput ? Uint8List.fromList(bytes) : bytes;
        } else {
          int missingSamples =
              (_encoder.maxInputBufferSizeBytes - _encoder.inputBufferIndex) ~/
                  (floats ? 4 : 2);
          throw UnfinishedFrameException._(missingSamples: missingSamples);
        }
      }
    } finally {
      destroy();
    }
  }

  /// Manually destroys this encoder. If it was bound, this should have happend automatically; then calling destory is a no-op.
  void destroy() => _encoder.destroy();
}

/// Thrown if an [StreamOpusEncoder] finished with insufficient samples left to produce a final frame.
class UnfinishedFrameException implements Exception {
  /// The amount of samples that are missing for the final frame.
  final int missingSamples;
  const UnfinishedFrameException._({@required this.missingSamples});

  @override
  String toString() {
    return 'UnfinishedFrameException: The source stream is closed, but there are $missingSamples samples missing to encode the next frame';
  }
}

/// Used to decode a stream of opus packets to pcm data.
/// Each element in the input stream MUST contain a whole opus packet.
/// Each StreamOpusEncoder MUST ONLY be used once!
/// A `null` element in the input stream is interpreted as packet loss.
///
/// If packet loss is reported [forwardErrorCorrection] might try to recover lost packages.
///
/// The different constructors determine, if the output stream is actually
/// a stream of [Float32List], [Int16List] or [Uint8List], so it's safe to
/// cast the resulting stream to the corresponding  format.

class StreamOpusDecoder extends StreamTransformerBase<Uint8List, List<num>> {
  /// If forward error correction (fec) should be enabled.
  ///
  /// This is only possible, if the input packets were encoded by an
  /// encoder which was using forward error correction.
  final bool forwardErrorCorrection;

  /// Indicates if the input data is decoded to floats (`true`) or to s16le (`false`).
  final bool floats;

  /// If `true`, the decoded output is copied into dart memory befor passig it to any consumers.
  ///
  /// Otherwise, consumers get the output in native memory (and acutally, each time the same buffer).
  /// For most applicatons, using the native memory (`false`) might be dangerous.
  final bool copyOutput;

  /// The sample rate in Hz for this decoder.
  /// Opus supports sample rates from 8kHz to 48kHz so this value must be between 8000 and 48000.
  int get sampleRate => _decoder.sampleRate;

  /// Number of channels, must be 1 for mono or 2 for stereo.
  int get channels => _decoder.channels;

  /// If the packet is decoded to floats, autoSoftClip can be set to `true` to perform sofclipping
  /// right after decoding without additional memory copying.
  ///
  /// Read more about soft clipping at the toplevel [pcmSoftClip] function.
  final bool autoSoftClip;

  final BufferedOpusDecoder _decoder;

  bool _lastPacketLost;

  final Type _outputType;

  /// Creates a new StreamOpusDecoder with [sampleRate] and [channels]
  /// that outputs [Float32List], so it's safe to cast the output stream.
  ///
  /// For more information of the parameters see the documentation of [forwardErrorCorrection], [copyOutput] and [autoSoftClip].
  StreamOpusDecoder.float(
      {@required int sampleRate,
      @required int channels,
      bool forwardErrorCorrection = false,
      bool copyOutput = true,
      bool autoSoftClip = false})
      : this._(true, Float32List, sampleRate, channels, forwardErrorCorrection,
            copyOutput, autoSoftClip);

  /// Creates a new StreamOpusDecoder with [sampleRate] and [channels]
  /// that outputs [Int16List], so it's safe to cast the output stream.
  ///
  /// For more information of the parameters see the documentation of [forwardErrorCorrection] and [copyOutput].
  ///
  /// This constructor does not have an [autoSoftClip] parameter, since softclipping is only possible when decoding
  /// to float output.
  StreamOpusDecoder.s16le(
      {@required int sampleRate,
      @required int channels,
      bool forwardErrorCorrection = false,
      bool copyOutput = true})
      : this._(false, Int16List, sampleRate, channels, forwardErrorCorrection,
            copyOutput, null);

  /// Creates a new StreamOpusDecoder with [sampleRate] and [channels]
  /// that outputs plain bytes (in form of [Uint8List]), so it's safe to cast the output stream.
  ///
  /// The output bytes either represent floats (if [floatOutput] is `true`),
  /// or s16le (if [floatOutput] is `false`).
  ///
  /// For more information of the parameters see the documentation of [forwardErrorCorrection], [copyOutput].
  /// If the decoded output is not in float format ([floatOutput] is `false`) [autoSoftClip] is forced to `null`,
  /// since you can not softclip s16le output.
  StreamOpusDecoder.bytes(
      {@required bool floatOutput,
      @required int sampleRate,
      @required int channels,
      bool forwardErrorCorrection = false,
      bool copyOutput = true,
      bool autoSoftClip = false})
      : this._(
            floatOutput,
            Uint8List,
            sampleRate,
            channels,
            forwardErrorCorrection,
            copyOutput,
            floatOutput == true ? autoSoftClip : null);

  StreamOpusDecoder._(
      this.floats,
      this._outputType,
      int sampleRate,
      int channels,
      this.forwardErrorCorrection,
      this.copyOutput,
      this.autoSoftClip)
      : this._lastPacketLost = false,
        this._decoder = BufferedOpusDecoder(
            sampleRate: sampleRate,
            channels: channels,
            maxOutputBufferSizeBytes:
                (floats ? 2 : 4) * maxSamplesPerPacket(sampleRate, channels));

  void _reportPacketLoss() {
    if (floats) {
      _decoder.decodeFloat(
          fec: false,
          loss: _decoder.lastPacketDurationMs,
          autoSoftClip: autoSoftClip);
    } else {
      _decoder.decode(fec: false, loss: _decoder.lastPacketDurationMs);
    }
  }

  List<num> _output() {
    Uint8List output = _decoder.outputBuffer;
    if (copyOutput) {
      output = Uint8List.fromList(output);
    }
    if (_outputType == Float32List) {
      return output.buffer
          .asFloat32List(output.offsetInBytes, output.lengthInBytes ~/ 4);
    } else if (_outputType == Int16List) {
      return output.buffer
          .asInt16List(output.offsetInBytes, output.lengthInBytes ~/ 2);
    } else {
      return output;
    }
  }

  /// Binds this stream to transfrom an other stream.
  /// A `null` element in the input stream is interpreted as packet loss.
  ///
  /// The runtime type of the returned stream is either
  /// [Stream<Float32List>], [Stream<Int16List>] or [Stream<Uint8List>]
  /// depending on what constructor was used, so it is safe to use the
  /// returned streams `cast` method to obtain the stream in that format.
  @override
  Stream<List<num>> bind(Stream<Uint8List> stream) async* {
    await for (Uint8List packet in stream) {
      if (packet == null) {
        if (forwardErrorCorrection) {
          _decoder.inputBufferIndex = 0;
          if (_lastPacketLost) {
            // We've also lost the previous packet, which we can not restore now
            // So tell the decoder
            _reportPacketLoss();
          }
        } else {
          // There is no fec, so tell the decoder we lost a package
          _reportPacketLoss();
        }
        _lastPacketLost = true;
      } else {
        _decoder.inputBuffer.setAll(0, packet);
        _decoder.inputBufferIndex = packet.length;
        if (_lastPacketLost && forwardErrorCorrection) {
          // The last packet was lost, attempt to restore it
          if (floats) {
            _decoder.decodeFloat(
                fec: true, loss: _decoder.lastPacketDurationMs);
          } else {
            _decoder.decode(fec: true, loss: _decoder.lastPacketDurationMs);
          }
          yield _output();
        }
        _lastPacketLost = false;
        if (floats) {
          _decoder.decodeFloat(fec: false);
        } else {
          _decoder.decode(fec: false);
        }
        yield _output();
      }
    }
  }
}
