import 'package:ffi_tool/c.dart';

import 'types.dart';

const List<Element> opus_repacketizer = <Element>[
  Struct(
      documentation: '''Opus repacketizer state.''',
      name: 'OpusRepacketizer',
      fields: []),
  Func(
      documentation:
          '''Gets the size of an <code>OpusRepacketizer</code> structure.
@returns The size in bytes.''',
      name: 'opus_repacketizer_get_size',
      parameterTypes: [],
      parameterNames: null,
      returnType: t_int),
  Func(
      documentation:
          '''(Re)initializes a previously allocated repacketizer state.
The state must be at least the size returned by opus_repacketizer_get_size().
This can be used for applications which use their own allocator instead of
malloc().
It must also be called to reset the queue of packets waiting to be
repacketized, which is necessary if the maximum packet duration of 120 ms
is reached or if you wish to submit packets with a different Opus
configuration (coding mode, audio bandwidth, frame size, or channel count).
Failure to do so will prevent a new packet from being added with
opus_repacketizer_cat().
@see opus_repacketizer_create
@see opus_repacketizer_get_size
@see opus_repacketizer_cat
@param rp <tt>OpusRepacketizer*</tt>: The repacketizer state to
(re)initialize.
@returns A pointer to the same repacketizer state that was passed in.''',
      name: 'opus_repacketizer_init',
      parameterTypes: [tp_OpusRepacketizer],
      parameterNames: ['rp'],
      returnType: tp_OpusRepacketizer),
  Func(
      documentation:
          '''Allocates memory and initializes the new repacketizer with
* opus_repacketizer_init().''',
      name: 'opus_repacketizer_create',
      parameterTypes: [],
      parameterNames: null,
      returnType: tp_OpusRepacketizer),
  Func(
      documentation:
          '''Frees an <code>OpusRepacketizer</code> allocated by
opus_repacketizer_create().
@param[in] rp <tt>OpusRepacketizer*</tt>: State to be freed.''',
      name: 'opus_repacketizer_destroy',
      parameterTypes: [tp_OpusRepacketizer],
      parameterNames: ['rp'],
      returnType: t_void),
  Func(
      documentation:
          '''Add a packet to the current repacketizer state.
This packet must match the configuration of any packets already submitted
for repacketization since the last call to opus_repacketizer_init().
This means that it must have the same coding mode, audio bandwidth, frame
size, and channel count.
This can be checked in advance by examining the top 6 bits of the first
byte of the packet, and ensuring they match the top 6 bits of the first
byte of any previously submitted packet.
The total duration of audio in the repacketizer state also must not exceed
120 ms, the maximum duration of a single packet, after adding this packet.
*
The contents of the current repacketizer state can be extracted into new
packets using opus_repacketizer_out() or opus_repacketizer_out_range().
*
In order to add a packet with a different configuration or to add more
audio beyond 120 ms, you must clear the repacketizer state by calling
opus_repacketizer_init().
If a packet is too large to add to the current repacketizer state, no part
of it is added, even if it contains multiple frames, some of which might
fit.
If you wish to be able to add parts of such packets, you should first use
another repacketizer to split the packet into pieces and add them
individually.
@see opus_repacketizer_out_range
@see opus_repacketizer_out
@see opus_repacketizer_init
@param rp <tt>OpusRepacketizer*</tt>: The repacketizer state to which to
add the packet.
@param[in] data <tt>const unsigned char*</tt>: The packet data.
The application must ensure
this pointer remains valid
until the next call to
opus_repacketizer_init() or
opus_repacketizer_destroy().
@param len <tt>opus_int32</tt>: The number of bytes in the packet data.
@returns An error code indicating whether or not the operation succeeded.
@retval #OPUS_OK The packet's contents have been added to the repacketizer
state.
@retval #OPUS_INVALID_PACKET The packet did not have a valid TOC sequence,
the packet's TOC sequence was not compatible
with previously submitted packets (because
the coding mode, audio bandwidth, frame size,
or channel count did not match), or adding
this packet would increase the total amount of
audio stored in the repacketizer state to more
than 120 ms.''',
      name: 'opus_repacketizer_cat',
      parameterTypes: [tp_OpusRepacketizer, tp_unsigned_char, t_opus_int32],
      parameterNames: ['rp', 'data', 'len'],
      returnType: t_int),
  Func(
      documentation:
          '''Construct a new packet from data previously submitted to the repacketizer
state via opus_repacketizer_cat().
@param rp <tt>OpusRepacketizer*</tt>: The repacketizer state from which to
construct the new packet.
@param begin <tt>int</tt>: The index of the first frame in the current
repacketizer state to include in the output.
@param end <tt>int</tt>: One past the index of the last frame in the
current repacketizer state to include in the
output.
@param[out] data <tt>const unsigned char*</tt>: The buffer in which to
store the output packet.
@param maxlen <tt>opus_int32</tt>: The maximum number of bytes to store in
the output buffer. In order to guarantee
success, this should be at least
<code>1276</code> for a single frame,
or for multiple frames,
<code>1277*(end-begin)</code>.
However, <code>1*(end-begin)</code> plus
the size of all packet data submitted to
the repacketizer since the last call to
opus_repacketizer_init() or
opus_repacketizer_create() is also
sufficient, and possibly much smaller.
@returns The total size of the output packet on success, or an error code
on failure.
@retval #OPUS_BAD_ARG <code>[begin,end)</code> was an invalid range of
frames (begin < 0, begin >= end, or end >
opus_repacketizer_get_nb_frames()).
@retval #OPUS_BUFFER_TOO_SMALL \a maxlen was insufficient to contain the
complete output packet.''',
      name: 'opus_repacketizer_out_range',
      parameterTypes: [
        tp_OpusRepacketizer,
        t_int,
        t_int,
        tp_unsigned_char,
        t_opus_int32
      ],
      parameterNames: ['rp', 'begin', 'end', 'data', 'maxlen'],
      returnType: t_opus_int32),
  Func(
      documentation:
          '''Return the total number of frames contained in packet data submitted to
the repacketizer state so far via opus_repacketizer_cat() since the last
call to opus_repacketizer_init() or opus_repacketizer_create().
This defines the valid range of packets that can be extracted with
opus_repacketizer_out_range() or opus_repacketizer_out().
@param rp <tt>OpusRepacketizer*</tt>: The repacketizer state containing the
frames.
@returns The total number of frames contained in the packet data submitted
to the repacketizer state.''',
      name: 'opus_repacketizer_get_nb_frames',
      parameterTypes: [tp_OpusRepacketizer],
      parameterNames: ['rp'],
      returnType: t_int),
  Func(
      documentation:
          '''Construct a new packet from data previously submitted to the repacketizer
state via opus_repacketizer_cat().
This is a convenience routine that returns all the data submitted so far
in a single packet.
It is equivalent to calling
@code
opus_repacketizer_out_range(rp, 0, opus_repacketizer_get_nb_frames(rp),
data, maxlen)
@endcode
@param rp <tt>OpusRepacketizer*</tt>: The repacketizer state from which to
construct the new packet.
@param[out] data <tt>const unsigned char*</tt>: The buffer in which to
store the output packet.
@param maxlen <tt>opus_int32</tt>: The maximum number of bytes to store in
the output buffer. In order to guarantee
success, this should be at least
<code>1277*opus_repacketizer_get_nb_frames(rp)</code>.
However,
<code>1*opus_repacketizer_get_nb_frames(rp)</code>
plus the size of all packet data
submitted to the repacketizer since the
last call to opus_repacketizer_init() or
opus_repacketizer_create() is also
sufficient, and possibly much smaller.
@returns The total size of the output packet on success, or an error code
on failure.
@retval #OPUS_BUFFER_TOO_SMALL \a maxlen was insufficient to contain the
complete output packet.''',
      name: 'opus_repacketizer_out',
      parameterTypes: [tp_OpusRepacketizer, tp_unsigned_char, t_opus_int32],
      parameterNames: ['rp', 'data', 'maxlen'],
      returnType: t_opus_int32),
  Func(
      documentation:
          '''Pads a given Opus packet to a larger size (possibly changing the TOC sequence).
@param[in,out] data <tt>const unsigned char*</tt>: The buffer containing the
packet to pad.
@param len <tt>opus_int32</tt>: The size of the packet.
This must be at least 1.
@param new_len <tt>opus_int32</tt>: The desired size of the packet after padding.
This must be at least as large as len.
@returns an error code
@retval #OPUS_OK \a on success.
@retval #OPUS_BAD_ARG \a len was less than 1 or new_len was less than len.
@retval #OPUS_INVALID_PACKET \a data did not contain a valid Opus packet.''',
      name: 'opus_packet_pad',
      parameterTypes: [tp_unsigned_char, t_opus_int32, t_opus_int32],
      parameterNames: ['data', 'len', 'new_len'],
      returnType: t_int),
  Func(
      documentation:
          '''Remove all padding from a given Opus packet and rewrite the TOC sequence to
minimize space usage.
@param[in,out] data <tt>const unsigned char*</tt>: The buffer containing the
packet to strip.
@param len <tt>opus_int32</tt>: The size of the packet.
This must be at least 1.
@returns The new size of the output packet on success, or an error code
on failure.
@retval #OPUS_BAD_ARG \a len was less than 1.
@retval #OPUS_INVALID_PACKET \a data did not contain a valid Opus packet.''',
      name: 'opus_packet_unpad',
      parameterTypes: [tp_unsigned_char, t_opus_int32],
      parameterNames: ['data', 'len'],
      returnType: t_opus_int32),
  Func(
      documentation:
          '''Pads a given Opus multi-stream packet to a larger size (possibly changing the TOC sequence).
@param[in,out] data <tt>const unsigned char*</tt>: The buffer containing the
packet to pad.
@param len <tt>opus_int32</tt>: The size of the packet.
This must be at least 1.
@param new_len <tt>opus_int32</tt>: The desired size of the packet after padding.
This must be at least 1.
@param nb_streams <tt>opus_int32</tt>: The number of streams (not channels) in the packet.
This must be at least as large as len.
@returns an error code
@retval #OPUS_OK \a on success.
@retval #OPUS_BAD_ARG \a len was less than 1.
@retval #OPUS_INVALID_PACKET \a data did not contain a valid Opus packet.''',
      name: 'opus_multistream_packet_pad',
      parameterTypes: [tp_unsigned_char, t_opus_int32, t_opus_int32, t_int],
      parameterNames: ['data', 'len', 'new_len', 'nb_streams'],
      returnType: t_int),
  Func(
      documentation:
          '''Remove all padding from a given Opus multi-stream packet and rewrite the TOC sequence to
minimize space usage.
@param[in,out] data <tt>const unsigned char*</tt>: The buffer containing the
packet to strip.
@param len <tt>opus_int32</tt>: The size of the packet.
This must be at least 1.
@param nb_streams <tt>opus_int32</tt>: The number of streams (not channels) in the packet.
This must be at least 1.
@returns The new size of the output packet on success, or an error code
on failure.
@retval #OPUS_BAD_ARG \a len was less than 1 or new_len was less than len.
@retval #OPUS_INVALID_PACKET \a data did not contain a valid Opus packet.''',
      name: 'opus_multistream_packet_unpad',
      parameterTypes: [tp_unsigned_char, t_opus_int32, t_int],
      parameterNames: ['data', 'len', 'nb_streams'],
      returnType: t_opus_int32)
];
