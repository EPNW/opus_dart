/// Contains methods and structs from the opus_repacketizer group of opus.h.
/// SHOULD be imported as opus_repacketizer.
///
/// AUTOMATICALLY GENERATED FILE. DO NOT MODIFY.
// ignore_for_file: camel_case_types, non_constant_identifier_names, constant_identifier_names

// We are going to ignore subtype_of_sealed_class since dart analysis does not
// get the imports right when differentiating between web_ffi and dart:ffi
// ignore_for_file: subtype_of_sealed_class

library opus_repacketizer;

import '../src/proxy_ffi.dart' as ffi;

/// Opus repacketizer state.
class OpusRepacketizer extends ffi.Opaque {}

typedef _opus_repacketizer_get_size_C = ffi.Int32 Function();
typedef _opus_repacketizer_get_size_Dart = int Function();
typedef _opus_repacketizer_init_C = ffi.Pointer<OpusRepacketizer> Function(
  ffi.Pointer<OpusRepacketizer> rp,
);
typedef _opus_repacketizer_init_Dart = ffi.Pointer<OpusRepacketizer> Function(
  ffi.Pointer<OpusRepacketizer> rp,
);
typedef _opus_repacketizer_create_C = ffi.Pointer<OpusRepacketizer> Function();
typedef _opus_repacketizer_create_Dart = ffi.Pointer<OpusRepacketizer>
    Function();
typedef _opus_repacketizer_destroy_C = ffi.Void Function(
  ffi.Pointer<OpusRepacketizer> rp,
);
typedef _opus_repacketizer_destroy_Dart = void Function(
  ffi.Pointer<OpusRepacketizer> rp,
);
typedef _opus_repacketizer_cat_C = ffi.Int32 Function(
  ffi.Pointer<OpusRepacketizer> rp,
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 len,
);
typedef _opus_repacketizer_cat_Dart = int Function(
  ffi.Pointer<OpusRepacketizer> rp,
  ffi.Pointer<ffi.Uint8> data,
  int len,
);
typedef _opus_repacketizer_out_range_C = ffi.Int32 Function(
  ffi.Pointer<OpusRepacketizer> rp,
  ffi.Int32 begin,
  ffi.Int32 end,
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 maxlen,
);
typedef _opus_repacketizer_out_range_Dart = int Function(
  ffi.Pointer<OpusRepacketizer> rp,
  int begin,
  int end,
  ffi.Pointer<ffi.Uint8> data,
  int maxlen,
);
typedef _opus_repacketizer_get_nb_frames_C = ffi.Int32 Function(
  ffi.Pointer<OpusRepacketizer> rp,
);
typedef _opus_repacketizer_get_nb_frames_Dart = int Function(
  ffi.Pointer<OpusRepacketizer> rp,
);
typedef _opus_repacketizer_out_C = ffi.Int32 Function(
  ffi.Pointer<OpusRepacketizer> rp,
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 maxlen,
);
typedef _opus_repacketizer_out_Dart = int Function(
  ffi.Pointer<OpusRepacketizer> rp,
  ffi.Pointer<ffi.Uint8> data,
  int maxlen,
);
typedef _opus_packet_pad_C = ffi.Int32 Function(
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 len,
  ffi.Int32 new_len,
);
typedef _opus_packet_pad_Dart = int Function(
  ffi.Pointer<ffi.Uint8> data,
  int len,
  int new_len,
);
typedef _opus_packet_unpad_C = ffi.Int32 Function(
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 len,
);
typedef _opus_packet_unpad_Dart = int Function(
  ffi.Pointer<ffi.Uint8> data,
  int len,
);
typedef _opus_multistream_packet_pad_C = ffi.Int32 Function(
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 len,
  ffi.Int32 new_len,
  ffi.Int32 nb_streams,
);
typedef _opus_multistream_packet_pad_Dart = int Function(
  ffi.Pointer<ffi.Uint8> data,
  int len,
  int new_len,
  int nb_streams,
);
typedef _opus_multistream_packet_unpad_C = ffi.Int32 Function(
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 len,
  ffi.Int32 nb_streams,
);
typedef _opus_multistream_packet_unpad_Dart = int Function(
  ffi.Pointer<ffi.Uint8> data,
  int len,
  int nb_streams,
);

class FunctionsAndGlobals {
  FunctionsAndGlobals(ffi.DynamicLibrary _dynamicLibrary)
      : _opus_repacketizer_get_size = _dynamicLibrary.lookupFunction<
            _opus_repacketizer_get_size_C, _opus_repacketizer_get_size_Dart>(
          'opus_repacketizer_get_size',
        ),
        _opus_repacketizer_init = _dynamicLibrary.lookupFunction<
            _opus_repacketizer_init_C, _opus_repacketizer_init_Dart>(
          'opus_repacketizer_init',
        ),
        _opus_repacketizer_create = _dynamicLibrary.lookupFunction<
            _opus_repacketizer_create_C, _opus_repacketizer_create_Dart>(
          'opus_repacketizer_create',
        ),
        _opus_repacketizer_destroy = _dynamicLibrary.lookupFunction<
            _opus_repacketizer_destroy_C, _opus_repacketizer_destroy_Dart>(
          'opus_repacketizer_destroy',
        ),
        _opus_repacketizer_cat = _dynamicLibrary.lookupFunction<
            _opus_repacketizer_cat_C, _opus_repacketizer_cat_Dart>(
          'opus_repacketizer_cat',
        ),
        _opus_repacketizer_out_range = _dynamicLibrary.lookupFunction<
            _opus_repacketizer_out_range_C, _opus_repacketizer_out_range_Dart>(
          'opus_repacketizer_out_range',
        ),
        _opus_repacketizer_get_nb_frames = _dynamicLibrary.lookupFunction<
            _opus_repacketizer_get_nb_frames_C,
            _opus_repacketizer_get_nb_frames_Dart>(
          'opus_repacketizer_get_nb_frames',
        ),
        _opus_repacketizer_out = _dynamicLibrary.lookupFunction<
            _opus_repacketizer_out_C, _opus_repacketizer_out_Dart>(
          'opus_repacketizer_out',
        ),
        _opus_packet_pad = _dynamicLibrary
            .lookupFunction<_opus_packet_pad_C, _opus_packet_pad_Dart>(
          'opus_packet_pad',
        ),
        _opus_packet_unpad = _dynamicLibrary
            .lookupFunction<_opus_packet_unpad_C, _opus_packet_unpad_Dart>(
          'opus_packet_unpad',
        ),
        _opus_multistream_packet_pad = _dynamicLibrary.lookupFunction<
            _opus_multistream_packet_pad_C, _opus_multistream_packet_pad_Dart>(
          'opus_multistream_packet_pad',
        ),
        _opus_multistream_packet_unpad = _dynamicLibrary.lookupFunction<
            _opus_multistream_packet_unpad_C,
            _opus_multistream_packet_unpad_Dart>(
          'opus_multistream_packet_unpad',
        );

  /// Gets the size of an <code>OpusRepacketizer</code> structure.
  /// @returns The size in bytes.
  int opus_repacketizer_get_size() {
    return _opus_repacketizer_get_size();
  }

  final _opus_repacketizer_get_size_Dart _opus_repacketizer_get_size;

  /// (Re)initializes a previously allocated repacketizer state.
  /// The state must be at least the size returned by opus_repacketizer_get_size().
  /// This can be used for applications which use their own allocator instead of
  /// malloc().
  /// It must also be called to reset the queue of packets waiting to be
  /// repacketized, which is necessary if the maximum packet duration of 120 ms
  /// is reached or if you wish to submit packets with a different Opus
  /// configuration (coding mode, audio bandwidth, frame size, or channel count).
  /// Failure to do so will prevent a new packet from being added with
  /// opus_repacketizer_cat().
  /// @see opus_repacketizer_create
  /// @see opus_repacketizer_get_size
  /// @see opus_repacketizer_cat
  /// @param rp <tt>OpusRepacketizer*</tt>: The repacketizer state to
  /// (re)initialize.
  /// @returns A pointer to the same repacketizer state that was passed in.
  ffi.Pointer<OpusRepacketizer> opus_repacketizer_init(
    ffi.Pointer<OpusRepacketizer> rp,
  ) {
    return _opus_repacketizer_init(rp);
  }

  final _opus_repacketizer_init_Dart _opus_repacketizer_init;

  /// Allocates memory and initializes the new repacketizer with
  /// * opus_repacketizer_init().
  ffi.Pointer<OpusRepacketizer> opus_repacketizer_create() {
    return _opus_repacketizer_create();
  }

  final _opus_repacketizer_create_Dart _opus_repacketizer_create;

  /// Frees an <code>OpusRepacketizer</code> allocated by
  /// opus_repacketizer_create().
  /// @param[in] rp <tt>OpusRepacketizer*</tt>: State to be freed.
  void opus_repacketizer_destroy(
    ffi.Pointer<OpusRepacketizer> rp,
  ) {
    _opus_repacketizer_destroy(rp);
  }

  final _opus_repacketizer_destroy_Dart _opus_repacketizer_destroy;

  /// Add a packet to the current repacketizer state.
  /// This packet must match the configuration of any packets already submitted
  /// for repacketization since the last call to opus_repacketizer_init().
  /// This means that it must have the same coding mode, audio bandwidth, frame
  /// size, and channel count.
  /// This can be checked in advance by examining the top 6 bits of the first
  /// byte of the packet, and ensuring they match the top 6 bits of the first
  /// byte of any previously submitted packet.
  /// The total duration of audio in the repacketizer state also must not exceed
  /// 120 ms, the maximum duration of a single packet, after adding this packet.
  /// *
  /// The contents of the current repacketizer state can be extracted into new
  /// packets using opus_repacketizer_out() or opus_repacketizer_out_range().
  /// *
  /// In order to add a packet with a different configuration or to add more
  /// audio beyond 120 ms, you must clear the repacketizer state by calling
  /// opus_repacketizer_init().
  /// If a packet is too large to add to the current repacketizer state, no part
  /// of it is added, even if it contains multiple frames, some of which might
  /// fit.
  /// If you wish to be able to add parts of such packets, you should first use
  /// another repacketizer to split the packet into pieces and add them
  /// individually.
  /// @see opus_repacketizer_out_range
  /// @see opus_repacketizer_out
  /// @see opus_repacketizer_init
  /// @param rp <tt>OpusRepacketizer*</tt>: The repacketizer state to which to
  /// add the packet.
  /// @param[in] data <tt>const unsigned char*</tt>: The packet data.
  /// The application must ensure
  /// this pointer remains valid
  /// until the next call to
  /// opus_repacketizer_init() or
  /// opus_repacketizer_destroy().
  /// @param len <tt>opus_int32</tt>: The number of bytes in the packet data.
  /// @returns An error code indicating whether or not the operation succeeded.
  /// @retval #OPUS_OK The packet's contents have been added to the repacketizer
  /// state.
  /// @retval #OPUS_INVALID_PACKET The packet did not have a valid TOC sequence,
  /// the packet's TOC sequence was not compatible
  /// with previously submitted packets (because
  /// the coding mode, audio bandwidth, frame size,
  /// or channel count did not match), or adding
  /// this packet would increase the total amount of
  /// audio stored in the repacketizer state to more
  /// than 120 ms.
  int opus_repacketizer_cat(
    ffi.Pointer<OpusRepacketizer> rp,
    ffi.Pointer<ffi.Uint8> data,
    int len,
  ) {
    return _opus_repacketizer_cat(rp, data, len);
  }

  final _opus_repacketizer_cat_Dart _opus_repacketizer_cat;

  /// Construct a new packet from data previously submitted to the repacketizer
  /// state via opus_repacketizer_cat().
  /// @param rp <tt>OpusRepacketizer*</tt>: The repacketizer state from which to
  /// construct the new packet.
  /// @param begin <tt>int</tt>: The index of the first frame in the current
  /// repacketizer state to include in the output.
  /// @param end <tt>int</tt>: One past the index of the last frame in the
  /// current repacketizer state to include in the
  /// output.
  /// @param[out] data <tt>const unsigned char*</tt>: The buffer in which to
  /// store the output packet.
  /// @param maxlen <tt>opus_int32</tt>: The maximum number of bytes to store in
  /// the output buffer. In order to guarantee
  /// success, this should be at least
  /// <code>1276</code> for a single frame,
  /// or for multiple frames,
  /// <code>1277*(end-begin)</code>.
  /// However, <code>1*(end-begin)</code> plus
  /// the size of all packet data submitted to
  /// the repacketizer since the last call to
  /// opus_repacketizer_init() or
  /// opus_repacketizer_create() is also
  /// sufficient, and possibly much smaller.
  /// @returns The total size of the output packet on success, or an error code
  /// on failure.
  /// @retval #OPUS_BAD_ARG <code>[begin,end)</code> was an invalid range of
  /// frames (begin < 0, begin >= end, or end >
  /// opus_repacketizer_get_nb_frames()).
  /// @retval #OPUS_BUFFER_TOO_SMALL a maxlen was insufficient to contain the
  /// complete output packet.
  int opus_repacketizer_out_range(
    ffi.Pointer<OpusRepacketizer> rp,
    int begin,
    int end,
    ffi.Pointer<ffi.Uint8> data,
    int maxlen,
  ) {
    return _opus_repacketizer_out_range(rp, begin, end, data, maxlen);
  }

  final _opus_repacketizer_out_range_Dart _opus_repacketizer_out_range;

  /// Return the total number of frames contained in packet data submitted to
  /// the repacketizer state so far via opus_repacketizer_cat() since the last
  /// call to opus_repacketizer_init() or opus_repacketizer_create().
  /// This defines the valid range of packets that can be extracted with
  /// opus_repacketizer_out_range() or opus_repacketizer_out().
  /// @param rp <tt>OpusRepacketizer*</tt>: The repacketizer state containing the
  /// frames.
  /// @returns The total number of frames contained in the packet data submitted
  /// to the repacketizer state.
  int opus_repacketizer_get_nb_frames(
    ffi.Pointer<OpusRepacketizer> rp,
  ) {
    return _opus_repacketizer_get_nb_frames(rp);
  }

  final _opus_repacketizer_get_nb_frames_Dart _opus_repacketizer_get_nb_frames;

  /// Construct a new packet from data previously submitted to the repacketizer
  /// state via opus_repacketizer_cat().
  /// This is a convenience routine that returns all the data submitted so far
  /// in a single packet.
  /// It is equivalent to calling
  /// @code
  /// opus_repacketizer_out_range(rp, 0, opus_repacketizer_get_nb_frames(rp),
  /// data, maxlen)
  /// @endcode
  /// @param rp <tt>OpusRepacketizer*</tt>: The repacketizer state from which to
  /// construct the new packet.
  /// @param[out] data <tt>const unsigned char*</tt>: The buffer in which to
  /// store the output packet.
  /// @param maxlen <tt>opus_int32</tt>: The maximum number of bytes to store in
  /// the output buffer. In order to guarantee
  /// success, this should be at least
  /// <code>1277*opus_repacketizer_get_nb_frames(rp)</code>.
  /// However,
  /// <code>1*opus_repacketizer_get_nb_frames(rp)</code>
  /// plus the size of all packet data
  /// submitted to the repacketizer since the
  /// last call to opus_repacketizer_init() or
  /// opus_repacketizer_create() is also
  /// sufficient, and possibly much smaller.
  /// @returns The total size of the output packet on success, or an error code
  /// on failure.
  /// @retval #OPUS_BUFFER_TOO_SMALL a maxlen was insufficient to contain the
  /// complete output packet.
  int opus_repacketizer_out(
    ffi.Pointer<OpusRepacketizer> rp,
    ffi.Pointer<ffi.Uint8> data,
    int maxlen,
  ) {
    return _opus_repacketizer_out(rp, data, maxlen);
  }

  final _opus_repacketizer_out_Dart _opus_repacketizer_out;

  /// Pads a given Opus packet to a larger size (possibly changing the TOC sequence).
  /// @param[in,out] data <tt>const unsigned char*</tt>: The buffer containing the
  /// packet to pad.
  /// @param len <tt>opus_int32</tt>: The size of the packet.
  /// This must be at least 1.
  /// @param new_len <tt>opus_int32</tt>: The desired size of the packet after padding.
  /// This must be at least as large as len.
  /// @returns an error code
  /// @retval #OPUS_OK a on success.
  /// @retval #OPUS_BAD_ARG a len was less than 1 or new_len was less than len.
  /// @retval #OPUS_INVALID_PACKET a data did not contain a valid Opus packet.
  int opus_packet_pad(
    ffi.Pointer<ffi.Uint8> data,
    int len,
    int new_len,
  ) {
    return _opus_packet_pad(data, len, new_len);
  }

  final _opus_packet_pad_Dart _opus_packet_pad;

  /// Remove all padding from a given Opus packet and rewrite the TOC sequence to
  /// minimize space usage.
  /// @param[in,out] data <tt>const unsigned char*</tt>: The buffer containing the
  /// packet to strip.
  /// @param len <tt>opus_int32</tt>: The size of the packet.
  /// This must be at least 1.
  /// @returns The new size of the output packet on success, or an error code
  /// on failure.
  /// @retval #OPUS_BAD_ARG a len was less than 1.
  /// @retval #OPUS_INVALID_PACKET a data did not contain a valid Opus packet.
  int opus_packet_unpad(
    ffi.Pointer<ffi.Uint8> data,
    int len,
  ) {
    return _opus_packet_unpad(data, len);
  }

  final _opus_packet_unpad_Dart _opus_packet_unpad;

  /// Pads a given Opus multi-stream packet to a larger size (possibly changing the TOC sequence).
  /// @param[in,out] data <tt>const unsigned char*</tt>: The buffer containing the
  /// packet to pad.
  /// @param len <tt>opus_int32</tt>: The size of the packet.
  /// This must be at least 1.
  /// @param new_len <tt>opus_int32</tt>: The desired size of the packet after padding.
  /// This must be at least 1.
  /// @param nb_streams <tt>opus_int32</tt>: The number of streams (not channels) in the packet.
  /// This must be at least as large as len.
  /// @returns an error code
  /// @retval #OPUS_OK a on success.
  /// @retval #OPUS_BAD_ARG a len was less than 1.
  /// @retval #OPUS_INVALID_PACKET a data did not contain a valid Opus packet.
  int opus_multistream_packet_pad(
    ffi.Pointer<ffi.Uint8> data,
    int len,
    int new_len,
    int nb_streams,
  ) {
    return _opus_multistream_packet_pad(data, len, new_len, nb_streams);
  }

  final _opus_multistream_packet_pad_Dart _opus_multistream_packet_pad;

  /// Remove all padding from a given Opus multi-stream packet and rewrite the TOC sequence to
  /// minimize space usage.
  /// @param[in,out] data <tt>const unsigned char*</tt>: The buffer containing the
  /// packet to strip.
  /// @param len <tt>opus_int32</tt>: The size of the packet.
  /// This must be at least 1.
  /// @param nb_streams <tt>opus_int32</tt>: The number of streams (not channels) in the packet.
  /// This must be at least 1.
  /// @returns The new size of the output packet on success, or an error code
  /// on failure.
  /// @retval #OPUS_BAD_ARG a len was less than 1 or new_len was less than len.
  /// @retval #OPUS_INVALID_PACKET a data did not contain a valid Opus packet.
  int opus_multistream_packet_unpad(
    ffi.Pointer<ffi.Uint8> data,
    int len,
    int nb_streams,
  ) {
    return _opus_multistream_packet_unpad(data, len, nb_streams);
  }

  final _opus_multistream_packet_unpad_Dart _opus_multistream_packet_unpad;
}
