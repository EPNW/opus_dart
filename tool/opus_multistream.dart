import 'package:ffi_tool/c.dart';

import 'types.dart';

const List<Element> opus_multistream = <Element>[
  Struct(
      documentation: '''Opus multistream encoder state.
This contains the complete state of a multistream Opus encoder.
It is position independent and can be freely copied.
@see opus_multistream_encoder_create
@see opus_multistream_encoder_init''',
      name: 'OpusMSEncoder',
      fields: []),
  Struct(
      documentation: '''Opus multistream decoder state.
This contains the complete state of a multistream Opus decoder.
It is position independent and can be freely copied.
@see opus_multistream_decoder_create
@see opus_multistream_decoder_init''',
      name: 'OpusMSDecoder',
      fields: []),
  Func(
      documentation: '''Gets the size of an OpusMSEncoder structure.
@param streams <tt>int</tt>: The total number of streams to encode from the
input.
This must be no more than 255.
@param coupled_streams <tt>int</tt>: Number of coupled (2 channel) streams
to encode.
This must be no larger than the total
number of streams.
Additionally, The total number of
encoded channels (<code>streams +
coupled_streams</code>) must be no
more than 255.
@returns The size in bytes on success, or a negative error code
(see @ref opus_errorcodes) on error.''',
      name: 'opus_multistream_encoder_get_size',
      parameterTypes: [t_int, t_int],
      parameterNames: ['streams', 'coupled_streams'],
      returnType: t_opus_int32),
  Func(
      documentation: '''Gets the size of an OpusMSEncoder structure.''',
      name: 'opus_multistream_surround_encoder_get_size',
      parameterTypes: [t_int, t_int],
      parameterNames: ['channels', 'mapping_family'],
      returnType: t_opus_int32),
  Func(
      documentation: '''Allocates and initializes a multistream encoder state.
Call opus_multistream_encoder_destroy() to release
this object when finished.
@param Fs <tt>opus_int32</tt>: Sampling rate of the input signal (in Hz).
This must be one of 8000, 12000, 16000,
24000, or 48000.
@param channels <tt>int</tt>: Number of channels in the input signal.
This must be at most 255.
It may be greater than the number of
coded channels (<code>streams +
coupled_streams</code>).
@param streams <tt>int</tt>: The total number of streams to encode from the
input.
This must be no more than the number of channels.
@param coupled_streams <tt>int</tt>: Number of coupled (2 channel) streams
to encode.
This must be no larger than the total
number of streams.
Additionally, The total number of
encoded channels (<code>streams +
coupled_streams</code>) must be no
more than the number of input channels.
@param[in] mapping <code>const unsigned char[channels]</code>: Mapping from
encoded channels to input channels, as described in
@ref opus_multistream. As an extra constraint, the
multistream encoder does not allow encoding coupled
streams for which one channel is unused since this
is never a good idea.
@param application <tt>int</tt>: The target encoder application.
This must be one of the following:
<dl>
<dt>#OPUS_APPLICATION_VOIP</dt>
<dd>Process signal for improved speech intelligibility.</dd>
<dt>#OPUS_APPLICATION_AUDIO</dt>
<dd>Favor faithfulness to the original input.</dd>
<dt>#OPUS_APPLICATION_RESTRICTED_LOWDELAY</dt>
<dd>Configure the minimum possible coding delay by disabling certain modes
of operation.</dd>
</dl>
@param[out] error <tt>int *</tt>: Returns #OPUS_OK on success, or an error
code (see @ref opus_errorcodes) on
failure.''',
      name: 'opus_multistream_encoder_create',
      parameterTypes: [
        t_opus_int32,
        t_int,
        t_int,
        t_int,
        tp_unsigned_char,
        t_int,
        tp_int
      ],
      parameterNames: [
        'Fs',
        'channels',
        'streams',
        'coupled_streams',
        'mapping',
        'application',
        'error'
      ],
      returnType: tp_OpusMSEncoder),
  Func(
      documentation:
          '''Allocates and initializes a multistream encoder state.''',
      name: 'opus_multistream_surround_encoder_create',
      parameterTypes: [
        t_opus_int32,
        t_int,
        t_int,
        tp_int,
        tp_int,
        tp_unsigned_char,
        t_int,
        tp_int
      ],
      parameterNames: [
        'Fs',
        'channels',
        'mapping_family',
        'streams',
        'coupled_streams',
        'mapping',
        'application',
        'error'
      ],
      returnType: tp_OpusMSEncoder),
  Func(
      documentation:
          '''Initialize a previously allocated multistream encoder state.
The memory pointed to by \a st must be at least the size returned by
opus_multistream_encoder_get_size().
This is intended for applications which use their own allocator instead of
malloc.
To reset a previously initialized state, use the #OPUS_RESET_STATE CTL.
@see opus_multistream_encoder_create
@see opus_multistream_encoder_get_size
@param st <tt>OpusMSEncoder*</tt>: Multistream encoder state to initialize.
@param Fs <tt>opus_int32</tt>: Sampling rate of the input signal (in Hz).
This must be one of 8000, 12000, 16000,
24000, or 48000.
@param channels <tt>int</tt>: Number of channels in the input signal.
This must be at most 255.
It may be greater than the number of
coded channels (<code>streams +
coupled_streams</code>).
@param streams <tt>int</tt>: The total number of streams to encode from the
input.
This must be no more than the number of channels.
@param coupled_streams <tt>int</tt>: Number of coupled (2 channel) streams
to encode.
This must be no larger than the total
number of streams.
Additionally, The total number of
encoded channels (<code>streams +
coupled_streams</code>) must be no
more than the number of input channels.
@param[in] mapping <code>const unsigned char[channels]</code>: Mapping from
encoded channels to input channels, as described in
@ref opus_multistream. As an extra constraint, the
multistream encoder does not allow encoding coupled
streams for which one channel is unused since this
is never a good idea.
@param application <tt>int</tt>: The target encoder application.
This must be one of the following:
<dl>
<dt>#OPUS_APPLICATION_VOIP</dt>
<dd>Process signal for improved speech intelligibility.</dd>
<dt>#OPUS_APPLICATION_AUDIO</dt>
<dd>Favor faithfulness to the original input.</dd>
<dt>#OPUS_APPLICATION_RESTRICTED_LOWDELAY</dt>
<dd>Configure the minimum possible coding delay by disabling certain modes
of operation.</dd>
</dl>
@returns #OPUS_OK on success, or an error code (see @ref opus_errorcodes)
on failure.''',
      name: 'opus_multistream_encoder_init',
      parameterTypes: [
        tp_OpusMSEncoder,
        t_opus_int32,
        t_int,
        t_int,
        t_int,
        tp_unsigned_char,
        t_int
      ],
      parameterNames: [
        'st',
        'Fs',
        'channels',
        'streams',
        'coupled_streams',
        'mapping',
        'application'
      ],
      returnType: t_int),
  Func(
      documentation:
          '''Initialize a previously allocated multistream encoder state.''',
      name: 'opus_multistream_surround_encoder_init',
      parameterTypes: [
        tp_OpusMSEncoder,
        t_opus_int32,
        t_int,
        t_int,
        tp_int,
        tp_int,
        tp_unsigned_char,
        t_int
      ],
      parameterNames: [
        'st',
        'Fs',
        'channels',
        'mapping_family',
        'streams',
        'coupled_streams',
        'mapping',
        'application'
      ],
      returnType: t_int),
  Func(
      documentation: '''Encodes a multistream Opus frame.
@param st <tt>OpusMSEncoder*</tt>: Multistream encoder state.
@param[in] pcm <tt>const opus_int16*</tt>: The input signal as interleaved
samples.
This must contain
<code>frame_size*channels</code>
samples.
@param frame_size <tt>int</tt>: Number of samples per channel in the input
signal.
This must be an Opus frame size for the
encoder's sampling rate.
For example, at 48 kHz the permitted values
are 120, 240, 480, 960, 1920, and 2880.
Passing in a duration of less than 10 ms
(480 samples at 48 kHz) will prevent the
encoder from using the LPC or hybrid modes.
@param[out] data <tt>unsigned char*</tt>: Output payload.
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
      name: 'opus_multistream_encode',
      parameterTypes: [
        tp_OpusMSEncoder,
        tp_opus_int16,
        t_int,
        tp_unsigned_char,
        t_opus_int32
      ],
      parameterNames: ['st', 'pcm', 'frame_size', 'data', 'max_data_bytes'],
      returnType: t_int),
  Func(
      documentation:
          '''Encodes a multistream Opus frame from floating point input.
@param st <tt>OpusMSEncoder*</tt>: Multistream encoder state.
@param[in] pcm <tt>const float*</tt>: The input signal as interleaved
samples with a normal range of
+/-1.0.
Samples with a range beyond +/-1.0
are supported but will be clipped by
decoders using the integer API and
should only be used if it is known
that the far end supports extended
dynamic range.
This must contain
<code>frame_size*channels</code>
samples.
@param frame_size <tt>int</tt>: Number of samples per channel in the input
signal.
This must be an Opus frame size for the
encoder's sampling rate.
For example, at 48 kHz the permitted values
are 120, 240, 480, 960, 1920, and 2880.
Passing in a duration of less than 10 ms
(480 samples at 48 kHz) will prevent the
encoder from using the LPC or hybrid modes.
@param[out] data <tt>unsigned char*</tt>: Output payload.
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
      name: 'opus_multistream_encode_float',
      parameterTypes: [
        tp_OpusMSEncoder,
        tp_float,
        t_int,
        tp_unsigned_char,
        t_opus_int32
      ],
      parameterNames: ['st', 'pcm', 'frame_size', 'data', 'max_data_bytes'],
      returnType: t_int),
  Func(
      documentation: '''Frees an <code>OpusMSEncoder</code> allocated by
opus_multistream_encoder_create().
@param st <tt>OpusMSEncoder*</tt>: Multistream encoder state to be freed.''',
      name: 'opus_multistream_encoder_destroy',
      parameterTypes: [tp_OpusMSEncoder],
      parameterNames: ['st'],
      returnType: t_void),
  Func(
      documentation:
          '''Gets the size of an <code>OpusMSDecoder</code> structure.
@param streams <tt>int</tt>: The total number of streams coded in the
input.
This must be no more than 255.
@param coupled_streams <tt>int</tt>: Number streams to decode as coupled
(2 channel) streams.
This must be no larger than the total
number of streams.
Additionally, The total number of
coded channels (<code>streams +
coupled_streams</code>) must be no
more than 255.
@returns The size in bytes on success, or a negative error code
(see @ref opus_errorcodes) on error.''',
      name: 'opus_multistream_decoder_get_size',
      parameterTypes: [t_int, t_int],
      parameterNames: ['streams', 'coupled_streams'],
      returnType: t_opus_int32),
  Func(
      documentation: '''Allocates and initializes a multistream decoder state.
Call opus_multistream_decoder_destroy() to release
this object when finished.
@param Fs <tt>opus_int32</tt>: Sampling rate to decode at (in Hz).
This must be one of 8000, 12000, 16000,
24000, or 48000.
@param channels <tt>int</tt>: Number of channels to output.
This must be at most 255.
It may be different from the number of coded
channels (<code>streams +
coupled_streams</code>).
@param streams <tt>int</tt>: The total number of streams coded in the
input.
This must be no more than 255.
@param coupled_streams <tt>int</tt>: Number of streams to decode as coupled
(2 channel) streams.
This must be no larger than the total
number of streams.
Additionally, The total number of
coded channels (<code>streams +
coupled_streams</code>) must be no
more than 255.
@param[in] mapping <code>const unsigned char[channels]</code>: Mapping from
coded channels to output channels, as described in
@ref opus_multistream.
@param[out] error <tt>int *</tt>: Returns #OPUS_OK on success, or an error
code (see @ref opus_errorcodes) on
failure.''',
      name: 'opus_multistream_decoder_create',
      parameterTypes: [
        t_opus_int32,
        t_int,
        t_int,
        t_int,
        tp_unsigned_char,
        tp_int
      ],
      parameterNames: [
        'Fs',
        'channels',
        'streams',
        'coupled_streams',
        'mapping',
        'error'
      ],
      returnType: tp_OpusMSDecoder),
  Func(
      documentation: '''Intialize a previously allocated decoder state object.
The memory pointed to by \a st must be at least the size returned by
opus_multistream_encoder_get_size().
This is intended for applications which use their own allocator instead of
malloc.
To reset a previously initialized state, use the #OPUS_RESET_STATE CTL.
@see opus_multistream_decoder_create
@see opus_multistream_deocder_get_size
@param st <tt>OpusMSEncoder*</tt>: Multistream encoder state to initialize.
@param Fs <tt>opus_int32</tt>: Sampling rate to decode at (in Hz).
This must be one of 8000, 12000, 16000,
24000, or 48000.
@param channels <tt>int</tt>: Number of channels to output.
This must be at most 255.
It may be different from the number of coded
channels (<code>streams +
coupled_streams</code>).
@param streams <tt>int</tt>: The total number of streams coded in the
input.
This must be no more than 255.
@param coupled_streams <tt>int</tt>: Number of streams to decode as coupled
(2 channel) streams.
This must be no larger than the total
number of streams.
Additionally, The total number of
coded channels (<code>streams +
coupled_streams</code>) must be no
more than 255.
@param[in] mapping <code>const unsigned char[channels]</code>: Mapping from
coded channels to output channels, as described in
@ref opus_multistream.
@returns #OPUS_OK on success, or an error code (see @ref opus_errorcodes)
on failure.''',
      name: 'opus_multistream_decoder_init',
      parameterTypes: [
        tp_OpusMSDecoder,
        t_opus_int32,
        t_int,
        t_int,
        t_int,
        tp_unsigned_char
      ],
      parameterNames: [
        'st',
        'Fs',
        'channels',
        'streams',
        'coupled_streams',
        'mapping'
      ],
      returnType: t_int),
  Func(
      documentation: '''Decode a multistream Opus packet.
@param st <tt>OpusMSDecoder*</tt>: Multistream decoder state.
@param[in] data <tt>const unsigned char*</tt>: Input payload.
Use a <code>NULL</code>
pointer to indicate packet
loss.
@param len <tt>opus_int32</tt>: Number of bytes in payload.
@param[out] pcm <tt>opus_int16*</tt>: Output signal, with interleaved
samples.
This must contain room for
<code>frame_size*channels</code>
samples.
@param frame_size <tt>int</tt>: The number of samples per channel of
available space in \a pcm.
If this is less than the maximum packet duration
(120 ms; 5760 for 48kHz), this function will not be capable
of decoding some packets. In the case of PLC (data==NULL)
or FEC (decode_fec=1), then frame_size needs to be exactly
the duration of audio that is missing, otherwise the
decoder will not be in the optimal state to decode the
next incoming packet. For the PLC and FEC cases, frame_size
<b>must</b> be a multiple of 2.5 ms.
@param decode_fec <tt>int</tt>: Flag (0 or 1) to request that any in-band
forward error correction data be decoded.
If no such data is available, the frame is
decoded as if it were lost.
@returns Number of samples decoded on success or a negative error code
(see @ref opus_errorcodes) on failure.''',
      name: 'opus_multistream_decode',
      parameterTypes: [
        tp_OpusMSDecoder,
        tp_unsigned_char,
        t_opus_int32,
        tp_opus_int16,
        t_int,
        t_int
      ],
      parameterNames: ['st', 'data', 'len', 'pcm', 'frame_size', 'decode_fec'],
      returnType: t_int),
  Func(
      documentation:
          '''Decode a multistream Opus packet with floating point output.
@param st <tt>OpusMSDecoder*</tt>: Multistream decoder state.
@param[in] data <tt>const unsigned char*</tt>: Input payload.
Use a <code>NULL</code>
pointer to indicate packet
loss.
@param len <tt>opus_int32</tt>: Number of bytes in payload.
@param[out] pcm <tt>opus_int16*</tt>: Output signal, with interleaved
samples.
This must contain room for
<code>frame_size*channels</code>
samples.
@param frame_size <tt>int</tt>: The number of samples per channel of
available space in \a pcm.
If this is less than the maximum packet duration
(120 ms; 5760 for 48kHz), this function will not be capable
of decoding some packets. In the case of PLC (data==NULL)
or FEC (decode_fec=1), then frame_size needs to be exactly
the duration of audio that is missing, otherwise the
decoder will not be in the optimal state to decode the
next incoming packet. For the PLC and FEC cases, frame_size
<b>must</b> be a multiple of 2.5 ms.
@param decode_fec <tt>int</tt>: Flag (0 or 1) to request that any in-band
forward error correction data be decoded.
If no such data is available, the frame is
decoded as if it were lost.
@returns Number of samples decoded on success or a negative error code
(see @ref opus_errorcodes) on failure.''',
      name: 'opus_multistream_decode_float',
      parameterTypes: [
        tp_OpusMSDecoder,
        tp_unsigned_char,
        t_opus_int32,
        tp_float,
        t_int,
        t_int
      ],
      parameterNames: ['st', 'data', 'len', 'pcm', 'frame_size', 'decode_fec'],
      returnType: t_int),
  Func(
      documentation: '''Frees an <code>OpusMSDecoder</code> allocated by
opus_multistream_decoder_create().
@param st <tt>OpusMSDecoder</tt>: Multistream decoder state to be freed.''',
      name: 'opus_multistream_decoder_destroy',
      parameterTypes: [tp_OpusMSDecoder],
      parameterNames: ['st'],
      returnType: t_void)
];
