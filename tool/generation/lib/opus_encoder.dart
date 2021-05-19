import 'package:ffi_tool/c.dart';

import 'types.dart';

///opus_encoder_ctl is missing since variadic are not yet supported by dart ffi
const List<Element> opus_encoder = <Element>[
  Struct(
      documentation: '''Opus encoder state.
This contains the complete state of an Opus encoder.
It is position independent and can be freely copied.
@see opus_encoder_create,opus_encoder_init''',
      name: 'OpusEncoder',
      fields: []),
  Func(
      documentation: '''Gets the size of an <code>OpusEncoder</code> structure.
@param [in] channels <tt>int</tt>: Number of channels.
                                   This must be 1 or 2.
@returns The size in bytes.''',
      returnType: t_int,
      name: 'opus_encoder_get_size',
      parameterTypes: [t_int],
      parameterNames: ['channels']),
  Func(
      documentation: '''Allocates and initializes an encoder state.
There are three coding modes:

OPUS_APPLICATION_VOIP gives best quality at a given bitrate for voice
signals. It enhances the  input signal by high-pass filtering and
emphasizing formants and harmonics. Optionally  it includes in-band
forward error correction to protect against packet loss. Use this
mode for typical VoIP applications. Because of the enhancement,
even at high bitrates the output may sound different from the input.

OPUS_APPLICATION_AUDIO gives best quality at a given bitrate for most
non-voice signals like music. Use this mode for music and mixed
(music/voice) content, broadcast, and applications requiring less
than 15 ms of coding delay.

OPUS_APPLICATION_RESTRICTED_LOWDELAY configures low-delay mode that
disables the speech-optimized mode in exchange for slightly reduced delay.
This mode can only be set on an newly initialized or freshly reset encoder
because it changes the codec delay.

This is useful when the caller knows that the speech-optimized modes will not be needed (use with caution).
@param [in] Fs <tt>opus_int32</tt>: Sampling rate of input signal (Hz)
                                    This must be one of 8000, 12000, 16000,
                                    24000, or 48000.
@param [in] channels <tt>int</tt>: Number of channels (1 or 2) in input signal
@param [in] application <tt>int</tt>: Coding mode (@ref OPUS_APPLICATION_VOIP/@ref OPUS_APPLICATION_AUDIO/@ref OPUS_APPLICATION_RESTRICTED_LOWDELAY)
@param [out] error <tt>int*</tt>: @ref opus_errorcodes
@note Regardless of the sampling rate and number channels selected, the Opus encoder
can switch to a lower audio bandwidth or number of channels if the bitrate
selected is too low. This also means that it is safe to always use 48 kHz stereo input
and let the encoder optimize the encoding.''',
      returnType: tp_OpusEncoder,
      name: 'opus_encoder_create',
      parameterTypes: [t_opus_int32, t_int, t_int, tp_int],
      parameterNames: ['Fs', 'channels', 'application', 'error']),
  Func(
      documentation: '''Initializes a previously allocated encoder state
The memory pointed to by st must be at least the size returned by opus_encoder_get_size().
This is intended for applications which use their own allocator instead of malloc.
@see opus_encoder_create(),opus_encoder_get_size()
To reset a previously initialized state, use the #OPUS_RESET_STATE CTL.
@param [in] st <tt>OpusEncoder*</tt>: Encoder state
@param [in] Fs <tt>opus_int32</tt>: Sampling rate of input signal (Hz)
                                    This must be one of 8000, 12000, 16000,
                                    24000, or 48000.
@param [in] channels <tt>int</tt>: Number of channels (1 or 2) in input signal
@param [in] application <tt>int</tt>: Coding mode (OPUS_APPLICATION_VOIP/OPUS_APPLICATION_AUDIO/OPUS_APPLICATION_RESTRICTED_LOWDELAY)
@retval #OPUS_OK Success or @ref opus_errorcodes''',
      returnType: t_int,
      name: 'opus_encoder_init',
      parameterTypes: [tp_OpusEncoder, t_opus_int32, t_int, t_int],
      parameterNames: ['st', 'Fs', 'channels', 'application']),
  Func(
      documentation: '''Encodes an Opus frame.
@param [in] st <tt>OpusEncoder*</tt>: Encoder state
@param [in] pcm <tt>opus_int16*</tt>: Input signal (interleaved if 2 channels). length is frame_size*channels*sizeof(opus_int16)
@param [in] frame_size <tt>int</tt>: Number of samples per channel in the
                                     input signal.
                                     This must be an Opus frame size for
                                     the encoder's sampling rate.
                                     For example, at 48 kHz the permitted
                                     values are 120, 240, 480, 960, 1920,
                                     and 2880.
                                     Passing in a duration of less than
                                     10 ms (480 samples at 48 kHz) will
                                     prevent the encoder from using the LPC
                                     or hybrid modes.
@param [out] data <tt>unsigned char*</tt>: Output payload.
                                           This must contain storage for at
                                           least \a max_data_bytes.
@param [in] max_data_bytes <tt>opus_int32</tt>: Size of the allocated
                                                memory for the output
                                                payload. This may be
                                                used to impose an upper limit on
                                                the instant bitrate, but should
                                                not be used as the only bitrate
                                                control. Use #OPUS_SET_BITRATE to
                                                control the bitrate.
@returns The length of the encoded packet (in bytes) on success or a
         negative error code (see @ref opus_errorcodes) on failure.''',
      returnType: t_opus_int32,
      name: 'opus_encode',
      parameterTypes: [
        tp_OpusEncoder,
        tp_opus_int16,
        t_int,
        tp_unsigned_char,
        t_opus_int32
      ],
      parameterNames: ['st', 'pcm', 'frame_size', 'data', 'max_data_bytes']),
  Func(
      documentation: '''Encodes an Opus frame from floating point input.
@param [in] st <tt>OpusEncoder*</tt>: Encoder state
@param [in] pcm <tt>float*</tt>: Input in float format (interleaved if 2 channels), with a normal range of +/-1.0.
         Samples with a range beyond +/-1.0 are supported but will
         be clipped by decoders using the integer API and should
         only be used if it is known that the far end supports
         extended dynamic range.
         length is frame_size*channels*sizeof(float)
@param [in] frame_size <tt>int</tt>: Number of samples per channel in the
                                     input signal.
                                     This must be an Opus frame size for
                                     the encoder's sampling rate.
                                     For example, at 48 kHz the permitted
                                     values are 120, 240, 480, 960, 1920,
                                     and 2880.
                                     Passing in a duration of less than
                                     10 ms (480 samples at 48 kHz) will
                                     prevent the encoder from using the LPC
                                     or hybrid modes.
@param [out] data <tt>unsigned char*</tt>: Output payload.
                                           This must contain storage for at
                                           least \a max_data_bytes.
@param [in] max_data_bytes <tt>opus_int32</tt>: Size of the allocated
                                                memory for the output
                                                payload. This may be
                                                used to impose an upper limit on
                                                the instant bitrate, but should
                                                not be used as the only bitrate
                                                control. Use #OPUS_SET_BITRATE to
                                                control the bitrate.
@returns The length of the encoded packet (in bytes) on success or a
         negative error code (see @ref opus_errorcodes) on failure.''',
      returnType: t_opus_int32,
      name: 'opus_encode_float',
      parameterTypes: [
        tp_OpusEncoder,
        tp_float,
        t_int,
        tp_unsigned_char,
        t_opus_int32
      ],
      parameterNames: ['st', 'pcm', 'frame_size', 'data', 'max_data_bytes']),
  Func(
      documentation:
          '''Frees an <code>OpusEncoder</code> allocated by opus_encoder_create().
@param [in] st <tt>OpusEncoder*</tt>: State to be freed.''',
      returnType: t_void,
      name: 'opus_encoder_destroy',
      parameterTypes: [tp_OpusEncoder],
      parameterNames: ['st'])
];
