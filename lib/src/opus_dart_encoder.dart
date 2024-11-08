import 'proxy_ffi.dart';
import 'dart:typed_data';
import '../wrappers/opus_encoder.dart' as opus_encoder;
import '../wrappers/opus_defines.dart' as opus_defines;
import 'opus_dart_misc.dart';

/// An easy to use implementation of [OpusEncoder].
/// Don't forget to call [destroy] once you are done with it.
///
/// All method calls in this calls allocate their own memory everytime they are called.
/// See the [BufferedOpusEncoder] for an implementation with less allocation calls.
class SimpleOpusEncoder extends OpusEncoder {
  final Pointer<opus_encoder.OpusEncoder> _opusEncoder;
  @override
  final int sampleRate;
  @override
  final int channels;
  @override
  final Application application;
  bool _destroyed;
  @override
  bool get destroyed => _destroyed;

  SimpleOpusEncoder._(
      this._opusEncoder, this.sampleRate, this.channels, this.application)
      : _destroyed = false;

  /// Creates an new [SimpleOpusEncoder] based on the [sampleRate], [channels] and [application] type.
  /// See the matching fields for more information about these parameters.
  factory SimpleOpusEncoder(
      {required int sampleRate,
      required int channels,
      required Application application}) {
    Pointer<Int32> error = opus.allocator.call<Int32>(1);
    Pointer<opus_encoder.OpusEncoder> encoder = opus.encoder
        .opus_encoder_create(
            sampleRate, channels, _applicationCodes[application]!, error);
    try {
      if (error.value == opus_defines.OPUS_OK) {
        return SimpleOpusEncoder._(encoder, sampleRate, channels, application);
      } else {
        throw OpusException(error.value);
      }
    } finally {
      opus.allocator.free(error);
    }
  }

  int encoderCtl(
      {required int request, required int value}) {
    int ret = opus.encoder.opus_encoder_ctl(_opusEncoder, request, value);
    try {
      if (ret != opus_defines.OPUS_OK) {
        throw OpusException(ret);
      }
    } finally {
    }
    return ret;
  }

  /// Encodes a frame of pcm data, stored as Int16List.
  ///
  /// [input] needs to contain a valid count of samples for the opus codec.
  /// This means that `input.length == channels * sampleRate * frameTime` has to hold true for one of
  /// opus allowed frame times of 2.5ms, 5ms, 10ms, 20ms, 40ms and 60ms. E.g. if this encoder uses a
  /// [sampleRate] of 48000Hz and 2 [channels] and you intend to encode 20ms (=0.02s) of audio, then:
  /// `input.length = 2 * 48000Hz * 0.02s = 1920`.
  ///
  /// [maxOutputSizeBytes] is used to allocate the output buffer. It can be used to impose an instant
  /// upper limit on the bitrate, but must not be to small to hold the encoded data (or an exception will be thrown).
  /// The default value of [maxDataBytes] ensures that there is enough space.
  ///
  /// The returnes list contains the bytes of the encoded opus packet.
  ///
  /// [input] and the returned list are copied to and respectively from native memory.
  Uint8List encode(
      {required Int16List input, int maxOutputSizeBytes = maxDataBytes}) {
    Pointer<Int16> inputNative = opus.allocator.call<Int16>(input.length);
    inputNative.asTypedList(input.length).setAll(0, input);
    Pointer<Uint8> outputNative =
        opus.allocator.call<Uint8>(maxOutputSizeBytes);
    int sampleCountPerChannel = input.length ~/ channels;
    int outputLength = opus.encoder.opus_encode(_opusEncoder, inputNative,
        sampleCountPerChannel, outputNative, maxOutputSizeBytes);
    try {
      if (outputLength >= opus_defines.OPUS_OK) {
        Uint8List output =
            Uint8List.fromList(outputNative.asTypedList(outputLength));
        return output;
      } else {
        throw OpusException(outputLength);
      }
    } finally {
      opus.allocator.free(inputNative);
      opus.allocator.free(outputNative);
    }
  }

  /// Encodes a frame of pcm data, stored as Float32List.
  ///
  /// This method behaves just as [encode], so see there for more information.
  Uint8List encodeFloat(
      {required Float32List input, int maxOutputSizeBytes = maxDataBytes}) {
    Pointer<Float> inputNative = opus.allocator.call<Float>(input.length);
    inputNative.asTypedList(input.length).setAll(0, input);
    Pointer<Uint8> outputNative =
        opus.allocator.call<Uint8>(maxOutputSizeBytes);
    int sampleCountPerChannel = input.length ~/ channels;
    int outputLength = opus.encoder.opus_encode_float(_opusEncoder, inputNative,
        sampleCountPerChannel, outputNative, maxOutputSizeBytes);
    try {
      if (outputLength >= opus_defines.OPUS_OK) {
        Uint8List output =
            Uint8List.fromList(outputNative.asTypedList(outputLength));
        return output;
      } else {
        throw OpusException(outputLength);
      }
    } finally {
      opus.allocator.free(inputNative);
      opus.allocator.free(outputNative);
    }
  }

  @override
  void destroy() {
    if (!_destroyed) {
      _destroyed = true;
      opus.encoder.opus_encoder_destroy(_opusEncoder);
    }
  }
}

/// An implementation of [OpusEncoder] that uses preallocated buffers.
/// Don't forget to call [destroy] once you are done with it.
///
/// The idea behind this implementation is to reduce the amount of memory allocation calls.
/// Instead of allocating new buffers everytime something is encoded, the buffers are
/// allocated at initalization. Then, pcm  samples is directly written into the [inputBuffer],
/// the [inputBufferIndex] is updated, based on how many data where written, and
/// one of the encode methods is called. The encoded opus packet can then be accessed using
/// the [outputBuffer] getter.
///
/// ```
/// BufferedOpusEncoder encoder;
///
/// void example() {
///   // Get some pcm samples in s16le format
///   Int16List s16lePcm=getSomeData();
///   // Interpret the samples as bytes
///   Uint8List asBytes = s16lePcm.buffer
///       .asUint8List(s16lePcm.offsetInBytes, s16lePcm.lengthInBytes);
///   // Set the bytes to the input buffer
///   encoder.inputBuffer.setAll(0,asBytes);
///   // Update the inputBufferIndex with amount of bytes (not samples!) written
///   encoder.inputBufferIndex = asBytes.length;
///   // encode
///   encoder.encode();
///   // Do something with the result
///   doSomething(encoder.outputBuffer);
/// }
/// ```
class BufferedOpusEncoder extends OpusEncoder {
  final Pointer<opus_encoder.OpusEncoder> _opusEncoder;
  @override
  final int sampleRate;
  @override
  final int channels;
  @override
  final Application application;

  bool _destroyed;
  @override
  bool get destroyed => _destroyed;

  /// The size of the allocated the input buffer in bytes (not sampels).
  final int maxInputBufferSizeBytes;

  /// Indicates, how many bytes of data are currently stored in the [inputBuffer].
  int inputBufferIndex;

  final Pointer<Uint8> _inputBuffer;

  /// Returns the native input buffer backed by native memory.
  ///
  /// You should write the samples you want to encode as bytes into this buffer,
  /// update the [inputBufferIndex] accordingly and call one of the encode methods.
  ///
  /// You must not put more bytes then [maxInputBufferSizeBytes] into this buffer.
  Uint8List get inputBuffer =>
      _inputBuffer.asTypedList(maxInputBufferSizeBytes);

  /// The size of the allocated the output buffer. It can be used to impose an instant
  /// upper limit on the bitrate, but must not be to small to hold the encoded data.
  /// Otherwise, the enocde methods might throw an exception.
  /// The default value of [maxDataBytes] ensures that there is enough space.
  final int maxOutputBufferSizeBytes;
  int _outputBufferIndex;
  final Pointer<Uint8> _outputBuffer;

  /// The portion of the allocated output buffer that is currently filled with data.
  /// The data represents an opus packet in bytes.
  ///
  /// This method does not copy data from native memory to dart memory but
  /// rather gives a view backed by native memory.
  Uint8List get outputBuffer => _outputBuffer.asTypedList(_outputBufferIndex);

  BufferedOpusEncoder._(
      this._opusEncoder,
      this.sampleRate,
      this.channels,
      this.application,
      this._inputBuffer,
      this.maxInputBufferSizeBytes,
      this._outputBuffer,
      this.maxOutputBufferSizeBytes)
      : _destroyed = false,
        inputBufferIndex = 0,
        _outputBufferIndex = 0;

  /// Creates an new [BufferedOpusEncoder] based on the [sampleRate], [channels] and [application] type.
  /// The native allocated buffer size is determined by [maxInputBufferSizeBytes] and [maxOutputBufferSizeBytes].
  ///
  /// If [maxInputBufferSizeBytes] is omitted, it is callculated as 4 * [maxSamplesPerPacket].
  /// This ensures that the input buffer is big enough to hold the largest possible
  /// frame (120ms at 48000Hz) in float (=4 byte) representation.
  /// If you know that you only use input data in s16le representation you can manually set this to 2 * [maxSamplesPerPacket].
  ///
  /// [maxOutputBufferSizeBytes] defaults to [maxDataBytes] to guarantee that their is enough space in the
  /// output buffer for any possible valid input.
  ///
  /// For the other parameters, see the matching fields for more information.
  factory BufferedOpusEncoder(
      {required int sampleRate,
      required int channels,
      required Application application,
      int? maxInputBufferSizeBytes,
      int? maxOutputBufferSizeBytes}) {
    if (maxInputBufferSizeBytes == null) {
      maxInputBufferSizeBytes = 4 * maxSamplesPerPacket(sampleRate, channels);
    }
    if (maxOutputBufferSizeBytes == null) {
      maxOutputBufferSizeBytes = maxDataBytes;
    }
    Pointer<Int32> error = opus.allocator.call<Int32>(1);
    Pointer<Uint8> input = opus.allocator.call<Uint8>(maxInputBufferSizeBytes);
    Pointer<Uint8> output =
        opus.allocator.call<Uint8>(maxOutputBufferSizeBytes);
    Pointer<opus_encoder.OpusEncoder> encoder = opus.encoder
        .opus_encoder_create(
            sampleRate, channels, _applicationCodes[application]!, error);
    try {
      if (error.value == opus_defines.OPUS_OK) {
        return BufferedOpusEncoder._(encoder, sampleRate, channels, application,
            input, maxInputBufferSizeBytes, output, maxOutputBufferSizeBytes);
      } else {
        opus.allocator.free(input);
        opus.allocator.free(output);
        throw OpusException(error.value);
      }
    } finally {
      opus.allocator.free(error);
    }
  }

  /// Interpets [inputBufferIndex] bytes of the [inputBuffer] as s16le pcm data, and encodes them to the [outputBuffer].
  /// This means, that this method encodes `[inputBufferIndex]/2` samples, since `inputBufferIndex` is in bytes,
  /// and s16le uses two bytes per sample.
  ///
  /// The sample count must be a valid count of samples for the opus codec.
  /// This means that `sampleCount == channels * sampleRate * frameTime` has to hold true for one of
  /// opus allowed frame times of 2.5ms, 5ms, 10ms, 20ms, 40ms and 60ms. E.g. if this encoder uses a
  /// [sampleRate] of 48000Hz and 2 [channels] and you intend to encode 20ms (=0.02s) of audio, then:
  /// `sampleCount = 2 * 48000Hz * 0.02s = 1920`.
  ///
  /// The returned list is actually just the [outputBuffer].
  Uint8List encode() {
    int sampleCountPerChannel = inputBufferIndex ~/ (channels * 2);
    _outputBufferIndex = opus.encoder.opus_encode(
        _opusEncoder,
        _inputBuffer.cast<Int16>(),
        sampleCountPerChannel,
        _outputBuffer,
        maxOutputBufferSizeBytes);
    if (_outputBufferIndex >= opus_defines.OPUS_OK) {
      return outputBuffer;
    } else {
      throw OpusException(_outputBufferIndex);
    }
  }

  /// Interpets [inputBufferIndex] bytes of the [inputBuffer] as float pcm data, and encodes them to the [outputBuffer].
  /// This means, that this method encodes `[inputBufferIndex]/4` samples, since `inputBufferIndex` is in bytes,
  /// and the float represntation uses two bytes per sample.
  ///
  /// Except that the sample count is calculated by dividing the [inputBufferIndex] by 4 and not by 2,
  /// this method behaves just as [encode], so see there for more information.
  Uint8List encodeFloat() {
    int sampleCountPerChannel = inputBufferIndex ~/ (channels * 4);
    _outputBufferIndex = opus.encoder.opus_encode_float(
        _opusEncoder,
        _inputBuffer.cast<Float>(),
        sampleCountPerChannel,
        _outputBuffer,
        maxOutputBufferSizeBytes);
    if (_outputBufferIndex >= opus_defines.OPUS_OK) {
      return outputBuffer;
    } else {
      throw OpusException(_outputBufferIndex);
    }
  }

  @override
  void destroy() {
    if (!_destroyed) {
      _destroyed = true;
      opus.encoder.opus_encoder_destroy(_opusEncoder);
      opus.allocator.free(_inputBuffer);
      opus.allocator.free(_outputBuffer);
    }
  }
}

/// Abstract base class for opus encoders.
abstract class OpusEncoder {
  /// The sample rate in Hz for this encoder.
  /// Opus supports sample rates from 8kHz to 48kHz so this value must be between 8000 and 48000.
  int get sampleRate;

  /// Number of channels, must be 1 for mono or 2 for stereo.
  int get channels;

  /// The kind of application for which this encoders output is used.
  /// Setting the right application type can increase quality of the encoded frames.
  Application get application;

  /// Wheter this encoder was already destroyed by calling [destroy].
  /// If so, calling any method will result in an [OpusDestroyedError].
  bool get destroyed;

  /// Destroys this encoder by releasing all native resources.
  /// After this, it is no longer possible to encode using this encoder, so any further method call will throw an [OpusDestroyedError].
  void destroy();
}

/// Represents the different apllication types an [OpusEncoder] supports.
/// Setting the right apllication type when creating an encoder can improve quality.
enum Application { voip, audio, restrictedLowdely }

const Map<Application, int> _applicationCodes = const <Application, int>{
  Application.voip: opus_defines.OPUS_APPLICATION_VOIP,
  Application.audio: opus_defines.OPUS_APPLICATION_AUDIO,
  Application.restrictedLowdely:
      opus_defines.OPUS_APPLICATION_RESTRICTED_LOWDELAY
};
