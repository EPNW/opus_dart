import 'proxy_ffi.dart';
import 'dart:typed_data';
import '../wrappers/opus_decoder.dart' as opus_decoder;
import '../wrappers/opus_defines.dart' as opus_defines;
import 'opus_dart_misc.dart';

int _packetDuration(int samples, int channels, int sampleRate) =>
    ((1000 * samples) ~/ (channels)) ~/ sampleRate;

/// Soft clips the [input] to a range from -1 to 1 and returns
/// the result.
///
/// If the samples are already in this range, nothing happens
/// to the samples.
///
/// [input] is copied into native memory.
/// If you are using a [BufferedOpusDecoder], take a look at it's [pcmSoftClipOutputBuffer]
/// method instead, since it avoids unnecessary memory copying.
Float32List pcmSoftClip({required Float32List input, required int channels}) {
  Pointer<Float> nativePcm = opus.allocator.call<Float>(input.length);
  nativePcm.asTypedList(input.length).setAll(0, input);
  Pointer<Float> nativeBuffer = opus.allocator.call<Float>(channels);
  try {
    opus.decoder.opus_pcm_soft_clip(
        nativePcm, input.length ~/ channels, channels, nativeBuffer);
    return Float32List.fromList(nativePcm.asTypedList(input.length));
  } finally {
    opus.allocator.free(nativePcm);
    opus.allocator.free(nativeBuffer);
  }
}

/// An easy to use implementation of [OpusDecoder].
/// Don't forget to call [destroy] once you are done with it.
///
/// All method calls in this calls allocate their own memory everytime they are called.
/// See the [BufferedOpusDecoder] for an implementation with less allocation calls.
class SimpleOpusDecoder extends OpusDecoder {
  final Pointer<opus_decoder.OpusDecoder> _opusDecoder;
  @override
  final int sampleRate;
  @override
  final int channels;
  bool _destroyed;
  @override
  bool get destroyed => _destroyed;
  @override
  int? get lastPacketDurationMs => _lastPacketDurationMs;
  int? _lastPacketDurationMs;

  final Pointer<Float> _softClipBuffer;

  final int _maxSamplesPerPacket;

  SimpleOpusDecoder._(
      this._opusDecoder, this.sampleRate, this.channels, this._softClipBuffer)
      : _destroyed = false,
        this._maxSamplesPerPacket = maxSamplesPerPacket(sampleRate, channels);

  /// Creates an new [SimpleOpusDecoder] based on the [sampleRate] and [channels].
  /// See the matching fields for more information about these parameters.
  factory SimpleOpusDecoder({required int sampleRate, required int channels}) {
    Pointer<Int32> error = opus.allocator.call<Int32>(1);
    Pointer<Float> softClipBuffer = opus.allocator.call<Float>(channels);
    Pointer<opus_decoder.OpusDecoder> decoder =
        opus.decoder.opus_decoder_create(sampleRate, channels, error);
    try {
      if (error.value == opus_defines.OPUS_OK) {
        return SimpleOpusDecoder._(
            decoder, sampleRate, channels, softClipBuffer);
      } else {
        opus.allocator.free(softClipBuffer);
        throw OpusException(error.value);
      }
    } finally {
      opus.allocator.free(error);
    }
  }

  /// Decodes an opus packet to s16le samples, represented as [Int16List].
  /// Use `null` as [input] to indicate packet loss.
  ///
  /// On packet loss, the [loss] parameter needs to be exactly the duration
  /// of audio that is missing in milliseconds, otherwise the decoder will
  /// not be in the optimal state to decode the next incoming packet.
  /// If you don't know the duration, leave it `null` and [lastPacketDurationMs]
  /// will be used as an estimate instead.
  ///
  /// If you want to use forward error correction, don't report packet loss
  /// by calling this method with `null` as input (unless it is a real packet
  /// loss), but instead, wait for the next packet and call this method with
  /// the recieved packet, [fec] set to `true` and [loss] to the missing duration
  /// of the missing audio in ms (as above). Then, call this method a second time with
  /// the same packet, but with [fec] set to `false`. You can read more about the
  /// correct usage of forward error correction [here](https://stackoverflow.com/questions/49427579/how-to-use-fec-feature-for-opus-codec).
  /// Note: A real packet loss occurse if you lose two or more packets in a row.
  /// You are only able to restore the last lost packet and the other packets are
  /// really lost. So for them, you have to report packet loss.
  ///
  /// The input bytes need to represent a whole packet!
  @override
  Int16List decode({Uint8List? input, bool fec = false, int? loss}) {
    Pointer<Int16> outputNative =
        opus.allocator.call<Int16>(_maxSamplesPerPacket);
    Pointer<Uint8> inputNative;
    if (input != null) {
      inputNative = opus.allocator.call<Uint8>(input.length);
      inputNative.asTypedList(input.length).setAll(0, input);
    } else {
      inputNative = nullptr;
    }
    int frameSize;
    if (input == null || fec) {
      frameSize = _estimateLoss(loss, lastPacketDurationMs);
    } else {
      frameSize = _maxSamplesPerPacket;
    }
    int outputSamplesPerChannel = opus.decoder.opus_decode(_opusDecoder,
        inputNative, input?.length ?? 0, outputNative, frameSize, fec ? 1 : 0);
    try {
      if (outputSamplesPerChannel >= opus_defines.OPUS_OK) {
        _lastPacketDurationMs =
            _packetDuration(outputSamplesPerChannel, channels, sampleRate);
        return Int16List.fromList(
            outputNative.asTypedList(outputSamplesPerChannel * channels));
      } else {
        throw OpusException(outputSamplesPerChannel);
      }
    } finally {
      opus.allocator.free(inputNative);
      opus.allocator.free(outputNative);
    }
  }

  /// Decodes an opus packet to float samples, represented as [Float32List].
  /// Use `null` as [input] to indicate packet loss.
  ///
  /// If [autoSoftClip] is true, softcliping is applied to the output.
  /// This behaves just like  the top level [pcmSoftClip] function,
  /// but is more effective since it doesn't need to copy the samples,
  /// because they already are in the native buffer.
  ///
  /// Apart from that, this method behaves just as [decode], so see there for more information.
  @override
  Float32List decodeFloat(
      {Uint8List? input,
      bool fec = false,
      bool autoSoftClip = false,
      int? loss}) {
    Pointer<Float> outputNative =
        opus.allocator.call<Float>(_maxSamplesPerPacket);
    Pointer<Uint8> inputNative;
    if (input != null) {
      inputNative = opus.allocator.call<Uint8>(input.length);
      inputNative.asTypedList(input.length).setAll(0, input);
    } else {
      inputNative = nullptr;
    }
    int frameSize;
    if (input == null || fec) {
      frameSize = _estimateLoss(loss, lastPacketDurationMs);
    } else {
      frameSize = _maxSamplesPerPacket;
    }
    int outputSamplesPerChannel = opus.decoder.opus_decode_float(_opusDecoder,
        inputNative, input?.length ?? 0, outputNative, frameSize, fec ? 1 : 0);
    try {
      if (outputSamplesPerChannel >= opus_defines.OPUS_OK) {
        _lastPacketDurationMs =
            _packetDuration(outputSamplesPerChannel, channels, sampleRate);
        if (autoSoftClip) {
          opus.decoder.opus_pcm_soft_clip(outputNative,
              outputSamplesPerChannel ~/ channels, channels, _softClipBuffer);
        }
        return Float32List.fromList(
            outputNative.asTypedList(outputSamplesPerChannel * channels));
      } else {
        throw OpusException(outputSamplesPerChannel);
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
      opus.decoder.opus_decoder_destroy(_opusDecoder);
      opus.allocator.free(_softClipBuffer);
    }
  }
}

/// An implementation of [OpusDecoder] that uses preallocated buffers.
/// Don't forget to call [destroy] once you are done with it.
///
/// The idea behind this implementation is to reduce the amount of memory allocation calls.
/// Instead of allocating new buffers everytime something is decoded, the buffers are
/// allocated at initalization. Then, an opus packet is directly written into the [inputBuffer],
/// the [inputBufferIndex] is updated, based on how many bytes where written, and
/// one of the deocde methods is called. The decoded pcm samples can then be accessed using
/// the [outputBuffer] getter (or one of the [outputBufferAsInt16List] or [outputBufferAsFloat32List] convenience getters).
/// ```
/// BufferedOpusDecoder decoder;
///
/// void example() {
///   // Get an opus packet
///   Uint8List packet = receivePacket();
///   // Set the bytes to the input buffer
///   decoder.inputBuffer.setAll(0, packet);
///   // Update the inputBufferIndex with amount of bytes written
///   decoder.inputBufferIndex = packet.length;
///   // decode
///   decoder.decode();
///   // Interpret the output as s16le
///   Int16List pcm = decoder.outputBufferAsInt16List;
///   doSomething(pcm);
/// }
/// ```
class BufferedOpusDecoder extends OpusDecoder {
  final Pointer<opus_decoder.OpusDecoder> _opusDecoder;
  @override
  final int sampleRate;
  @override
  final int channels;
  bool _destroyed;
  @override
  bool get destroyed => _destroyed;
  @override
  int? get lastPacketDurationMs => _lastPacketDurationMs;
  int? _lastPacketDurationMs;

  /// The size of the allocated the input buffer in bytes.
  /// Should be choosen big enough to hold a maximal opus packet
  /// with size of [maxDataBytes] bytes.
  final int maxInputBufferSizeBytes;

  /// Indicates, how many bytes of data are currently stored in the [inputBuffer].
  int inputBufferIndex;

  final Pointer<Uint8> _inputBuffer;

  /// Returns the native input buffer backed by native memory.
  ///
  /// You should write the opus packet you want to decode as bytes into this buffer,
  /// update the [inputBufferIndex] accordingly and call one of the decode methods.
  ///
  /// You must not put more bytes then [maxInputBufferSizeBytes] into this buffer.
  Uint8List get inputBuffer =>
      _inputBuffer.asTypedList(maxInputBufferSizeBytes);

  /// The size of the allocated the output buffer. If this value is choosen
  /// to small, this decoder will not be capable of decoding some packets.
  ///
  /// See the constructor for information, how to choose this.
  final int maxOutputBufferSizeBytes;
  int _outputBufferIndex;
  final Pointer<Uint8> _outputBuffer;

  /// The portion of the allocated output buffer that is currently filled with data.
  /// The data are pcm samples, either encoded as s16le or floats, depending on
  /// what method was used to decode the input packet.
  ///
  /// This method does not copy data from native memory to dart memory but
  /// rather gives a view backed by native memory.
  Uint8List get outputBuffer => _outputBuffer.asTypedList(_outputBufferIndex);

  /// Convenience method to get the current output buffer as s16le.
  Int16List get outputBufferAsInt16List =>
      _outputBuffer.cast<Int16>().asTypedList(_outputBufferIndex ~/ 2);

  /// Convenience method to get the current output buffer as floats.
  Float32List get outputBufferAsFloat32List =>
      _outputBuffer.cast<Float>().asTypedList(_outputBufferIndex ~/ 4);

  final Pointer<Float> _softClipBuffer;

  BufferedOpusDecoder._(
      this._opusDecoder,
      this.sampleRate,
      this.channels,
      this._inputBuffer,
      this.maxInputBufferSizeBytes,
      this._outputBuffer,
      this.maxOutputBufferSizeBytes,
      this._softClipBuffer)
      : _destroyed = false,
        inputBufferIndex = 0,
        _outputBufferIndex = 0;

  /// Creates an new [BufferedOpusDecoder] based on the [sampleRate] and [channels].
  /// The native allocated buffer size is determined by [maxInputBufferSizeBytes] and [maxOutputBufferSizeBytes].
  ///
  /// You should choose [maxInputBufferSizeBytes] big enough to put every opus packet you want to decode in it.
  /// If you omit this parameter, [maxDataByes] is used, which guarantees that there is enough space for every
  /// valid opus packet.
  ///
  /// [maxOutputBufferSizeBytes] is the size of the output buffer, which will hold the decoded frames.
  /// If this value is choosen to small, this decoder will not be capable of decoding some packets.
  /// If you are unsure, just let it `null`, so the maximum size of resulting frames will be calculated
  /// Here is some more theory about that:
  /// A single opus packet may contain up to 120ms of audio, so assuming you are decoding
  /// packets with [sampleRate] and [channels] and want them stored as s16le (2 bytes per sample),
  /// then `maxOutputBufferSizeBytes = [sampleRate]~/1000 * 120 * channels * 2`.
  /// If you want your samples stored as floats (using the [decodeFloat] method), you need to
  /// multiply by `4` instead of `2` (since a float takes 4 bytes per value).
  /// If you know the frame time in advance, you can use the above formula to choose a smaller value.
  /// Also note that there is a [maxSamplesPerPacket] function.
  ///
  /// For the other parameters, see the matching fields for more information.
  factory BufferedOpusDecoder(
      {required int sampleRate,
      required int channels,
      int? maxInputBufferSizeBytes,
      int? maxOutputBufferSizeBytes}) {
    if (maxInputBufferSizeBytes == null) {
      maxInputBufferSizeBytes = maxDataBytes;
    }
    if (maxOutputBufferSizeBytes == null) {
      maxOutputBufferSizeBytes = maxSamplesPerPacket(sampleRate, channels);
    }
    Pointer<Int32> error = opus.allocator.call<Int32>(1);
    Pointer<Uint8> input = opus.allocator.call<Uint8>(maxInputBufferSizeBytes);
    Pointer<Uint8> output =
        opus.allocator.call<Uint8>(maxOutputBufferSizeBytes);
    Pointer<Float> softClipBuffer = opus.allocator.call<Float>(channels);
    Pointer<opus_decoder.OpusDecoder> encoder =
        opus.decoder.opus_decoder_create(sampleRate, channels, error);
    try {
      if (error.value == opus_defines.OPUS_OK) {
        return BufferedOpusDecoder._(
            encoder,
            sampleRate,
            channels,
            input,
            maxInputBufferSizeBytes,
            output,
            maxOutputBufferSizeBytes,
            softClipBuffer);
      } else {
        opus.allocator.free(input);
        opus.allocator.free(output);
        opus.allocator.free(softClipBuffer);
        throw OpusException(error.value);
      }
    } finally {
      opus.allocator.free(error);
    }
  }

  /// Interpretes [inputBufferIndex] bytes from the [inputBuffer] as a whole
  /// opus packet and decodes them to s16le samples, stored in the [outputBuffer].
  /// Set [inputBufferIndex] to `0` to indicate packet loss.
  ///
  /// On packet loss, the [loss] parameter needs to be exactly the duration
  /// of audio that is missing in milliseconds, otherwise the decoder will
  /// not be in the optimal state to decode the next incoming packet.
  /// If you don't know the duration, leave it `null` and [lastPacketDurationMs]
  /// will be used as an estimate instead.
  ///
  /// If you want to use forward error correction, don't report packet loss
  /// by setting the [inputBufferIndex] to `0` (unless it is a real packet
  /// loss), but instead, wait for the next packet and write this to the [inputBuffer],
  /// with [inputBufferIndex] set accordingly. Then call this method with
  /// [fec] set to `true` and [loss] to the missing duration of the missing audio
  /// in ms (as above). Then, call this method a second time with
  /// the same packet, but with [fec] set to `false`. You can read more about the
  /// correct usage of forward error correction [here](https://stackoverflow.com/questions/49427579/how-to-use-fec-feature-for-opus-codec).
  /// Note: A real packet loss occurse if you lose two or more packets in a row.
  /// You are only able to restore the last lost packet and the other packets are
  /// really lost. So for them, you have to report packet loss.
  ///
  /// The input bytes need to represent a whole packet!
  ///
  /// The returned list is actually just the [outputBufferAsInt16List].
  @override
  Int16List decode({bool fec = false, int? loss}) {
    Pointer<Uint8> inputNative;
    int frameSize;
    if (inputBufferIndex > 0) {
      inputNative = _inputBuffer;
      frameSize = maxOutputBufferSizeBytes ~/ (2 * channels);
    } else {
      inputNative = nullptr;
      frameSize = _estimateLoss(loss, lastPacketDurationMs);
    }
    int outputSamplesPerChannel = opus.decoder.opus_decode(
        _opusDecoder,
        inputNative,
        inputBufferIndex,
        _outputBuffer.cast<Int16>(),
        frameSize,
        fec ? 1 : 0);
    if (outputSamplesPerChannel >= opus_defines.OPUS_OK) {
      _lastPacketDurationMs =
          _packetDuration(outputSamplesPerChannel, channels, sampleRate);
      _outputBufferIndex = 2 * outputSamplesPerChannel * channels;
      return outputBufferAsInt16List;
    } else {
      throw OpusException(outputSamplesPerChannel);
    }
  }

  /// Interpretes [inputBufferIndex] bytes from the [inputBuffer] as a whole
  /// opus packet and decodes them to float samples, stored in the [outputBuffer].
  /// Set [inputBufferIndex] to `0` to indicate packet loss.
  ///
  /// If [autoSoftClip] is true, this decoders [pcmSoftClipOutputBuffer] method is automatically called.
  ///
  /// Apart from that, this method behaves just as [decode], so see there for more information.
  @override
  Float32List decodeFloat(
      {bool autoSoftClip = false, bool fec = false, int? loss}) {
    Pointer<Uint8> inputNative;
    int frameSize;
    if (inputBufferIndex > 0) {
      inputNative = _inputBuffer;
      frameSize = maxOutputBufferSizeBytes ~/ (4 * channels);
    } else {
      inputNative = nullptr;
      frameSize = _estimateLoss(loss, lastPacketDurationMs);
    }
    int outputSamplesPerChannel = opus.decoder.opus_decode_float(
        _opusDecoder,
        inputNative,
        inputBufferIndex,
        _outputBuffer.cast<Float>(),
        frameSize,
        fec ? 1 : 0);
    if (outputSamplesPerChannel >= opus_defines.OPUS_OK) {
      _lastPacketDurationMs =
          _packetDuration(outputSamplesPerChannel, channels, sampleRate);
      _outputBufferIndex = 4 * outputSamplesPerChannel * channels;
      if (autoSoftClip) {
        return pcmSoftClipOutputBuffer();
      } else {
        return outputBufferAsFloat32List;
      }
    } else {
      throw OpusException(outputSamplesPerChannel);
    }
  }

  @override
  void destroy() {
    if (!_destroyed) {
      _destroyed = true;
      opus.decoder.opus_decoder_destroy(_opusDecoder);
      opus.allocator.free(_inputBuffer);
      opus.allocator.free(_outputBuffer);
      opus.allocator.free(_softClipBuffer);
    }
  }

  /// Performs soft clipping on the [outputBuffer].
  ///
  /// Behaves like the toplevel [pcmSoftClip] function, but without unnecessary copying.
  Float32List pcmSoftClipOutputBuffer() {
    opus.decoder.opus_pcm_soft_clip(_outputBuffer.cast<Float>(),
        _outputBufferIndex ~/ (4 * channels), channels, _softClipBuffer);
    return outputBufferAsFloat32List;
  }
}

/// Abstract base class for opus decoders.
abstract class OpusDecoder {
  /// The sample rate in Hz for this decoder.
  /// Opus supports sample rates from 8kHz to 48kHz so this value must be between 8000 and 48000.
  int get sampleRate;

  /// Number of channels, must be 1 for mono or 2 for stereo.
  int get channels;

  /// Wheter this decoder was already destroyed by calling [destroy].
  /// If so, calling any method will result in an [OpusDestroyedError].
  bool get destroyed;

  /// The duration of the last decoded packet in ms or null if there was no packet yet.
  int? get lastPacketDurationMs;

  Int16List decode({bool fec = false, int? loss});
  Float32List decodeFloat({bool autoSoftClip, bool fec = false, int? loss});

  /// Destroys this decoder by releasing all native resources.
  /// After this, it is no longer possible to decode using this decoder, so any further method call will throw an [OpusDestroyedError].
  void destroy();
}

int _estimateLoss(int? loss, int? lastPacketDurationMs) {
  if (loss != null) {
    return loss;
  } else if (lastPacketDurationMs != null) {
    return lastPacketDurationMs;
  } else {
    throw new StateError(
        'Tried to estimate the loss based on the last packets duration, but there was no last packet!\n' +
            'This happend because you called a decode function with no input (null as input in SimpleOpusDecoder or 0 as inputBufferIndex in BufferedOpusDecoder), but failed to specify how many milliseconds were lost.\n' +
            'And since there was no previous sucessfull decoded packet, the decoder could not estimate how many milliseconds are missing.');
  }
}
