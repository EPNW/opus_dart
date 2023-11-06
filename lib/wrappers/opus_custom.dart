/// WARNING! Trying to use opus_custom will FAIL if opus_custom support
/// was not enabled during library building!
///
/// Contains methods and structs from the opus_custom group of opus_custom.h.
/// SHOULD be imported as opus_custom.
///
/// AUTOMATICALLY GENERATED FILE. DO NOT MODIFY.
// ignore_for_file: camel_case_types, non_constant_identifier_names, constant_identifier_names

// We are going to ignore subtype_of_sealed_class since dart analysis does not
// get the imports right when differentiating between web_ffi and dart:ffi
// ignore_for_file: subtype_of_sealed_class

library opus_custom;

import '../src/proxy_ffi.dart' as ffi;

/// Contains the state of an encoder. One encoder state is needed
/// for each stream. It is initialized once at the beginning of the
/// stream. Do *not* re-initialize the state for every frame.
/// @brief Encoder state
class OpusCustomEncoder extends ffi.Opaque {}

/// State of the decoder. One decoder state is needed for each stream.
/// It is initialized once at the beginning of the stream. Do *not*
/// re-initialize the state for every frame.
/// @brief Decoder state
class OpusCustomDecoder extends ffi.Opaque {}

/// The mode contains all the information necessary to create an
/// encoder. Both the encoder and decoder need to be initialized
/// with exactly the same mode, otherwise the output will be
/// corrupted.
/// @brief Mode configuration
class OpusCustomMode extends ffi.Opaque {}

typedef _opus_custom_mode_create_C = ffi.Pointer<OpusCustomMode> Function(
  ffi.Int32 Fs,
  ffi.Int32 frame_size,
  ffi.Pointer<ffi.Int32> error,
);
typedef _opus_custom_mode_create_Dart = ffi.Pointer<OpusCustomMode> Function(
  int Fs,
  int frame_size,
  ffi.Pointer<ffi.Int32> error,
);
typedef _opus_custom_mode_destroy_C = ffi.Void Function(
  ffi.Pointer<OpusCustomMode> mode,
);
typedef _opus_custom_mode_destroy_Dart = void Function(
  ffi.Pointer<OpusCustomMode> mode,
);
typedef _opus_custom_encoder_get_size_C = ffi.Int32 Function(
  ffi.Pointer<OpusCustomMode> mode,
  ffi.Int32 channels,
);
typedef _opus_custom_encoder_get_size_Dart = int Function(
  ffi.Pointer<OpusCustomMode> mode,
  int channels,
);
typedef _opus_custom_encoder_init_C = ffi.Int32 Function(
  ffi.Pointer<OpusCustomEncoder> st,
  ffi.Pointer<OpusCustomMode> mode,
  ffi.Int32 channels,
);
typedef _opus_custom_encoder_init_Dart = int Function(
  ffi.Pointer<OpusCustomEncoder> st,
  ffi.Pointer<OpusCustomMode> mode,
  int channels,
);
typedef _opus_custom_encoder_create_C = ffi.Pointer<OpusCustomEncoder> Function(
  ffi.Pointer<OpusCustomMode> mode,
  ffi.Int32 channels,
  ffi.Pointer<ffi.Int32> error,
);
typedef _opus_custom_encoder_create_Dart = ffi.Pointer<OpusCustomEncoder>
    Function(
  ffi.Pointer<OpusCustomMode> mode,
  int channels,
  ffi.Pointer<ffi.Int32> error,
);
typedef _opus_custom_encoder_destroy_C = ffi.Void Function(
  ffi.Pointer<OpusCustomEncoder> st,
);
typedef _opus_custom_encoder_destroy_Dart = void Function(
  ffi.Pointer<OpusCustomEncoder> st,
);
typedef _opus_custom_encode_float_C = ffi.Int32 Function(
  ffi.Pointer<OpusCustomEncoder> st,
  ffi.Pointer<ffi.Float> pcm,
  ffi.Int32 frame_size,
  ffi.Pointer<ffi.Uint8> compressed,
  ffi.Int32 maxCompressedBytes,
);
typedef _opus_custom_encode_float_Dart = int Function(
  ffi.Pointer<OpusCustomEncoder> st,
  ffi.Pointer<ffi.Float> pcm,
  int frame_size,
  ffi.Pointer<ffi.Uint8> compressed,
  int maxCompressedBytes,
);
typedef _opus_custom_encode_C = ffi.Int32 Function(
  ffi.Pointer<OpusCustomEncoder> st,
  ffi.Pointer<ffi.Int16> pcm,
  ffi.Int32 frame_size,
  ffi.Pointer<ffi.Uint8> compressed,
  ffi.Int32 maxCompressedBytes,
);
typedef _opus_custom_encode_Dart = int Function(
  ffi.Pointer<OpusCustomEncoder> st,
  ffi.Pointer<ffi.Int16> pcm,
  int frame_size,
  ffi.Pointer<ffi.Uint8> compressed,
  int maxCompressedBytes,
);
typedef _opus_custom_decoder_get_size_C = ffi.Int32 Function(
  ffi.Pointer<OpusCustomMode> mode,
  ffi.Int32 channels,
);
typedef _opus_custom_decoder_get_size_Dart = int Function(
  ffi.Pointer<OpusCustomMode> mode,
  int channels,
);
typedef _opus_custom_decoder_init_C = ffi.Int32 Function(
  ffi.Pointer<OpusCustomDecoder> st,
  ffi.Pointer<OpusCustomMode> mode,
  ffi.Int32 channels,
);
typedef _opus_custom_decoder_init_Dart = int Function(
  ffi.Pointer<OpusCustomDecoder> st,
  ffi.Pointer<OpusCustomMode> mode,
  int channels,
);
typedef _opus_custom_decoder_create_C = ffi.Pointer<OpusCustomDecoder> Function(
  ffi.Pointer<OpusCustomMode> mode,
  ffi.Int32 channels,
  ffi.Pointer<ffi.Int32> error,
);
typedef _opus_custom_decoder_create_Dart = ffi.Pointer<OpusCustomDecoder>
    Function(
  ffi.Pointer<OpusCustomMode> mode,
  int channels,
  ffi.Pointer<ffi.Int32> error,
);
typedef _opus_custom_decoder_destroy_C = ffi.Void Function(
  ffi.Pointer<OpusCustomDecoder> st,
);
typedef _opus_custom_decoder_destroy_Dart = void Function(
  ffi.Pointer<OpusCustomDecoder> st,
);
typedef _opus_custom_decode_float_C = ffi.Int32 Function(
  ffi.Pointer<OpusCustomDecoder> st,
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 len,
  ffi.Pointer<ffi.Float> pcm,
  ffi.Int32 frame_size,
);
typedef _opus_custom_decode_float_Dart = int Function(
  ffi.Pointer<OpusCustomDecoder> st,
  ffi.Pointer<ffi.Uint8> data,
  int len,
  ffi.Pointer<ffi.Float> pcm,
  int frame_size,
);
typedef _opus_custom_decode_C = ffi.Int32 Function(
  ffi.Pointer<OpusCustomDecoder> st,
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 len,
  ffi.Pointer<ffi.Int16> pcm,
  ffi.Int32 frame_size,
);
typedef _opus_custom_decode_Dart = int Function(
  ffi.Pointer<OpusCustomDecoder> st,
  ffi.Pointer<ffi.Uint8> data,
  int len,
  ffi.Pointer<ffi.Int16> pcm,
  int frame_size,
);

class FunctionsAndGlobals {
  FunctionsAndGlobals(ffi.DynamicLibrary _dynamicLibrary)
      : _opus_custom_mode_create = _dynamicLibrary.lookupFunction<
            _opus_custom_mode_create_C, _opus_custom_mode_create_Dart>(
          'opus_custom_mode_create',
        ),
        _opus_custom_mode_destroy = _dynamicLibrary.lookupFunction<
            _opus_custom_mode_destroy_C, _opus_custom_mode_destroy_Dart>(
          'opus_custom_mode_destroy',
        ),
        _opus_custom_encoder_get_size = _dynamicLibrary.lookupFunction<
            _opus_custom_encoder_get_size_C,
            _opus_custom_encoder_get_size_Dart>(
          'opus_custom_encoder_get_size',
        ),
        _opus_custom_encoder_init = _dynamicLibrary.lookupFunction<
            _opus_custom_encoder_init_C, _opus_custom_encoder_init_Dart>(
          'opus_custom_encoder_init',
        ),
        _opus_custom_encoder_create = _dynamicLibrary.lookupFunction<
            _opus_custom_encoder_create_C, _opus_custom_encoder_create_Dart>(
          'opus_custom_encoder_create',
        ),
        _opus_custom_encoder_destroy = _dynamicLibrary.lookupFunction<
            _opus_custom_encoder_destroy_C, _opus_custom_encoder_destroy_Dart>(
          'opus_custom_encoder_destroy',
        ),
        _opus_custom_encode_float = _dynamicLibrary.lookupFunction<
            _opus_custom_encode_float_C, _opus_custom_encode_float_Dart>(
          'opus_custom_encode_float',
        ),
        _opus_custom_encode = _dynamicLibrary
            .lookupFunction<_opus_custom_encode_C, _opus_custom_encode_Dart>(
          'opus_custom_encode',
        ),
        _opus_custom_decoder_get_size = _dynamicLibrary.lookupFunction<
            _opus_custom_decoder_get_size_C,
            _opus_custom_decoder_get_size_Dart>(
          'opus_custom_decoder_get_size',
        ),
        _opus_custom_decoder_init = _dynamicLibrary.lookupFunction<
            _opus_custom_decoder_init_C, _opus_custom_decoder_init_Dart>(
          'opus_custom_decoder_init',
        ),
        _opus_custom_decoder_create = _dynamicLibrary.lookupFunction<
            _opus_custom_decoder_create_C, _opus_custom_decoder_create_Dart>(
          'opus_custom_decoder_create',
        ),
        _opus_custom_decoder_destroy = _dynamicLibrary.lookupFunction<
            _opus_custom_decoder_destroy_C, _opus_custom_decoder_destroy_Dart>(
          'opus_custom_decoder_destroy',
        ),
        _opus_custom_decode_float = _dynamicLibrary.lookupFunction<
            _opus_custom_decode_float_C, _opus_custom_decode_float_Dart>(
          'opus_custom_decode_float',
        ),
        _opus_custom_decode = _dynamicLibrary
            .lookupFunction<_opus_custom_decode_C, _opus_custom_decode_Dart>(
          'opus_custom_decode',
        );

  /// Creates a new mode struct. This will be passed to an encoder or
  /// decoder. The mode MUST NOT BE DESTROYED until the encoders and
  /// decoders that use it are destroyed as well.
  /// @param [in] Fs <tt>int</tt>: Sampling rate (8000 to 96000 Hz)
  /// @param [in] frame_size <tt>int</tt>: Number of samples (per channel) to encode in each
  /// packet (64 - 1024, prime factorization must contain zero or more 2s, 3s, or 5s and no other primes)
  /// @param [out] error <tt>int*</tt>: Returned error code (if NULL, no error will be returned)
  /// @return A newly created mode
  ffi.Pointer<OpusCustomMode> opus_custom_mode_create(
    int Fs,
    int frame_size,
    ffi.Pointer<ffi.Int32> error,
  ) {
    return _opus_custom_mode_create(Fs, frame_size, error);
  }

  final _opus_custom_mode_create_Dart _opus_custom_mode_create;

  /// Destroys a mode struct. Only call this after all encoders and
  /// decoders using this mode are destroyed as well.
  /// @param [in] mode <tt>OpusCustomMode*</tt>: Mode to be freed.
  void opus_custom_mode_destroy(
    ffi.Pointer<OpusCustomMode> mode,
  ) {
    _opus_custom_mode_destroy(mode);
  }

  final _opus_custom_mode_destroy_Dart _opus_custom_mode_destroy;

  /// Gets the size of an OpusCustomEncoder structure.
  /// @param [in] mode <tt>OpusCustomMode *</tt>: Mode configuration
  /// @param [in] channels <tt>int</tt>: Number of channels
  /// @returns size
  int opus_custom_encoder_get_size(
    ffi.Pointer<OpusCustomMode> mode,
    int channels,
  ) {
    return _opus_custom_encoder_get_size(mode, channels);
  }

  final _opus_custom_encoder_get_size_Dart _opus_custom_encoder_get_size;

  /// Initializes a previously allocated encoder state
  /// The memory pointed to by st must be the size returned by opus_custom_encoder_get_size.
  /// This is intended for applications which use their own allocator instead of malloc.
  /// @see opus_custom_encoder_create(),opus_custom_encoder_get_size()
  /// To reset a previously initialized state use the OPUS_RESET_STATE CTL.
  /// @param [in] st <tt>OpusCustomEncoder*</tt>: Encoder state
  /// @param [in] mode <tt>OpusCustomMode *</tt>: Contains all the information about the characteristics of
  /// the stream (must be the same characteristics as used for the
  /// decoder)
  /// @param [in] channels <tt>int</tt>: Number of channels
  /// @return OPUS_OK Success or @ref opus_errorcodes
  int opus_custom_encoder_init(
    ffi.Pointer<OpusCustomEncoder> st,
    ffi.Pointer<OpusCustomMode> mode,
    int channels,
  ) {
    return _opus_custom_encoder_init(st, mode, channels);
  }

  final _opus_custom_encoder_init_Dart _opus_custom_encoder_init;

  /// Creates a new encoder state. Each stream needs its own encoder
  /// state (can't be shared across simultaneous streams).
  /// @param [in] mode <tt>OpusCustomMode*</tt>: Contains all the information about the characteristics of
  /// the stream (must be the same characteristics as used for the
  /// decoder)
  /// @param [in] channels <tt>int</tt>: Number of channels
  /// @param [out] error <tt>int*</tt>: Returns an error code
  /// @return Newly created encoder state.
  ffi.Pointer<OpusCustomEncoder> opus_custom_encoder_create(
    ffi.Pointer<OpusCustomMode> mode,
    int channels,
    ffi.Pointer<ffi.Int32> error,
  ) {
    return _opus_custom_encoder_create(mode, channels, error);
  }

  final _opus_custom_encoder_create_Dart _opus_custom_encoder_create;

  /// Destroys a an encoder state.
  /// @param[in] st <tt>OpusCustomEncoder*</tt>: State to be freed.
  void opus_custom_encoder_destroy(
    ffi.Pointer<OpusCustomEncoder> st,
  ) {
    _opus_custom_encoder_destroy(st);
  }

  final _opus_custom_encoder_destroy_Dart _opus_custom_encoder_destroy;

  /// Encodes a frame of audio.
  /// @param [in] st <tt>OpusCustomEncoder*</tt>: Encoder state
  /// @param [in] pcm <tt>float*</tt>: PCM audio in float format, with a normal range of +/-1.0.
  /// Samples with a range beyond +/-1.0 are supported but will
  /// be clipped by decoders using the integer API and should
  /// only be used if it is known that the far end supports
  /// extended dynamic range. There must be exactly
  /// frame_size samples per channel.
  /// @param [in] frame_size <tt>int</tt>: Number of samples per frame of input signal
  /// @param [out] compressed <tt>char *</tt>: The compressed data is written here. This may not alias pcm and must be at least maxCompressedBytes long.
  /// @param [in] maxCompressedBytes <tt>int</tt>: Maximum number of bytes to use for compressing the frame
  /// (can change from one frame to another)
  /// @return Number of bytes written to "compressed".
  /// If negative, an error has occurred (see error codes). It is IMPORTANT that
  /// the length returned be somehow transmitted to the decoder. Otherwise, no
  /// decoding is possible.
  int opus_custom_encode_float(
    ffi.Pointer<OpusCustomEncoder> st,
    ffi.Pointer<ffi.Float> pcm,
    int frame_size,
    ffi.Pointer<ffi.Uint8> compressed,
    int maxCompressedBytes,
  ) {
    return _opus_custom_encode_float(
        st, pcm, frame_size, compressed, maxCompressedBytes);
  }

  final _opus_custom_encode_float_Dart _opus_custom_encode_float;

  /// Encodes a frame of audio.
  /// @param [in] st <tt>OpusCustomEncoder*</tt>: Encoder state
  /// @param [in] pcm <tt>opus_int16*</tt>: PCM audio in signed 16-bit format (native endian).
  /// There must be exactly frame_size samples per channel.
  /// @param [in] frame_size <tt>int</tt>: Number of samples per frame of input signal
  /// @param [out] compressed <tt>char *</tt>: The compressed data is written here. This may not alias pcm and must be at least maxCompressedBytes long.
  /// @param [in] maxCompressedBytes <tt>int</tt>: Maximum number of bytes to use for compressing the frame
  /// (can change from one frame to another)
  /// @return Number of bytes written to "compressed".
  /// If negative, an error has occurred (see error codes). It is IMPORTANT that
  /// the length returned be somehow transmitted to the decoder. Otherwise, no
  /// decoding is possible.
  int opus_custom_encode(
    ffi.Pointer<OpusCustomEncoder> st,
    ffi.Pointer<ffi.Int16> pcm,
    int frame_size,
    ffi.Pointer<ffi.Uint8> compressed,
    int maxCompressedBytes,
  ) {
    return _opus_custom_encode(
        st, pcm, frame_size, compressed, maxCompressedBytes);
  }

  final _opus_custom_encode_Dart _opus_custom_encode;

  /// Gets the size of an OpusCustomDecoder structure.
  /// @param [in] mode <tt>OpusCustomMode *</tt>: Mode configuration
  /// @param [in] channels <tt>int</tt>: Number of channels
  /// @returns size
  int opus_custom_decoder_get_size(
    ffi.Pointer<OpusCustomMode> mode,
    int channels,
  ) {
    return _opus_custom_decoder_get_size(mode, channels);
  }

  final _opus_custom_decoder_get_size_Dart _opus_custom_decoder_get_size;

  /// Initializes a previously allocated decoder state
  /// The memory pointed to by st must be the size returned by opus_custom_decoder_get_size.
  /// This is intended for applications which use their own allocator instead of malloc.
  /// @see opus_custom_decoder_create(),opus_custom_decoder_get_size()
  /// To reset a previously initialized state use the OPUS_RESET_STATE CTL.
  /// @param [in] st <tt>OpusCustomDecoder*</tt>: Decoder state
  /// @param [in] mode <tt>OpusCustomMode *</tt>: Contains all the information about the characteristics of
  /// the stream (must be the same characteristics as used for the
  /// encoder)
  /// @param [in] channels <tt>int</tt>: Number of channels
  /// @return OPUS_OK Success or @ref opus_errorcodes
  int opus_custom_decoder_init(
    ffi.Pointer<OpusCustomDecoder> st,
    ffi.Pointer<OpusCustomMode> mode,
    int channels,
  ) {
    return _opus_custom_decoder_init(st, mode, channels);
  }

  final _opus_custom_decoder_init_Dart _opus_custom_decoder_init;

  /// Creates a new decoder state. Each stream needs its own decoder state (can't
  /// be shared across simultaneous streams).
  /// @param [in] mode <tt>OpusCustomMode</tt>: Contains all the information about the characteristics of the
  /// stream (must be the same characteristics as used for the encoder)
  /// @param [in] channels <tt>int</tt>: Number of channels
  /// @param [out] error <tt>int*</tt>: Returns an error code
  /// @return Newly created decoder state.
  ffi.Pointer<OpusCustomDecoder> opus_custom_decoder_create(
    ffi.Pointer<OpusCustomMode> mode,
    int channels,
    ffi.Pointer<ffi.Int32> error,
  ) {
    return _opus_custom_decoder_create(mode, channels, error);
  }

  final _opus_custom_decoder_create_Dart _opus_custom_decoder_create;

  /// Destroys a an decoder state.
  /// @param[in] st <tt>OpusCustomDecoder*</tt>: State to be freed.
  void opus_custom_decoder_destroy(
    ffi.Pointer<OpusCustomDecoder> st,
  ) {
    _opus_custom_decoder_destroy(st);
  }

  final _opus_custom_decoder_destroy_Dart _opus_custom_decoder_destroy;

  /// Decode an opus custom frame with floating point output
  /// @param [in] st <tt>OpusCustomDecoder*</tt>: Decoder state
  /// @param [in] data <tt>char*</tt>: Input payload. Use a NULL pointer to indicate packet loss
  /// @param [in] len <tt>int</tt>: Number of bytes in payload
  /// @param [out] pcm <tt>float*</tt>: Output signal (interleaved if 2 channels). length
  /// is frame_size*channels*sizeof(float)
  /// @param [in] frame_size Number of samples per channel of available space in *pcm.
  /// @returns Number of decoded samples or @ref opus_errorcodes
  int opus_custom_decode_float(
    ffi.Pointer<OpusCustomDecoder> st,
    ffi.Pointer<ffi.Uint8> data,
    int len,
    ffi.Pointer<ffi.Float> pcm,
    int frame_size,
  ) {
    return _opus_custom_decode_float(st, data, len, pcm, frame_size);
  }

  final _opus_custom_decode_float_Dart _opus_custom_decode_float;

  /// Decode an opus custom frame
  /// @param [in] st <tt>OpusCustomDecoder*</tt>: Decoder state
  /// @param [in] data <tt>char*</tt>: Input payload. Use a NULL pointer to indicate packet loss
  /// @param [in] len <tt>int</tt>: Number of bytes in payload
  /// @param [out] pcm <tt>opus_int16*</tt>: Output signal (interleaved if 2 channels). length
  /// is frame_size*channels*sizeof(opus_int16)
  /// @param [in] frame_size Number of samples per channel of available space in *pcm.
  /// @returns Number of decoded samples or @ref opus_errorcodes
  int opus_custom_decode(
    ffi.Pointer<OpusCustomDecoder> st,
    ffi.Pointer<ffi.Uint8> data,
    int len,
    ffi.Pointer<ffi.Int16> pcm,
    int frame_size,
  ) {
    return _opus_custom_decode(st, data, len, pcm, frame_size);
  }

  final _opus_custom_decode_Dart _opus_custom_decode;
}
