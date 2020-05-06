import 'package:ffi_tool/c.dart';

import 'types.dart';

const List<Element> opus_custom = <Element>[
  Struct(
      documentation:
          '''Contains the state of an encoder. One encoder state is needed
for each stream. It is initialized once at the beginning of the
stream. Do *not* re-initialize the state for every frame.
@brief Encoder state''',
      name: 'OpusCustomEncoder',
      fields: []),
  Struct(
      documentation:
          '''State of the decoder. One decoder state is needed for each stream.
It is initialized once at the beginning of the stream. Do *not*
re-initialize the state for every frame.
@brief Decoder state''',
      name: 'OpusCustomDecoder',
      fields: []),
  Struct(
      documentation:
          '''The mode contains all the information necessary to create an
encoder. Both the encoder and decoder need to be initialized
with exactly the same mode, otherwise the output will be
corrupted.
@brief Mode configuration''',
      name: 'OpusCustomMode',
      fields: []),
  Func(
      documentation:
          '''Creates a new mode struct. This will be passed to an encoder or
decoder. The mode MUST NOT BE DESTROYED until the encoders and
decoders that use it are destroyed as well.
@param [in] Fs <tt>int</tt>: Sampling rate (8000 to 96000 Hz)
@param [in] frame_size <tt>int</tt>: Number of samples (per channel) to encode in each
packet (64 - 1024, prime factorization must contain zero or more 2s, 3s, or 5s and no other primes)
@param [out] error <tt>int*</tt>: Returned error code (if NULL, no error will be returned)
@return A newly created mode''',
      name: 'opus_custom_mode_create',
      parameterTypes: [t_opus_int32, t_int, tp_int],
      parameterNames: ['Fs', 'frame_size', 'error'],
      returnType: tp_OpusCustomMode),
  Func(
      documentation:
          '''Destroys a mode struct. Only call this after all encoders and
decoders using this mode are destroyed as well.
@param [in] mode <tt>OpusCustomMode*</tt>: Mode to be freed.''',
      name: 'opus_custom_mode_destroy',
      parameterTypes: [tp_OpusCustomMode],
      parameterNames: ['mode'],
      returnType: t_void),
  Func(
      documentation: '''Gets the size of an OpusCustomEncoder structure.
@param [in] mode <tt>OpusCustomMode *</tt>: Mode configuration
@param [in] channels <tt>int</tt>: Number of channels
@returns size''',
      name: 'opus_custom_encoder_get_size',
      parameterTypes: [tp_OpusCustomMode, t_int],
      parameterNames: ['mode', 'channels'],
      returnType: t_int),
  Func(
      documentation: '''Initializes a previously allocated encoder state
The memory pointed to by st must be the size returned by opus_custom_encoder_get_size.
This is intended for applications which use their own allocator instead of malloc.
@see opus_custom_encoder_create(),opus_custom_encoder_get_size()
To reset a previously initialized state use the OPUS_RESET_STATE CTL.
@param [in] st <tt>OpusCustomEncoder*</tt>: Encoder state
@param [in] mode <tt>OpusCustomMode *</tt>: Contains all the information about the characteristics of
the stream (must be the same characteristics as used for the
decoder)
@param [in] channels <tt>int</tt>: Number of channels
@return OPUS_OK Success or @ref opus_errorcodes''',
      name: 'opus_custom_encoder_init',
      parameterTypes: [tp_OpusCustomEncoder, tp_OpusCustomMode, t_int],
      parameterNames: ['st', 'mode', 'channels'],
      returnType: t_int),
  Func(
      documentation:
          '''Creates a new encoder state. Each stream needs its own encoder
state (can't be shared across simultaneous streams).
@param [in] mode <tt>OpusCustomMode*</tt>: Contains all the information about the characteristics of
the stream (must be the same characteristics as used for the
decoder)
@param [in] channels <tt>int</tt>: Number of channels
@param [out] error <tt>int*</tt>: Returns an error code
@return Newly created encoder state.''',
      name: 'opus_custom_encoder_create',
      parameterTypes: [tp_OpusCustomMode, t_int, tp_int],
      parameterNames: ['mode', 'channels', 'error'],
      returnType: tp_OpusCustomEncoder),
  Func(
      documentation: '''Destroys a an encoder state.
@param[in] st <tt>OpusCustomEncoder*</tt>: State to be freed.''',
      name: 'opus_custom_encoder_destroy',
      parameterTypes: [tp_OpusCustomEncoder],
      parameterNames: ['st'],
      returnType: t_void),
  Func(
      documentation: '''Encodes a frame of audio.
@param [in] st <tt>OpusCustomEncoder*</tt>: Encoder state
@param [in] pcm <tt>float*</tt>: PCM audio in float format, with a normal range of +/-1.0.
Samples with a range beyond +/-1.0 are supported but will
be clipped by decoders using the integer API and should
only be used if it is known that the far end supports
extended dynamic range. There must be exactly
frame_size samples per channel.
@param [in] frame_size <tt>int</tt>: Number of samples per frame of input signal
@param [out] compressed <tt>char *</tt>: The compressed data is written here. This may not alias pcm and must be at least maxCompressedBytes long.
@param [in] maxCompressedBytes <tt>int</tt>: Maximum number of bytes to use for compressing the frame
(can change from one frame to another)
@return Number of bytes written to "compressed".
If negative, an error has occurred (see error codes). It is IMPORTANT that
the length returned be somehow transmitted to the decoder. Otherwise, no
decoding is possible.''',
      name: 'opus_custom_encode_float',
      parameterTypes: [
        tp_OpusCustomEncoder,
        tp_float,
        t_int,
        tp_unsigned_char,
        t_int
      ],
      parameterNames: [
        'st',
        'pcm',
        'frame_size',
        'compressed',
        'maxCompressedBytes'
      ],
      returnType: t_int),
  Func(
      documentation: '''Encodes a frame of audio.
@param [in] st <tt>OpusCustomEncoder*</tt>: Encoder state
@param [in] pcm <tt>opus_int16*</tt>: PCM audio in signed 16-bit format (native endian).
There must be exactly frame_size samples per channel.
@param [in] frame_size <tt>int</tt>: Number of samples per frame of input signal
@param [out] compressed <tt>char *</tt>: The compressed data is written here. This may not alias pcm and must be at least maxCompressedBytes long.
@param [in] maxCompressedBytes <tt>int</tt>: Maximum number of bytes to use for compressing the frame
(can change from one frame to another)
@return Number of bytes written to "compressed".
If negative, an error has occurred (see error codes). It is IMPORTANT that
the length returned be somehow transmitted to the decoder. Otherwise, no
decoding is possible.''',
      name: 'opus_custom_encode',
      parameterTypes: [
        tp_OpusCustomEncoder,
        tp_opus_int16,
        t_int,
        tp_unsigned_char,
        t_int
      ],
      parameterNames: [
        'st',
        'pcm',
        'frame_size',
        'compressed',
        'maxCompressedBytes'
      ],
      returnType: t_int),
  Func(
      documentation: '''Gets the size of an OpusCustomDecoder structure.
@param [in] mode <tt>OpusCustomMode *</tt>: Mode configuration
@param [in] channels <tt>int</tt>: Number of channels
@returns size''',
      name: 'opus_custom_decoder_get_size',
      parameterTypes: [tp_OpusCustomMode, t_int],
      parameterNames: ['mode', 'channels'],
      returnType: t_int),
  Func(
      documentation: '''Initializes a previously allocated decoder state
The memory pointed to by st must be the size returned by opus_custom_decoder_get_size.
This is intended for applications which use their own allocator instead of malloc.
@see opus_custom_decoder_create(),opus_custom_decoder_get_size()
To reset a previously initialized state use the OPUS_RESET_STATE CTL.
@param [in] st <tt>OpusCustomDecoder*</tt>: Decoder state
@param [in] mode <tt>OpusCustomMode *</tt>: Contains all the information about the characteristics of
the stream (must be the same characteristics as used for the
encoder)
@param [in] channels <tt>int</tt>: Number of channels
@return OPUS_OK Success or @ref opus_errorcodes''',
      name: 'opus_custom_decoder_init',
      parameterTypes: [tp_OpusCustomDecoder, tp_OpusCustomMode, t_int],
      parameterNames: ['st', 'mode', 'channels'],
      returnType: t_int),
  Func(
      documentation:
          '''Creates a new decoder state. Each stream needs its own decoder state (can't
be shared across simultaneous streams).
@param [in] mode <tt>OpusCustomMode</tt>: Contains all the information about the characteristics of the
stream (must be the same characteristics as used for the encoder)
@param [in] channels <tt>int</tt>: Number of channels
@param [out] error <tt>int*</tt>: Returns an error code
@return Newly created decoder state.''',
      name: 'opus_custom_decoder_create',
      parameterTypes: [tp_OpusCustomMode, t_int, tp_int],
      parameterNames: ['mode', 'channels', 'error'],
      returnType: tp_OpusCustomDecoder),
  Func(
      documentation: '''Destroys a an decoder state.
@param[in] st <tt>OpusCustomDecoder*</tt>: State to be freed.''',
      name: 'opus_custom_decoder_destroy',
      parameterTypes: [tp_OpusCustomDecoder],
      parameterNames: ['st'],
      returnType: t_void),
  Func(
      documentation: '''Decode an opus custom frame with floating point output
@param [in] st <tt>OpusCustomDecoder*</tt>: Decoder state
@param [in] data <tt>char*</tt>: Input payload. Use a NULL pointer to indicate packet loss
@param [in] len <tt>int</tt>: Number of bytes in payload
@param [out] pcm <tt>float*</tt>: Output signal (interleaved if 2 channels). length
is frame_size*channels*sizeof(float)
@param [in] frame_size Number of samples per channel of available space in *pcm.
@returns Number of decoded samples or @ref opus_errorcodes''',
      name: 'opus_custom_decode_float',
      parameterTypes: [
        tp_OpusCustomDecoder,
        tp_unsigned_char,
        t_int,
        tp_float,
        t_int
      ],
      parameterNames: ['st', 'data', 'len', 'pcm', 'frame_size'],
      returnType: t_int),
  Func(
      documentation: '''Decode an opus custom frame
@param [in] st <tt>OpusCustomDecoder*</tt>: Decoder state
@param [in] data <tt>char*</tt>: Input payload. Use a NULL pointer to indicate packet loss
@param [in] len <tt>int</tt>: Number of bytes in payload
@param [out] pcm <tt>opus_int16*</tt>: Output signal (interleaved if 2 channels). length
is frame_size*channels*sizeof(opus_int16)
@param [in] frame_size Number of samples per channel of available space in *pcm.
@returns Number of decoded samples or @ref opus_errorcodes''',
      name: 'opus_custom_decode',
      parameterTypes: [
        tp_OpusCustomDecoder,
        tp_unsigned_char,
        t_int,
        tp_opus_int16,
        t_int
      ],
      parameterNames: ['st', 'data', 'len', 'pcm', 'frame_size'],
      returnType: t_int)
];
