/// Contains methods and structs from the opus_projection group of opus_projection.h.
/// SHOULD be imported as opus_projection.
///
/// AUTOMATICALLY GENERATED FILE. DO NOT MODIFY.
// ignore_for_file: camel_case_types, non_constant_identifier_names, constant_identifier_names

// We are going to ignore subtype_of_sealed_class since dart analysis does not
// get the imports right when differentiating between web_ffi and dart:ffi
// ignore_for_file: subtype_of_sealed_class

library opus_projection;

import '../src/proxy_ffi.dart' as ffi;

/// Opus projection encoder state.
/// * This contains the complete state of a projection Opus encoder.
/// * It is position independent and can be freely copied.
/// * @see opus_projection_ambisonics_encoder_create
class OpusProjectionEncoder extends ffi.Opaque {}

/// Opus projection decoder state.
/// This contains the complete state of a projection Opus decoder.
/// It is position independent and can be freely copied.
/// @see opus_projection_decoder_create
/// @see opus_projection_decoder_init
class OpusProjectionDecoder extends ffi.Opaque {}

typedef _opus_projection_ambisonics_encoder_get_size_C = ffi.Int32 Function(
  ffi.Int32 channels,
  ffi.Int32 mapping_family,
);
typedef _opus_projection_ambisonics_encoder_get_size_Dart = int Function(
  int channels,
  int mapping_family,
);
typedef _opus_projection_ambisonics_encoder_create_C
    = ffi.Pointer<OpusProjectionEncoder> Function(
  ffi.Int32 Fs,
  ffi.Int32 channels,
  ffi.Int32 mapping_family,
  ffi.Pointer<ffi.Int32> streams,
  ffi.Pointer<ffi.Int32> coupled_streams,
  ffi.Int32 application,
  ffi.Pointer<ffi.Int32> error,
);
typedef _opus_projection_ambisonics_encoder_create_Dart
    = ffi.Pointer<OpusProjectionEncoder> Function(
  int Fs,
  int channels,
  int mapping_family,
  ffi.Pointer<ffi.Int32> streams,
  ffi.Pointer<ffi.Int32> coupled_streams,
  int application,
  ffi.Pointer<ffi.Int32> error,
);
typedef _opus_projection_ambisonics_encoder_init_C = ffi.Int32 Function(
  ffi.Pointer<OpusProjectionEncoder> st,
  ffi.Int32 Fs,
  ffi.Int32 channels,
  ffi.Int32 mapping_family,
  ffi.Pointer<ffi.Int32> streams,
  ffi.Pointer<ffi.Int32> coupled_streams,
  ffi.Int32 application,
);
typedef _opus_projection_ambisonics_encoder_init_Dart = int Function(
  ffi.Pointer<OpusProjectionEncoder> st,
  int Fs,
  int channels,
  int mapping_family,
  ffi.Pointer<ffi.Int32> streams,
  ffi.Pointer<ffi.Int32> coupled_streams,
  int application,
);
typedef _opus_projection_encode_C = ffi.Int32 Function(
  ffi.Pointer<OpusProjectionEncoder> st,
  ffi.Pointer<ffi.Int16> pcm,
  ffi.Int32 frame_size,
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 max_data_bytes,
);
typedef _opus_projection_encode_Dart = int Function(
  ffi.Pointer<OpusProjectionEncoder> st,
  ffi.Pointer<ffi.Int16> pcm,
  int frame_size,
  ffi.Pointer<ffi.Uint8> data,
  int max_data_bytes,
);
typedef _opus_projection_encode_float_C = ffi.Int32 Function(
  ffi.Pointer<OpusProjectionEncoder> st,
  ffi.Pointer<ffi.Float> pcm,
  ffi.Int32 frame_size,
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 max_data_bytes,
);
typedef _opus_projection_encode_float_Dart = int Function(
  ffi.Pointer<OpusProjectionEncoder> st,
  ffi.Pointer<ffi.Float> pcm,
  int frame_size,
  ffi.Pointer<ffi.Uint8> data,
  int max_data_bytes,
);
typedef _opus_projection_encoder_destroy_C = ffi.Void Function(
  ffi.Pointer<OpusProjectionEncoder> st,
);
typedef _opus_projection_encoder_destroy_Dart = void Function(
  ffi.Pointer<OpusProjectionEncoder> st,
);
typedef _opus_projection_decoder_get_size_C = ffi.Int32 Function(
  ffi.Int32 channels,
  ffi.Int32 streams,
  ffi.Int32 coupled_streams,
);
typedef _opus_projection_decoder_get_size_Dart = int Function(
  int channels,
  int streams,
  int coupled_streams,
);
typedef _opus_projection_decoder_create_C = ffi.Pointer<OpusProjectionDecoder>
    Function(
  ffi.Int32 Fs,
  ffi.Int32 channels,
  ffi.Int32 streams,
  ffi.Int32 coupled_streams,
  ffi.Pointer<ffi.Uint8> demixing_matrix,
  ffi.Int32 demixing_matrix_size,
  ffi.Pointer<ffi.Int32> error,
);
typedef _opus_projection_decoder_create_Dart
    = ffi.Pointer<OpusProjectionDecoder> Function(
  int Fs,
  int channels,
  int streams,
  int coupled_streams,
  ffi.Pointer<ffi.Uint8> demixing_matrix,
  int demixing_matrix_size,
  ffi.Pointer<ffi.Int32> error,
);
typedef _opus_projection_decoder_init_C = ffi.Int32 Function(
  ffi.Pointer<OpusProjectionDecoder> st,
  ffi.Int32 Fs,
  ffi.Int32 channels,
  ffi.Int32 streams,
  ffi.Int32 coupled_streams,
  ffi.Pointer<ffi.Uint8> demixing_matrix,
  ffi.Int32 demixing_matrix_size,
);
typedef _opus_projection_decoder_init_Dart = int Function(
  ffi.Pointer<OpusProjectionDecoder> st,
  int Fs,
  int channels,
  int streams,
  int coupled_streams,
  ffi.Pointer<ffi.Uint8> demixing_matrix,
  int demixing_matrix_size,
);
typedef _opus_projection_decode_C = ffi.Int32 Function(
  ffi.Pointer<OpusProjectionDecoder> st,
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 len,
  ffi.Pointer<ffi.Int16> pcm,
  ffi.Int32 frame_size,
  ffi.Int32 decode_fec,
);
typedef _opus_projection_decode_Dart = int Function(
  ffi.Pointer<OpusProjectionDecoder> st,
  ffi.Pointer<ffi.Uint8> data,
  int len,
  ffi.Pointer<ffi.Int16> pcm,
  int frame_size,
  int decode_fec,
);
typedef _opus_projection_decode_float_C = ffi.Int32 Function(
  ffi.Pointer<OpusProjectionDecoder> st,
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 len,
  ffi.Pointer<ffi.Float> pcm,
  ffi.Int32 frame_size,
  ffi.Int32 decode_fec,
);
typedef _opus_projection_decode_float_Dart = int Function(
  ffi.Pointer<OpusProjectionDecoder> st,
  ffi.Pointer<ffi.Uint8> data,
  int len,
  ffi.Pointer<ffi.Float> pcm,
  int frame_size,
  int decode_fec,
);
typedef _opus_projection_decoder_destroy_C = ffi.Void Function(
  ffi.Pointer<OpusProjectionDecoder> st,
);
typedef _opus_projection_decoder_destroy_Dart = void Function(
  ffi.Pointer<OpusProjectionDecoder> st,
);

class FunctionsAndGlobals {
  FunctionsAndGlobals(ffi.DynamicLibrary _dynamicLibrary)
      : _opus_projection_ambisonics_encoder_get_size =
            _dynamicLibrary.lookupFunction<
                _opus_projection_ambisonics_encoder_get_size_C,
                _opus_projection_ambisonics_encoder_get_size_Dart>(
          'opus_projection_ambisonics_encoder_get_size',
        ),
        _opus_projection_ambisonics_encoder_create =
            _dynamicLibrary.lookupFunction<
                _opus_projection_ambisonics_encoder_create_C,
                _opus_projection_ambisonics_encoder_create_Dart>(
          'opus_projection_ambisonics_encoder_create',
        ),
        _opus_projection_ambisonics_encoder_init =
            _dynamicLibrary.lookupFunction<
                _opus_projection_ambisonics_encoder_init_C,
                _opus_projection_ambisonics_encoder_init_Dart>(
          'opus_projection_ambisonics_encoder_init',
        ),
        _opus_projection_encode = _dynamicLibrary.lookupFunction<
            _opus_projection_encode_C, _opus_projection_encode_Dart>(
          'opus_projection_encode',
        ),
        _opus_projection_encode_float = _dynamicLibrary.lookupFunction<
            _opus_projection_encode_float_C,
            _opus_projection_encode_float_Dart>(
          'opus_projection_encode_float',
        ),
        _opus_projection_encoder_destroy = _dynamicLibrary.lookupFunction<
            _opus_projection_encoder_destroy_C,
            _opus_projection_encoder_destroy_Dart>(
          'opus_projection_encoder_destroy',
        ),
        _opus_projection_decoder_get_size = _dynamicLibrary.lookupFunction<
            _opus_projection_decoder_get_size_C,
            _opus_projection_decoder_get_size_Dart>(
          'opus_projection_decoder_get_size',
        ),
        _opus_projection_decoder_create = _dynamicLibrary.lookupFunction<
            _opus_projection_decoder_create_C,
            _opus_projection_decoder_create_Dart>(
          'opus_projection_decoder_create',
        ),
        _opus_projection_decoder_init = _dynamicLibrary.lookupFunction<
            _opus_projection_decoder_init_C,
            _opus_projection_decoder_init_Dart>(
          'opus_projection_decoder_init',
        ),
        _opus_projection_decode = _dynamicLibrary.lookupFunction<
            _opus_projection_decode_C, _opus_projection_decode_Dart>(
          'opus_projection_decode',
        ),
        _opus_projection_decode_float = _dynamicLibrary.lookupFunction<
            _opus_projection_decode_float_C,
            _opus_projection_decode_float_Dart>(
          'opus_projection_decode_float',
        ),
        _opus_projection_decoder_destroy = _dynamicLibrary.lookupFunction<
            _opus_projection_decoder_destroy_C,
            _opus_projection_decoder_destroy_Dart>(
          'opus_projection_decoder_destroy',
        );

  /// Gets the size of an OpusProjectionEncoder structure.
  /// @param channels <tt>int</tt>: The total number of input channels to encode.
  /// This must be no more than 255.
  /// @param mapping_family <tt>int</tt>: The mapping family to use for selecting
  /// the appropriate projection.
  /// @returns The size in bytes on success, or a negative error code
  /// (see @ref opus_errorcodes) on error.
  int opus_projection_ambisonics_encoder_get_size(
    int channels,
    int mapping_family,
  ) {
    return _opus_projection_ambisonics_encoder_get_size(
        channels, mapping_family);
  }

  final _opus_projection_ambisonics_encoder_get_size_Dart
      _opus_projection_ambisonics_encoder_get_size;

  /// Allocates and initializes a projection encoder state.
  /// Call opus_projection_encoder_destroy() to release
  /// this object when finished.
  /// @param Fs <tt>opus_int32</tt>: Sampling rate of the input signal (in Hz).
  /// This must be one of 8000, 12000, 16000,
  /// 24000, or 48000.
  /// @param channels <tt>int</tt>: Number of channels in the input signal.
  /// This must be at most 255.
  /// It may be greater than the number of
  /// coded channels (<code>streams +
  /// coupled_streams</code>).
  /// @param mapping_family <tt>int</tt>: The mapping family to use for selecting
  /// the appropriate projection.
  /// @param[out] streams <tt>int *</tt>: The total number of streams that will
  /// be encoded from the input.
  /// @param[out] coupled_streams <tt>int *</tt>: Number of coupled (2 channel)
  /// streams that will be encoded from the input.
  /// @param application <tt>int</tt>: The target encoder application.
  /// This must be one of the following:
  /// <dl>
  /// <dt>#OPUS_APPLICATION_VOIP</dt>
  /// <dd>Process signal for improved speech intelligibility.</dd>
  /// <dt>#OPUS_APPLICATION_AUDIO</dt>
  /// <dd>Favor faithfulness to the original input.</dd>
  /// <dt>#OPUS_APPLICATION_RESTRICTED_LOWDELAY</dt>
  /// <dd>Configure the minimum possible coding delay by disabling certain modes
  /// of operation.</dd>
  /// </dl>
  /// @param[out] error <tt>int *</tt>: Returns #OPUS_OK on success, or an error
  /// code (see @ref opus_errorcodes) on
  /// failure.
  ffi.Pointer<OpusProjectionEncoder> opus_projection_ambisonics_encoder_create(
    int Fs,
    int channels,
    int mapping_family,
    ffi.Pointer<ffi.Int32> streams,
    ffi.Pointer<ffi.Int32> coupled_streams,
    int application,
    ffi.Pointer<ffi.Int32> error,
  ) {
    return _opus_projection_ambisonics_encoder_create(Fs, channels,
        mapping_family, streams, coupled_streams, application, error);
  }

  final _opus_projection_ambisonics_encoder_create_Dart
      _opus_projection_ambisonics_encoder_create;

  /// Initialize a previously allocated projection encoder state.
  /// The memory pointed to by a st must be at least the size returned by
  /// opus_projection_ambisonics_encoder_get_size().
  /// This is intended for applications which use their own allocator instead of
  /// malloc.
  /// To reset a previously initialized state, use the #OPUS_RESET_STATE CTL.
  /// @see opus_projection_ambisonics_encoder_create
  /// @see opus_projection_ambisonics_encoder_get_size
  /// @param st <tt>OpusProjectionEncoder*</tt>: Projection encoder state to initialize.
  /// @param Fs <tt>opus_int32</tt>: Sampling rate of the input signal (in Hz).
  /// This must be one of 8000, 12000, 16000,
  /// 24000, or 48000.
  /// @param channels <tt>int</tt>: Number of channels in the input signal.
  /// This must be at most 255.
  /// It may be greater than the number of
  /// coded channels (<code>streams +
  /// coupled_streams</code>).
  /// @param streams <tt>int</tt>: The total number of streams to encode from the
  /// input.
  /// This must be no more than the number of channels.
  /// @param coupled_streams <tt>int</tt>: Number of coupled (2 channel) streams
  /// to encode.
  /// This must be no larger than the total
  /// number of streams.
  /// Additionally, The total number of
  /// encoded channels (<code>streams +
  /// coupled_streams</code>) must be no
  /// more than the number of input channels.
  /// @param application <tt>int</tt>: The target encoder application.
  /// This must be one of the following:
  /// <dl>
  /// <dt>#OPUS_APPLICATION_VOIP</dt>
  /// <dd>Process signal for improved speech intelligibility.</dd>
  /// <dt>#OPUS_APPLICATION_AUDIO</dt>
  /// <dd>Favor faithfulness to the original input.</dd>
  /// <dt>#OPUS_APPLICATION_RESTRICTED_LOWDELAY</dt>
  /// <dd>Configure the minimum possible coding delay by disabling certain modes
  /// of operation.</dd>
  /// </dl>
  /// @returns #OPUS_OK on success, or an error code (see @ref opus_errorcodes)
  /// on failure.
  int opus_projection_ambisonics_encoder_init(
    ffi.Pointer<OpusProjectionEncoder> st,
    int Fs,
    int channels,
    int mapping_family,
    ffi.Pointer<ffi.Int32> streams,
    ffi.Pointer<ffi.Int32> coupled_streams,
    int application,
  ) {
    return _opus_projection_ambisonics_encoder_init(st, Fs, channels,
        mapping_family, streams, coupled_streams, application);
  }

  final _opus_projection_ambisonics_encoder_init_Dart
      _opus_projection_ambisonics_encoder_init;

  /// Encodes a projection Opus frame.
  /// @param st <tt>OpusProjectionEncoder*</tt>: Projection encoder state.
  /// @param[in] pcm <tt>const opus_int16*</tt>: The input signal as interleaved
  /// samples.
  /// This must contain
  /// <code>frame_size*channels</code>
  /// samples.
  /// @param frame_size <tt>int</tt>: Number of samples per channel in the input
  /// signal.
  /// This must be an Opus frame size for the
  /// encoder's sampling rate.
  /// For example, at 48 kHz the permitted values
  /// are 120, 240, 480, 960, 1920, and 2880.
  /// Passing in a duration of less than 10 ms
  /// (480 samples at 48 kHz) will prevent the
  /// encoder from using the LPC or hybrid modes.
  /// @param[out] data <tt>unsigned char*</tt>: Output payload.
  /// This must contain storage for at
  /// least a max_data_bytes.
  /// @param [in] max_data_bytes <tt>opus_int32</tt>: Size of the allocated
  /// memory for the output
  /// payload. This may be
  /// used to impose an upper limit on
  /// the instant bitrate, but should
  /// not be used as the only bitrate
  /// control. Use #OPUS_SET_BITRATE to
  /// control the bitrate.
  /// @returns The length of the encoded packet (in bytes) on success or a
  /// negative error code (see @ref opus_errorcodes) on failure.
  int opus_projection_encode(
    ffi.Pointer<OpusProjectionEncoder> st,
    ffi.Pointer<ffi.Int16> pcm,
    int frame_size,
    ffi.Pointer<ffi.Uint8> data,
    int max_data_bytes,
  ) {
    return _opus_projection_encode(st, pcm, frame_size, data, max_data_bytes);
  }

  final _opus_projection_encode_Dart _opus_projection_encode;

  /// Encodes a projection Opus frame from floating point input.
  /// @param st <tt>OpusProjectionEncoder*</tt>: Projection encoder state.
  /// @param[in] pcm <tt>const float*</tt>: The input signal as interleaved
  /// samples with a normal range of
  /// +/-1.0.
  /// Samples with a range beyond +/-1.0
  /// are supported but will be clipped by
  /// decoders using the integer API and
  /// should only be used if it is known
  /// that the far end supports extended
  /// dynamic range.
  /// This must contain
  /// <code>frame_size*channels</code>
  /// samples.
  /// @param frame_size <tt>int</tt>: Number of samples per channel in the input
  /// signal.
  /// This must be an Opus frame size for the
  /// encoder's sampling rate.
  /// For example, at 48 kHz the permitted values
  /// are 120, 240, 480, 960, 1920, and 2880.
  /// Passing in a duration of less than 10 ms
  /// (480 samples at 48 kHz) will prevent the
  /// encoder from using the LPC or hybrid modes.
  /// @param[out] data <tt>unsigned char*</tt>: Output payload.
  /// This must contain storage for at
  /// least a max_data_bytes.
  /// @param [in] max_data_bytes <tt>opus_int32</tt>: Size of the allocated
  /// memory for the output
  /// payload. This may be
  /// used to impose an upper limit on
  /// the instant bitrate, but should
  /// not be used as the only bitrate
  /// control. Use #OPUS_SET_BITRATE to
  /// control the bitrate.
  /// @returns The length of the encoded packet (in bytes) on success or a
  /// negative error code (see @ref opus_errorcodes) on failure.
  int opus_projection_encode_float(
    ffi.Pointer<OpusProjectionEncoder> st,
    ffi.Pointer<ffi.Float> pcm,
    int frame_size,
    ffi.Pointer<ffi.Uint8> data,
    int max_data_bytes,
  ) {
    return _opus_projection_encode_float(
        st, pcm, frame_size, data, max_data_bytes);
  }

  final _opus_projection_encode_float_Dart _opus_projection_encode_float;

  /// Frees an <code>OpusProjectionEncoder</code> allocated by
  /// opus_projection_ambisonics_encoder_create().
  /// @param st <tt>OpusProjectionEncoder*</tt>: Projection encoder state to be freed.
  void opus_projection_encoder_destroy(
    ffi.Pointer<OpusProjectionEncoder> st,
  ) {
    _opus_projection_encoder_destroy(st);
  }

  final _opus_projection_encoder_destroy_Dart _opus_projection_encoder_destroy;

  /// Gets the size of an <code>OpusProjectionDecoder</code> structure.
  /// @param channels <tt>int</tt>: The total number of output channels.
  /// This must be no more than 255.
  /// @param streams <tt>int</tt>: The total number of streams coded in the
  /// input.
  /// This must be no more than 255.
  /// @param coupled_streams <tt>int</tt>: Number streams to decode as coupled
  /// (2 channel) streams.
  /// This must be no larger than the total
  /// number of streams.
  /// Additionally, The total number of
  /// coded channels (<code>streams +
  /// coupled_streams</code>) must be no
  /// more than 255.
  /// @returns The size in bytes on success, or a negative error code
  /// (see @ref opus_errorcodes) on error.
  int opus_projection_decoder_get_size(
    int channels,
    int streams,
    int coupled_streams,
  ) {
    return _opus_projection_decoder_get_size(
        channels, streams, coupled_streams);
  }

  final _opus_projection_decoder_get_size_Dart
      _opus_projection_decoder_get_size;

  /// Allocates and initializes a projection decoder state.
  /// Call opus_projection_decoder_destroy() to release
  /// this object when finished.
  /// @param Fs <tt>opus_int32</tt>: Sampling rate to decode at (in Hz).
  /// This must be one of 8000, 12000, 16000,
  /// 24000, or 48000.
  /// @param channels <tt>int</tt>: Number of channels to output.
  /// This must be at most 255.
  /// It may be different from the number of coded
  /// channels (<code>streams +
  /// coupled_streams</code>).
  /// @param streams <tt>int</tt>: The total number of streams coded in the
  /// input.
  /// This must be no more than 255.
  /// @param coupled_streams <tt>int</tt>: Number of streams to decode as coupled
  /// (2 channel) streams.
  /// This must be no larger than the total
  /// number of streams.
  /// Additionally, The total number of
  /// coded channels (<code>streams +
  /// coupled_streams</code>) must be no
  /// more than 255.
  /// @param[in] demixing_matrix <tt>const unsigned char[demixing_matrix_size]</tt>: Demixing matrix
  /// that mapping from coded channels to output channels,
  /// as described in @ref opus_projection and
  /// @ref opus_projection_ctls.
  /// @param demixing_matrix_size <tt>opus_int32</tt>: The size in bytes of the
  /// demixing matrix, as
  /// described in @ref
  /// opus_projection_ctls.
  /// @param[out] error <tt>int *</tt>: Returns #OPUS_OK on success, or an error
  /// code (see @ref opus_errorcodes) on
  /// failure.
  ffi.Pointer<OpusProjectionDecoder> opus_projection_decoder_create(
    int Fs,
    int channels,
    int streams,
    int coupled_streams,
    ffi.Pointer<ffi.Uint8> demixing_matrix,
    int demixing_matrix_size,
    ffi.Pointer<ffi.Int32> error,
  ) {
    return _opus_projection_decoder_create(Fs, channels, streams,
        coupled_streams, demixing_matrix, demixing_matrix_size, error);
  }

  final _opus_projection_decoder_create_Dart _opus_projection_decoder_create;

  /// Intialize a previously allocated projection decoder state object.
  /// The memory pointed to by a st must be at least the size returned by
  /// opus_projection_decoder_get_size().
  /// This is intended for applications which use their own allocator instead of
  /// malloc.
  /// To reset a previously initialized state, use the #OPUS_RESET_STATE CTL.
  /// @see opus_projection_decoder_create
  /// @see opus_projection_deocder_get_size
  /// @param st <tt>OpusProjectionDecoder*</tt>: Projection encoder state to initialize.
  /// @param Fs <tt>opus_int32</tt>: Sampling rate to decode at (in Hz).
  /// This must be one of 8000, 12000, 16000,
  /// 24000, or 48000.
  /// @param channels <tt>int</tt>: Number of channels to output.
  /// This must be at most 255.
  /// It may be different from the number of coded
  /// channels (<code>streams +
  /// coupled_streams</code>).
  /// @param streams <tt>int</tt>: The total number of streams coded in the
  /// input.
  /// This must be no more than 255.
  /// @param coupled_streams <tt>int</tt>: Number of streams to decode as coupled
  /// (2 channel) streams.
  /// This must be no larger than the total
  /// number of streams.
  /// Additionally, The total number of
  /// coded channels (<code>streams +
  /// coupled_streams</code>) must be no
  /// more than 255.
  /// @param[in] demixing_matrix <tt>const unsigned char[demixing_matrix_size]</tt>: Demixing matrix
  /// that mapping from coded channels to output channels,
  /// as described in @ref opus_projection and
  /// @ref opus_projection_ctls.
  /// @param demixing_matrix_size <tt>opus_int32</tt>: The size in bytes of the
  /// demixing matrix, as
  /// described in @ref
  /// opus_projection_ctls.
  /// @returns #OPUS_OK on success, or an error code (see @ref opus_errorcodes)
  /// on failure.
  int opus_projection_decoder_init(
    ffi.Pointer<OpusProjectionDecoder> st,
    int Fs,
    int channels,
    int streams,
    int coupled_streams,
    ffi.Pointer<ffi.Uint8> demixing_matrix,
    int demixing_matrix_size,
  ) {
    return _opus_projection_decoder_init(st, Fs, channels, streams,
        coupled_streams, demixing_matrix, demixing_matrix_size);
  }

  final _opus_projection_decoder_init_Dart _opus_projection_decoder_init;

  /// Decode a projection Opus packet.
  /// @param st <tt>OpusProjectionDecoder*</tt>: Projection decoder state.
  /// @param[in] data <tt>const unsigned char*</tt>: Input payload.
  /// Use a <code>NULL</code>
  /// pointer to indicate packet
  /// loss.
  /// @param len <tt>opus_int32</tt>: Number of bytes in payload.
  /// @param[out] pcm <tt>opus_int16*</tt>: Output signal, with interleaved
  /// samples.
  /// This must contain room for
  /// <code>frame_size*channels</code>
  /// samples.
  /// @param frame_size <tt>int</tt>: The number of samples per channel of
  /// available space in a pcm.
  /// If this is less than the maximum packet duration
  /// (120 ms; 5760 for 48kHz), this function will not be capable
  /// of decoding some packets. In the case of PLC (data==NULL)
  /// or FEC (decode_fec=1), then frame_size needs to be exactly
  /// the duration of audio that is missing, otherwise the
  /// decoder will not be in the optimal state to decode the
  /// next incoming packet. For the PLC and FEC cases, frame_size
  /// <b>must</b> be a multiple of 2.5 ms.
  /// @param decode_fec <tt>int</tt>: Flag (0 or 1) to request that any in-band
  /// forward error correction data be decoded.
  /// If no such data is available, the frame is
  /// decoded as if it were lost.
  /// @returns Number of samples decoded on success or a negative error code
  /// (see @ref opus_errorcodes) on failure.
  int opus_projection_decode(
    ffi.Pointer<OpusProjectionDecoder> st,
    ffi.Pointer<ffi.Uint8> data,
    int len,
    ffi.Pointer<ffi.Int16> pcm,
    int frame_size,
    int decode_fec,
  ) {
    return _opus_projection_decode(st, data, len, pcm, frame_size, decode_fec);
  }

  final _opus_projection_decode_Dart _opus_projection_decode;

  /// Decode a projection Opus packet with floating point output.
  /// @param st <tt>OpusProjectionDecoder*</tt>: Projection decoder state.
  /// @param[in] data <tt>const unsigned char*</tt>: Input payload.
  /// Use a <code>NULL</code>
  /// pointer to indicate packet
  /// loss.
  /// @param len <tt>opus_int32</tt>: Number of bytes in payload.
  /// @param[out] pcm <tt>opus_int16*</tt>: Output signal, with interleaved
  /// samples.
  /// This must contain room for
  /// <code>frame_size*channels</code>
  /// samples.
  /// @param frame_size <tt>int</tt>: The number of samples per channel of
  /// available space in a pcm.
  /// If this is less than the maximum packet duration
  /// (120 ms; 5760 for 48kHz), this function will not be capable
  /// of decoding some packets. In the case of PLC (data==NULL)
  /// or FEC (decode_fec=1), then frame_size needs to be exactly
  /// the duration of audio that is missing, otherwise the
  /// decoder will not be in the optimal state to decode the
  /// next incoming packet. For the PLC and FEC cases, frame_size
  /// <b>must</b> be a multiple of 2.5 ms.
  /// @param decode_fec <tt>int</tt>: Flag (0 or 1) to request that any in-band
  /// forward error correction data be decoded.
  /// If no such data is available, the frame is
  /// decoded as if it were lost.
  /// @returns Number of samples decoded on success or a negative error code
  /// (see @ref opus_errorcodes) on failure.
  int opus_projection_decode_float(
    ffi.Pointer<OpusProjectionDecoder> st,
    ffi.Pointer<ffi.Uint8> data,
    int len,
    ffi.Pointer<ffi.Float> pcm,
    int frame_size,
    int decode_fec,
  ) {
    return _opus_projection_decode_float(
        st, data, len, pcm, frame_size, decode_fec);
  }

  final _opus_projection_decode_float_Dart _opus_projection_decode_float;

  /// Frees an <code>OpusProjectionDecoder</code> allocated by
  /// opus_projection_decoder_create().
  /// @param st <tt>OpusProjectionDecoder</tt>: Projection decoder state to be freed.
  void opus_projection_decoder_destroy(
    ffi.Pointer<OpusProjectionDecoder> st,
  ) {
    _opus_projection_decoder_destroy(st);
  }

  final _opus_projection_decoder_destroy_Dart _opus_projection_decoder_destroy;
}
