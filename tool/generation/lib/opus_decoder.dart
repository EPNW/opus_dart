import 'package:ffi_tool/c.dart';

import 'types.dart';

///opus_decoder_ctl is missing since variadic are not yet supported by dart ffi
const List<Element> opus_decoder = <Element>[
  Opaque(
    documentation: '''Opus decoder state.
This contains the complete state of an Opus decoder.
It is position independent and can be freely copied.
@see opus_decoder_create,opus_decoder_init''',
    name: 'OpusDecoder',
  ),
  Func(
      documentation: '''Gets the size of an <code>OpusDecoder</code> structure.
@param [in] channels <tt>int</tt>: Number of channels.
                                   This must be 1 or 2.
@returns The size in bytes.''',
      returnType: t_int,
      name: 'opus_decoder_get_size',
      parameterTypes: [t_int],
      parameterNames: ['channels']),
  Func(
      documentation: '''Allocates and initializes a decoder state.
@param [in] Fs <tt>opus_int32</tt>: Sample rate to decode at (Hz).
                                    This must be one of 8000, 12000, 16000,
                                    24000, or 48000.
@param [in] channels <tt>int</tt>: Number of channels (1 or 2) to decode
@param [out] error <tt>int*</tt>: #OPUS_OK Success or @ref opus_errorcodes

Internally Opus stores data at 48000 Hz, so that should be the default
value for Fs. However, the decoder can efficiently decode to buffers
at 8, 12, 16, and 24 kHz so if for some reason the caller cannot use
data at the full sample rate, or knows the compressed data doesn't
use the full frequency range, it can request decoding at a reduced
rate. Likewise, the decoder is capable of filling in either mono or
interleaved stereo pcm buffers, at the caller's request.''',
      returnType: tp_OpusDecoder,
      name: 'opus_decoder_create',
      parameterTypes: [t_opus_int32, t_int, tp_int],
      parameterNames: ['Fs', 'channels', 'error']),
  Func(
      documentation: '''Initializes a previously allocated decoder state.
The state must be at least the size returned by opus_decoder_get_size().
This is intended for applications which use their own allocator instead of malloc. @see opus_decoder_create,opus_decoder_get_size
To reset a previously initialized state, use the #OPUS_RESET_STATE CTL.
@param [in] st <tt>OpusDecoder*</tt>: Decoder state.
@param [in] Fs <tt>opus_int32</tt>: Sampling rate to decode to (Hz).
                                    This must be one of 8000, 12000, 16000,
                                    24000, or 48000.
@param [in] channels <tt>int</tt>: Number of channels (1 or 2) to decode
@retval #OPUS_OK Success or @ref opus_errorcodes''',
      returnType: t_int,
      name: 'opus_decoder_init',
      parameterTypes: [tp_OpusDecoder, t_opus_int32, t_int],
      parameterNames: ['st', 'Fs', 'channels']),
  Func(
      documentation: '''Decode an Opus packet.
@param [in] st <tt>OpusDecoder*</tt>: Decoder state
@param [in] data <tt>char*</tt>: Input payload. Use a NULL pointer to indicate packet loss
@param [in] len <tt>opus_int32</tt>: Number of bytes in payload*
@param [out] pcm <tt>opus_int16*</tt>: Output signal (interleaved if 2 channels). length
 is frame_size*channels*sizeof(opus_int16)
@param [in] frame_size Number of samples per channel of available space in \a pcm.
 If this is less than the maximum packet duration (120ms; 5760 for 48kHz), this function will
 not be capable of decoding some packets. In the case of PLC (data==NULL) or FEC (decode_fec=1),
 then frame_size needs to be exactly the duration of audio that is missing, otherwise the
 decoder will not be in the optimal state to decode the next incoming packet. For the PLC and
 FEC cases, frame_size <b>must</b> be a multiple of 2.5 ms.
@param [in] decode_fec <tt>int</tt>: Flag (0 or 1) to request that any in-band forward error correction data be
 decoded. If no such data is available, the frame is decoded as if it were lost.
@returns Number of decoded samples or @ref opus_errorcodes''',
      returnType: t_int,
      name: 'opus_decode',
      parameterTypes: [
        tp_OpusDecoder,
        tp_unsigned_char,
        t_opus_int32,
        tp_opus_int16,
        t_int,
        t_int
      ],
      parameterNames: ['st', 'data', 'len', 'pcm', 'frame_size', 'decode_fec']),
  Func(
      documentation: '''Decode an Opus packet with floating point output.
@param [in] st <tt>OpusDecoder*</tt>: Decoder state
@param [in] data <tt>char*</tt>: Input payload. Use a NULL pointer to indicate packet loss
@param [in] len <tt>opus_int32</tt>: Number of bytes in payload
@param [out] pcm <tt>float*</tt>: Output signal (interleaved if 2 channels). length
 is frame_size*channels*sizeof(float)
@param [in] frame_size Number of samples per channel of available space in \a pcm.
 If this is less than the maximum packet duration (120ms; 5760 for 48kHz), this function will
 not be capable of decoding some packets. In the case of PLC (data==NULL) or FEC (decode_fec=1),
 then frame_size needs to be exactly the duration of audio that is missing, otherwise the
 decoder will not be in the optimal state to decode the next incoming packet. For the PLC and
 FEC cases, frame_size <b>must</b> be a multiple of 2.5 ms.
@param [in] decode_fec <tt>int</tt>: Flag (0 or 1) to request that any in-band forward error correction data be
 decoded. If no such data is available the frame is decoded as if it were lost.
@returns Number of decoded samples or @ref opus_errorcodes''',
      returnType: t_int,
      name: 'opus_decode_float',
      parameterTypes: [
        tp_OpusDecoder,
        tp_unsigned_char,
        t_opus_int32,
        tp_float,
        t_int,
        t_int
      ],
      parameterNames: ['st', 'data', 'len', 'pcm', 'frame_size', 'decode_fec']),
  Func(
      documentation:
          '''Frees an <code>OpusDecoder</code> allocated by opus_decoder_create().
@param [in] st <tt>OpusDecoder*</tt>: State to be freed.''',
      returnType: t_void,
      name: 'opus_decoder_destroy',
      parameterTypes: [tp_OpusDecoder],
      parameterNames: ['st']),
  Func(
      documentation: '''Parse an opus packet into one or more frames.
Opus_decode will perform this operation internally so most applications do
not need to use this function.
This function does not copy the frames, the returned pointers are pointers into
the input packet.
@param [in] data <tt>char*</tt>: Opus packet to be parsed
@param [in] len <tt>opus_int32</tt>: size of data
@param [out] out_toc <tt>char*</tt>: TOC pointer
@param [out] frames <tt>char*[48]</tt> encapsulated frames
@param [out] size <tt>opus_int16[48]</tt> sizes of the encapsulated frames
@param [out] payload_offset <tt>int*</tt>: returns the position of the payload within the packet (in bytes)
@returns number of frames''',
      returnType: t_int,
      name: 'opus_packet_parse',
      parameterTypes: [
        tp_unsigned_char,
        t_opus_int32,
        tp_unsigned_char,
        tp_unsigned_char,
        t_opus_int16,
        tp_int
      ],
      parameterNames: [
        'data',
        'len',
        'out_toc',
        'frames',
        'size',
        'payload_offset'
      ]),
  Func(
      documentation: '''Gets the bandwidth of an Opus packet.
@param [in] data <tt>char*</tt>: Opus packet
@retval OPUS_BANDWIDTH_NARROWBAND Narrowband (4kHz bandpass)
@retval OPUS_BANDWIDTH_MEDIUMBAND Mediumband (6kHz bandpass)
@retval OPUS_BANDWIDTH_WIDEBAND Wideband (8kHz bandpass)
@retval OPUS_BANDWIDTH_SUPERWIDEBAND Superwideband (12kHz bandpass)
@retval OPUS_BANDWIDTH_FULLBAND Fullband (20kHz bandpass)
@retval OPUS_INVALID_PACKET The compressed data passed is corrupted or of an unsupported type''',
      returnType: t_int,
      name: 'opus_packet_get_bandwidth',
      parameterTypes: [tp_unsigned_char],
      parameterNames: ['data']),
  Func(
      documentation:
          '''Gets the number of samples per frame from an Opus packet.
@param [in] data <tt>char*</tt>: Opus packet.
                                 This must contain at least one byte of
                                 data.
@param [in] Fs <tt>opus_int32</tt>: Sampling rate in Hz.
                                    This must be a multiple of 400, or
                                    inaccurate results will be returned.
@returns Number of samples per frame.''',
      returnType: t_int,
      name: 'opus_packet_get_samples_per_frame',
      parameterTypes: [tp_unsigned_char, t_opus_int32],
      parameterNames: ['data', 'Fs']),
  Func(
      documentation: '''Gets the number of channels from an Opus packet.
@param [in] data <tt>char*</tt>: Opus packet
@returns Number of channels
@retval OPUS_INVALID_PACKET The compressed data passed is corrupted or of an unsupported type''',
      returnType: t_int,
      name: 'opus_packet_get_nb_channels',
      parameterTypes: [tp_unsigned_char],
      parameterNames: ['data']),
  Func(
      documentation: '''Gets the number of frames in an Opus packet.
@param [in] packet <tt>char*</tt>: Opus packet
@param [in] len <tt>opus_int32</tt>: Length of packet
@returns Number of frames
@retval OPUS_BAD_ARG Insufficient data was passed to the function
@retval OPUS_INVALID_PACKET The compressed data passed is corrupted or of an unsupported type''',
      returnType: t_int,
      name: 'opus_packet_get_nb_frames',
      parameterTypes: [tp_unsigned_char, t_opus_int32],
      parameterNames: ['packet', 'len']),
  Func(
      documentation: '''Gets the number of samples of an Opus packet.
@param [in] packet <tt>char*</tt>: Opus packet
@param [in] len <tt>opus_int32</tt>: Length of packet
@param [in] Fs <tt>opus_int32</tt>: Sampling rate in Hz.
                                    This must be a multiple of 400, or
                                    inaccurate results will be returned.
@returns Number of samples
@retval OPUS_BAD_ARG Insufficient data was passed to the function
@retval OPUS_INVALID_PACKET The compressed data passed is corrupted or of an unsupported type''',
      returnType: t_int,
      name: 'opus_packet_get_nb_samples',
      parameterTypes: [tp_unsigned_char, t_opus_int32, t_opus_int32],
      parameterNames: ['packet', 'len', 'Fs']),
  Func(
      documentation: '''Gets the number of samples of an Opus packet.
@param [in] dec <tt>OpusDecoder*</tt>: Decoder state
@param [in] packet <tt>char*</tt>: Opus packet
@param [in] len <tt>opus_int32</tt>: Length of packet
@returns Number of samples
@retval OPUS_BAD_ARG Insufficient data was passed to the function
@retval OPUS_INVALID_PACKET The compressed data passed is corrupted or of an unsupported type''',
      returnType: t_int,
      name: 'opus_decoder_get_nb_samples',
      parameterTypes: [tp_OpusDecoder, tp_unsigned_char, t_opus_int32],
      parameterNames: ['dec', 'packet', 'len']),
  Func(
      documentation:
          '''Applies soft-clipping to bring a float signal within the [-1,1] range. If
the signal is already in that range, nothing is done. If there are values
outside of [-1,1], then the signal is clipped as smoothly as possible to
both fit in the range and avoid creating excessive distortion in the
process.
@param [in,out] pcm <tt>float*</tt>: Input PCM and modified PCM
@param [in] frame_size <tt>int</tt> Number of samples per channel to process
@param [in] channels <tt>int</tt>: Number of channels
@param [in,out] softclip_mem <tt>float*</tt>: State memory for the soft clipping process (one float per channel, initialized to zero)''',
      returnType: t_void,
      name: 'opus_pcm_soft_clip',
      parameterTypes: [tp_float, t_int, t_int, tp_float],
      parameterNames: ['pcm', 'frame_size', 'channels', 'softclip_mem'])
];
