/// Contains methods and structs from the opus_encoder group of opus.h.
/// SHOULD be imported as opus_encoder.
///
/// AUTOMATICALLY GENERATED FILE. DO NOT MODIFY.
// ignore_for_file: camel_case_types, non_constant_identifier_names, constant_identifier_names

// We are going to ignore subtype_of_sealed_class since dart analysis does not
// get the imports right when differentiating between web_ffi and dart:ffi
// ignore_for_file: subtype_of_sealed_class
library opus_encoder;

import '../src/proxy_ffi.dart' as ffi;

/// Opus encoder state.
/// This contains the complete state of an Opus encoder.
/// It is position independent and can be freely copied.
/// @see opus_encoder_create,opus_encoder_init
final class OpusEncoder extends ffi.Opaque {}

typedef _opus_encoder_get_size_C = ffi.Int32 Function(
  ffi.Int32 channels,
);
typedef _opus_encoder_get_size_Dart = int Function(
  int channels,
);
typedef _opus_encoder_create_C = ffi.Pointer<OpusEncoder> Function(
  ffi.Int32 Fs,
  ffi.Int32 channels,
  ffi.Int32 application,
  ffi.Pointer<ffi.Int32> error,
);
typedef _opus_encoder_create_Dart = ffi.Pointer<OpusEncoder> Function(
  int Fs,
  int channels,
  int application,
  ffi.Pointer<ffi.Int32> error,
);
typedef _opus_encoder_init_C = ffi.Int32 Function(
  ffi.Pointer<OpusEncoder> st,
  ffi.Int32 Fs,
  ffi.Int32 channels,
  ffi.Int32 application,
);
typedef _opus_encoder_init_Dart = int Function(
  ffi.Pointer<OpusEncoder> st,
  int Fs,
  int channels,
  int application,
);
typedef _opus_encode_C = ffi.Int32 Function(
  ffi.Pointer<OpusEncoder> st,
  ffi.Pointer<ffi.Int16> pcm,
  ffi.Int32 frame_size,
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 max_data_bytes,
);
typedef _opus_encode_Dart = int Function(
  ffi.Pointer<OpusEncoder> st,
  ffi.Pointer<ffi.Int16> pcm,
  int frame_size,
  ffi.Pointer<ffi.Uint8> data,
  int max_data_bytes,
);
typedef _opus_encode_float_C = ffi.Int32 Function(
  ffi.Pointer<OpusEncoder> st,
  ffi.Pointer<ffi.Float> pcm,
  ffi.Int32 frame_size,
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 max_data_bytes,
);
typedef _opus_encode_float_Dart = int Function(
  ffi.Pointer<OpusEncoder> st,
  ffi.Pointer<ffi.Float> pcm,
  int frame_size,
  ffi.Pointer<ffi.Uint8> data,
  int max_data_bytes,
);
typedef _opus_encoder_destroy_C = ffi.Void Function(
  ffi.Pointer<OpusEncoder> st,
);
typedef _opus_encoder_destroy_Dart = void Function(
  ffi.Pointer<OpusEncoder> st,
);

class FunctionsAndGlobals {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
  _lookup;


  FunctionsAndGlobals(ffi.DynamicLibrary _dynamicLibrary)
      : _opus_encoder_get_size = _dynamicLibrary.lookupFunction<
            _opus_encoder_get_size_C, _opus_encoder_get_size_Dart>(
          'opus_encoder_get_size',
        ),
        _opus_encoder_create = _dynamicLibrary
            .lookupFunction<_opus_encoder_create_C, _opus_encoder_create_Dart>(
          'opus_encoder_create',
        ),
        _opus_encoder_init = _dynamicLibrary
            .lookupFunction<_opus_encoder_init_C, _opus_encoder_init_Dart>(
          'opus_encoder_init',
        ),
        _opus_encode =
            _dynamicLibrary.lookupFunction<_opus_encode_C, _opus_encode_Dart>(
          'opus_encode',
        ),
        _opus_encode_float = _dynamicLibrary
            .lookupFunction<_opus_encode_float_C, _opus_encode_float_Dart>(
          'opus_encode_float',
        ),
        _opus_encoder_destroy = _dynamicLibrary.lookupFunction<
            _opus_encoder_destroy_C, _opus_encoder_destroy_Dart>(
          'opus_encoder_destroy',
        ),
        _lookup = _dynamicLibrary.lookup;

  /// Gets the size of an <code>OpusEncoder</code> structure.
  /// @param [in] channels <tt>int</tt>: Number of channels.
  ///                                    This must be 1 or 2.
  /// @returns The size in bytes.
  int opus_encoder_get_size(
    int channels,
  ) {
    return _opus_encoder_get_size(channels);
  }

  final _opus_encoder_get_size_Dart _opus_encoder_get_size;

  /// Allocates and initializes an encoder state.
  /// There are three coding modes:
  ///
  /// OPUS_APPLICATION_VOIP gives best quality at a given bitrate for voice
  /// signals. It enhances the  input signal by high-pass filtering and
  /// emphasizing formants and harmonics. Optionally  it includes in-band
  /// forward error correction to protect against packet loss. Use this
  /// mode for typical VoIP applications. Because of the enhancement,
  /// even at high bitrates the output may sound different from the input.
  ///
  /// OPUS_APPLICATION_AUDIO gives best quality at a given bitrate for most
  /// non-voice signals like music. Use this mode for music and mixed
  /// (music/voice) content, broadcast, and applications requiring less
  /// than 15 ms of coding delay.
  ///
  /// OPUS_APPLICATION_RESTRICTED_LOWDELAY configures low-delay mode that
  /// disables the speech-optimized mode in exchange for slightly reduced delay.
  /// This mode can only be set on an newly initialized or freshly reset encoder
  /// because it changes the codec delay.
  ///
  /// This is useful when the caller knows that the speech-optimized modes will not be needed (use with caution).
  /// @param [in] Fs <tt>opus_int32</tt>: Sampling rate of input signal (Hz)
  ///                                     This must be one of 8000, 12000, 16000,
  ///                                     24000, or 48000.
  /// @param [in] channels <tt>int</tt>: Number of channels (1 or 2) in input signal
  /// @param [in] application <tt>int</tt>: Coding mode (@ref OPUS_APPLICATION_VOIP/@ref OPUS_APPLICATION_AUDIO/@ref OPUS_APPLICATION_RESTRICTED_LOWDELAY)
  /// @param [out] error <tt>int*</tt>: @ref opus_errorcodes
  /// @note Regardless of the sampling rate and number channels selected, the Opus encoder
  /// can switch to a lower audio bandwidth or number of channels if the bitrate
  /// selected is too low. This also means that it is safe to always use 48 kHz stereo input
  /// and let the encoder optimize the encoding.
  ffi.Pointer<OpusEncoder> opus_encoder_create(
    int Fs,
    int channels,
    int application,
    ffi.Pointer<ffi.Int32> error,
  ) {
    return _opus_encoder_create(Fs, channels, application, error);
  }

  final _opus_encoder_create_Dart _opus_encoder_create;

  /// Initializes a previously allocated encoder state
  /// The memory pointed to by st must be at least the size returned by opus_encoder_get_size().
  /// This is intended for applications which use their own allocator instead of malloc.
  /// @see opus_encoder_create(),opus_encoder_get_size()
  /// To reset a previously initialized state, use the #OPUS_RESET_STATE CTL.
  /// @param [in] st <tt>OpusEncoder*</tt>: Encoder state
  /// @param [in] Fs <tt>opus_int32</tt>: Sampling rate of input signal (Hz)
  ///                                     This must be one of 8000, 12000, 16000,
  ///                                     24000, or 48000.
  /// @param [in] channels <tt>int</tt>: Number of channels (1 or 2) in input signal
  /// @param [in] application <tt>int</tt>: Coding mode (OPUS_APPLICATION_VOIP/OPUS_APPLICATION_AUDIO/OPUS_APPLICATION_RESTRICTED_LOWDELAY)
  /// @retval #OPUS_OK Success or @ref opus_errorcodes
  int opus_encoder_init(
    ffi.Pointer<OpusEncoder> st,
    int Fs,
    int channels,
    int application,
  ) {
    return _opus_encoder_init(st, Fs, channels, application);
  }

  final _opus_encoder_init_Dart _opus_encoder_init;

  /// Encodes an Opus frame.
  /// @param [in] st <tt>OpusEncoder*</tt>: Encoder state
  /// @param [in] pcm <tt>opus_int16*</tt>: Input signal (interleaved if 2 channels). length is frame_size*channels*sizeof(opus_int16)
  /// @param [in] frame_size <tt>int</tt>: Number of samples per channel in the
  ///                                      input signal.
  ///                                      This must be an Opus frame size for
  ///                                      the encoder's sampling rate.
  ///                                      For example, at 48 kHz the permitted
  ///                                      values are 120, 240, 480, 960, 1920,
  ///                                      and 2880.
  ///                                      Passing in a duration of less than
  ///                                      10 ms (480 samples at 48 kHz) will
  ///                                      prevent the encoder from using the LPC
  ///                                      or hybrid modes.
  /// @param [out] data <tt>unsigned char*</tt>: Output payload.
  ///                                            This must contain storage for at
  ///                                            least a max_data_bytes.
  /// @param [in] max_data_bytes <tt>opus_int32</tt>: Size of the allocated
  ///                                                 memory for the output
  ///                                                 payload. This may be
  ///                                                 used to impose an upper limit on
  ///                                                 the instant bitrate, but should
  ///                                                 not be used as the only bitrate
  ///                                                 control. Use #OPUS_SET_BITRATE to
  ///                                                 control the bitrate.
  /// @returns The length of the encoded packet (in bytes) on success or a
  ///          negative error code (see @ref opus_errorcodes) on failure.
  int opus_encode(
    ffi.Pointer<OpusEncoder> st,
    ffi.Pointer<ffi.Int16> pcm,
    int frame_size,
    ffi.Pointer<ffi.Uint8> data,
    int max_data_bytes,
  ) {
    return _opus_encode(st, pcm, frame_size, data, max_data_bytes);
  }

  final _opus_encode_Dart _opus_encode;

  /// Encodes an Opus frame from floating point input.
  /// @param [in] st <tt>OpusEncoder*</tt>: Encoder state
  /// @param [in] pcm <tt>float*</tt>: Input in float format (interleaved if 2 channels), with a normal range of +/-1.0.
  ///          Samples with a range beyond +/-1.0 are supported but will
  ///          be clipped by decoders using the integer API and should
  ///          only be used if it is known that the far end supports
  ///          extended dynamic range.
  ///          length is frame_size*channels*sizeof(float)
  /// @param [in] frame_size <tt>int</tt>: Number of samples per channel in the
  ///                                      input signal.
  ///                                      This must be an Opus frame size for
  ///                                      the encoder's sampling rate.
  ///                                      For example, at 48 kHz the permitted
  ///                                      values are 120, 240, 480, 960, 1920,
  ///                                      and 2880.
  ///                                      Passing in a duration of less than
  ///                                      10 ms (480 samples at 48 kHz) will
  ///                                      prevent the encoder from using the LPC
  ///                                      or hybrid modes.
  /// @param [out] data <tt>unsigned char*</tt>: Output payload.
  ///                                            This must contain storage for at
  ///                                            least a max_data_bytes.
  /// @param [in] max_data_bytes <tt>opus_int32</tt>: Size of the allocated
  ///                                                 memory for the output
  ///                                                 payload. This may be
  ///                                                 used to impose an upper limit on
  ///                                                 the instant bitrate, but should
  ///                                                 not be used as the only bitrate
  ///                                                 control. Use #OPUS_SET_BITRATE to
  ///                                                 control the bitrate.
  /// @returns The length of the encoded packet (in bytes) on success or a
  ///          negative error code (see @ref opus_errorcodes) on failure.
  int opus_encode_float(
    ffi.Pointer<OpusEncoder> st,
    ffi.Pointer<ffi.Float> pcm,
    int frame_size,
    ffi.Pointer<ffi.Uint8> data,
    int max_data_bytes,
  ) {
    return _opus_encode_float(st, pcm, frame_size, data, max_data_bytes);
  }

  final _opus_encode_float_Dart _opus_encode_float;

  /// Frees an <code>OpusEncoder</code> allocated by opus_encoder_create().
  /// @param [in] st <tt>OpusEncoder*</tt>: State to be freed.
  void opus_encoder_destroy(
    ffi.Pointer<OpusEncoder> st,
  ) {
    _opus_encoder_destroy(st);
  }

  final _opus_encoder_destroy_Dart _opus_encoder_destroy;

  /// Perform a CTL function on an Opus encoder.
  ///
  /// Generally the request and subsequent arguments are generated
  /// by a convenience macro.
  /// @param st <tt>OpusEncoder*</tt>: Encoder state.
  /// @param request This and all remaining parameters should be replaced by one
  /// of the convenience macros in @ref opus_genericctls or
  /// @ref opus_encoderctls.
  /// @see opus_genericctls
  /// @see opus_encoderctls
  int opus_encoder_ctl(
      ffi.Pointer<OpusEncoder> st,
      int request,
      int va,
      ) {
    return _opus_encoder_ctl(
      st,
      request,
      va,
    );
  }

  late final _opus_encoder_ctlPtr = _lookup<
      ffi.NativeFunction<
          ffi.Int Function(ffi.Pointer<OpusEncoder>, ffi.Int,
              ffi.VarArgs<(ffi.Int,)>)>>('opus_encoder_ctl');
  late final _opus_encoder_ctl = _opus_encoder_ctlPtr
      .asFunction<int Function(ffi.Pointer<OpusEncoder>, int, int)>();


}
