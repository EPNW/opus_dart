/// Contains methods and structs from the opus_decoder group of opus.h.
/// SHOULD be imported as opus_decoder and MUST be initalized using its [init] function.
///
/// AUTOMATICALLY GENERATED FILE. DO NOT MODIFY.

library opus_decoder;

import 'dart:ffi' as ffi;

/// Dynamic library
ffi.DynamicLibrary _opus_decoder;

/// Initialises the generated code using `library`. This must be the first call to this file.
void init(ffi.DynamicLibrary library) {
  _opus_decoder = library;
}

/// Opus decoder state.
/// This contains the complete state of an Opus decoder.
/// It is position independent and can be freely copied.
/// @see opus_decoder_create,opus_decoder_init
class OpusDecoder extends ffi.Opaque {}

/// Gets the size of an <code>OpusDecoder</code> structure.
/// @param [in] channels <tt>int</tt>: Number of channels.
///                                    This must be 1 or 2.
/// @returns The size in bytes.
int opus_decoder_get_size(
  int channels,
) {
  return _opus_decoder_get_size(channels);
}

final _opus_decoder_get_size_Dart _opus_decoder_get_size = _opus_decoder
    .lookupFunction<_opus_decoder_get_size_C, _opus_decoder_get_size_Dart>(
  'opus_decoder_get_size',
);
typedef _opus_decoder_get_size_C = ffi.Int32 Function(
  ffi.Int32 channels,
);
typedef _opus_decoder_get_size_Dart = int Function(
  int channels,
);

/// Allocates and initializes a decoder state.
/// @param [in] Fs <tt>opus_int32</tt>: Sample rate to decode at (Hz).
///                                     This must be one of 8000, 12000, 16000,
///                                     24000, or 48000.
/// @param [in] channels <tt>int</tt>: Number of channels (1 or 2) to decode
/// @param [out] error <tt>int*</tt>: #OPUS_OK Success or @ref opus_errorcodes
///
/// Internally Opus stores data at 48000 Hz, so that should be the default
/// value for Fs. However, the decoder can efficiently decode to buffers
/// at 8, 12, 16, and 24 kHz so if for some reason the caller cannot use
/// data at the full sample rate, or knows the compressed data doesn't
/// use the full frequency range, it can request decoding at a reduced
/// rate. Likewise, the decoder is capable of filling in either mono or
/// interleaved stereo pcm buffers, at the caller's request.
ffi.Pointer<OpusDecoder> opus_decoder_create(
  int Fs,
  int channels,
  ffi.Pointer<ffi.Int32> error,
) {
  return _opus_decoder_create(Fs, channels, error);
}

final _opus_decoder_create_Dart _opus_decoder_create = _opus_decoder
    .lookupFunction<_opus_decoder_create_C, _opus_decoder_create_Dart>(
  'opus_decoder_create',
);
typedef _opus_decoder_create_C = ffi.Pointer<OpusDecoder> Function(
  ffi.Int32 Fs,
  ffi.Int32 channels,
  ffi.Pointer<ffi.Int32> error,
);
typedef _opus_decoder_create_Dart = ffi.Pointer<OpusDecoder> Function(
  int Fs,
  int channels,
  ffi.Pointer<ffi.Int32> error,
);

/// Initializes a previously allocated decoder state.
/// The state must be at least the size returned by opus_decoder_get_size().
/// This is intended for applications which use their own allocator instead of malloc. @see opus_decoder_create,opus_decoder_get_size
/// To reset a previously initialized state, use the #OPUS_RESET_STATE CTL.
/// @param [in] st <tt>OpusDecoder*</tt>: Decoder state.
/// @param [in] Fs <tt>opus_int32</tt>: Sampling rate to decode to (Hz).
///                                     This must be one of 8000, 12000, 16000,
///                                     24000, or 48000.
/// @param [in] channels <tt>int</tt>: Number of channels (1 or 2) to decode
/// @retval #OPUS_OK Success or @ref opus_errorcodes
int opus_decoder_init(
  ffi.Pointer<OpusDecoder> st,
  int Fs,
  int channels,
) {
  return _opus_decoder_init(st, Fs, channels);
}

final _opus_decoder_init_Dart _opus_decoder_init =
    _opus_decoder.lookupFunction<_opus_decoder_init_C, _opus_decoder_init_Dart>(
  'opus_decoder_init',
);
typedef _opus_decoder_init_C = ffi.Int32 Function(
  ffi.Pointer<OpusDecoder> st,
  ffi.Int32 Fs,
  ffi.Int32 channels,
);
typedef _opus_decoder_init_Dart = int Function(
  ffi.Pointer<OpusDecoder> st,
  int Fs,
  int channels,
);

/// Decode an Opus packet.
/// @param [in] st <tt>OpusDecoder*</tt>: Decoder state
/// @param [in] data <tt>char*</tt>: Input payload. Use a NULL pointer to indicate packet loss
/// @param [in] len <tt>opus_int32</tt>: Number of bytes in payload*
/// @param [out] pcm <tt>opus_int16*</tt>: Output signal (interleaved if 2 channels). length
///  is frame_size*channels*sizeof(opus_int16)
/// @param [in] frame_size Number of samples per channel of available space in a pcm.
///  If this is less than the maximum packet duration (120ms; 5760 for 48kHz), this function will
///  not be capable of decoding some packets. In the case of PLC (data==NULL) or FEC (decode_fec=1),
///  then frame_size needs to be exactly the duration of audio that is missing, otherwise the
///  decoder will not be in the optimal state to decode the next incoming packet. For the PLC and
///  FEC cases, frame_size <b>must</b> be a multiple of 2.5 ms.
/// @param [in] decode_fec <tt>int</tt>: Flag (0 or 1) to request that any in-band forward error correction data be
///  decoded. If no such data is available, the frame is decoded as if it were lost.
/// @returns Number of decoded samples or @ref opus_errorcodes
int opus_decode(
  ffi.Pointer<OpusDecoder> st,
  ffi.Pointer<ffi.Uint8> data,
  int len,
  ffi.Pointer<ffi.Int16> pcm,
  int frame_size,
  int decode_fec,
) {
  return _opus_decode(st, data, len, pcm, frame_size, decode_fec);
}

final _opus_decode_Dart _opus_decode =
    _opus_decoder.lookupFunction<_opus_decode_C, _opus_decode_Dart>(
  'opus_decode',
);
typedef _opus_decode_C = ffi.Int32 Function(
  ffi.Pointer<OpusDecoder> st,
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 len,
  ffi.Pointer<ffi.Int16> pcm,
  ffi.Int32 frame_size,
  ffi.Int32 decode_fec,
);
typedef _opus_decode_Dart = int Function(
  ffi.Pointer<OpusDecoder> st,
  ffi.Pointer<ffi.Uint8> data,
  int len,
  ffi.Pointer<ffi.Int16> pcm,
  int frame_size,
  int decode_fec,
);

/// Decode an Opus packet with floating point output.
/// @param [in] st <tt>OpusDecoder*</tt>: Decoder state
/// @param [in] data <tt>char*</tt>: Input payload. Use a NULL pointer to indicate packet loss
/// @param [in] len <tt>opus_int32</tt>: Number of bytes in payload
/// @param [out] pcm <tt>float*</tt>: Output signal (interleaved if 2 channels). length
///  is frame_size*channels*sizeof(float)
/// @param [in] frame_size Number of samples per channel of available space in a pcm.
///  If this is less than the maximum packet duration (120ms; 5760 for 48kHz), this function will
///  not be capable of decoding some packets. In the case of PLC (data==NULL) or FEC (decode_fec=1),
///  then frame_size needs to be exactly the duration of audio that is missing, otherwise the
///  decoder will not be in the optimal state to decode the next incoming packet. For the PLC and
///  FEC cases, frame_size <b>must</b> be a multiple of 2.5 ms.
/// @param [in] decode_fec <tt>int</tt>: Flag (0 or 1) to request that any in-band forward error correction data be
///  decoded. If no such data is available the frame is decoded as if it were lost.
/// @returns Number of decoded samples or @ref opus_errorcodes
int opus_decode_float(
  ffi.Pointer<OpusDecoder> st,
  ffi.Pointer<ffi.Uint8> data,
  int len,
  ffi.Pointer<ffi.Float> pcm,
  int frame_size,
  int decode_fec,
) {
  return _opus_decode_float(st, data, len, pcm, frame_size, decode_fec);
}

final _opus_decode_float_Dart _opus_decode_float =
    _opus_decoder.lookupFunction<_opus_decode_float_C, _opus_decode_float_Dart>(
  'opus_decode_float',
);
typedef _opus_decode_float_C = ffi.Int32 Function(
  ffi.Pointer<OpusDecoder> st,
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 len,
  ffi.Pointer<ffi.Float> pcm,
  ffi.Int32 frame_size,
  ffi.Int32 decode_fec,
);
typedef _opus_decode_float_Dart = int Function(
  ffi.Pointer<OpusDecoder> st,
  ffi.Pointer<ffi.Uint8> data,
  int len,
  ffi.Pointer<ffi.Float> pcm,
  int frame_size,
  int decode_fec,
);

/// Frees an <code>OpusDecoder</code> allocated by opus_decoder_create().
/// @param [in] st <tt>OpusDecoder*</tt>: State to be freed.
void opus_decoder_destroy(
  ffi.Pointer<OpusDecoder> st,
) {
  _opus_decoder_destroy(st);
}

final _opus_decoder_destroy_Dart _opus_decoder_destroy = _opus_decoder
    .lookupFunction<_opus_decoder_destroy_C, _opus_decoder_destroy_Dart>(
  'opus_decoder_destroy',
);
typedef _opus_decoder_destroy_C = ffi.Void Function(
  ffi.Pointer<OpusDecoder> st,
);
typedef _opus_decoder_destroy_Dart = void Function(
  ffi.Pointer<OpusDecoder> st,
);

/// Parse an opus packet into one or more frames.
/// Opus_decode will perform this operation internally so most applications do
/// not need to use this function.
/// This function does not copy the frames, the returned pointers are pointers into
/// the input packet.
/// @param [in] data <tt>char*</tt>: Opus packet to be parsed
/// @param [in] len <tt>opus_int32</tt>: size of data
/// @param [out] out_toc <tt>char*</tt>: TOC pointer
/// @param [out] frames <tt>char*[48]</tt> encapsulated frames
/// @param [out] size <tt>opus_int16[48]</tt> sizes of the encapsulated frames
/// @param [out] payload_offset <tt>int*</tt>: returns the position of the payload within the packet (in bytes)
/// @returns number of frames
int opus_packet_parse(
  ffi.Pointer<ffi.Uint8> data,
  int len,
  ffi.Pointer<ffi.Uint8> out_toc,
  ffi.Pointer<ffi.Uint8> frames,
  int size,
  ffi.Pointer<ffi.Int32> payload_offset,
) {
  return _opus_packet_parse(data, len, out_toc, frames, size, payload_offset);
}

final _opus_packet_parse_Dart _opus_packet_parse =
    _opus_decoder.lookupFunction<_opus_packet_parse_C, _opus_packet_parse_Dart>(
  'opus_packet_parse',
);
typedef _opus_packet_parse_C = ffi.Int32 Function(
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 len,
  ffi.Pointer<ffi.Uint8> out_toc,
  ffi.Pointer<ffi.Uint8> frames,
  ffi.Int16 size,
  ffi.Pointer<ffi.Int32> payload_offset,
);
typedef _opus_packet_parse_Dart = int Function(
  ffi.Pointer<ffi.Uint8> data,
  int len,
  ffi.Pointer<ffi.Uint8> out_toc,
  ffi.Pointer<ffi.Uint8> frames,
  int size,
  ffi.Pointer<ffi.Int32> payload_offset,
);

/// Gets the bandwidth of an Opus packet.
/// @param [in] data <tt>char*</tt>: Opus packet
/// @retval OPUS_BANDWIDTH_NARROWBAND Narrowband (4kHz bandpass)
/// @retval OPUS_BANDWIDTH_MEDIUMBAND Mediumband (6kHz bandpass)
/// @retval OPUS_BANDWIDTH_WIDEBAND Wideband (8kHz bandpass)
/// @retval OPUS_BANDWIDTH_SUPERWIDEBAND Superwideband (12kHz bandpass)
/// @retval OPUS_BANDWIDTH_FULLBAND Fullband (20kHz bandpass)
/// @retval OPUS_INVALID_PACKET The compressed data passed is corrupted or of an unsupported type
int opus_packet_get_bandwidth(
  ffi.Pointer<ffi.Uint8> data,
) {
  return _opus_packet_get_bandwidth(data);
}

final _opus_packet_get_bandwidth_Dart _opus_packet_get_bandwidth =
    _opus_decoder.lookupFunction<_opus_packet_get_bandwidth_C,
        _opus_packet_get_bandwidth_Dart>(
  'opus_packet_get_bandwidth',
);
typedef _opus_packet_get_bandwidth_C = ffi.Int32 Function(
  ffi.Pointer<ffi.Uint8> data,
);
typedef _opus_packet_get_bandwidth_Dart = int Function(
  ffi.Pointer<ffi.Uint8> data,
);

/// Gets the number of samples per frame from an Opus packet.
/// @param [in] data <tt>char*</tt>: Opus packet.
///                                  This must contain at least one byte of
///                                  data.
/// @param [in] Fs <tt>opus_int32</tt>: Sampling rate in Hz.
///                                     This must be a multiple of 400, or
///                                     inaccurate results will be returned.
/// @returns Number of samples per frame.
int opus_packet_get_samples_per_frame(
  ffi.Pointer<ffi.Uint8> data,
  int Fs,
) {
  return _opus_packet_get_samples_per_frame(data, Fs);
}

final _opus_packet_get_samples_per_frame_Dart
    _opus_packet_get_samples_per_frame = _opus_decoder.lookupFunction<
        _opus_packet_get_samples_per_frame_C,
        _opus_packet_get_samples_per_frame_Dart>(
  'opus_packet_get_samples_per_frame',
);
typedef _opus_packet_get_samples_per_frame_C = ffi.Int32 Function(
  ffi.Pointer<ffi.Uint8> data,
  ffi.Int32 Fs,
);
typedef _opus_packet_get_samples_per_frame_Dart = int Function(
  ffi.Pointer<ffi.Uint8> data,
  int Fs,
);

/// Gets the number of channels from an Opus packet.
/// @param [in] data <tt>char*</tt>: Opus packet
/// @returns Number of channels
/// @retval OPUS_INVALID_PACKET The compressed data passed is corrupted or of an unsupported type
int opus_packet_get_nb_channels(
  ffi.Pointer<ffi.Uint8> data,
) {
  return _opus_packet_get_nb_channels(data);
}

final _opus_packet_get_nb_channels_Dart _opus_packet_get_nb_channels =
    _opus_decoder.lookupFunction<_opus_packet_get_nb_channels_C,
        _opus_packet_get_nb_channels_Dart>(
  'opus_packet_get_nb_channels',
);
typedef _opus_packet_get_nb_channels_C = ffi.Int32 Function(
  ffi.Pointer<ffi.Uint8> data,
);
typedef _opus_packet_get_nb_channels_Dart = int Function(
  ffi.Pointer<ffi.Uint8> data,
);

/// Gets the number of frames in an Opus packet.
/// @param [in] packet <tt>char*</tt>: Opus packet
/// @param [in] len <tt>opus_int32</tt>: Length of packet
/// @returns Number of frames
/// @retval OPUS_BAD_ARG Insufficient data was passed to the function
/// @retval OPUS_INVALID_PACKET The compressed data passed is corrupted or of an unsupported type
int opus_packet_get_nb_frames(
  ffi.Pointer<ffi.Uint8> packet,
  int len,
) {
  return _opus_packet_get_nb_frames(packet, len);
}

final _opus_packet_get_nb_frames_Dart _opus_packet_get_nb_frames =
    _opus_decoder.lookupFunction<_opus_packet_get_nb_frames_C,
        _opus_packet_get_nb_frames_Dart>(
  'opus_packet_get_nb_frames',
);
typedef _opus_packet_get_nb_frames_C = ffi.Int32 Function(
  ffi.Pointer<ffi.Uint8> packet,
  ffi.Int32 len,
);
typedef _opus_packet_get_nb_frames_Dart = int Function(
  ffi.Pointer<ffi.Uint8> packet,
  int len,
);

/// Gets the number of samples of an Opus packet.
/// @param [in] packet <tt>char*</tt>: Opus packet
/// @param [in] len <tt>opus_int32</tt>: Length of packet
/// @param [in] Fs <tt>opus_int32</tt>: Sampling rate in Hz.
///                                     This must be a multiple of 400, or
///                                     inaccurate results will be returned.
/// @returns Number of samples
/// @retval OPUS_BAD_ARG Insufficient data was passed to the function
/// @retval OPUS_INVALID_PACKET The compressed data passed is corrupted or of an unsupported type
int opus_packet_get_nb_samples(
  ffi.Pointer<ffi.Uint8> packet,
  int len,
  int Fs,
) {
  return _opus_packet_get_nb_samples(packet, len, Fs);
}

final _opus_packet_get_nb_samples_Dart _opus_packet_get_nb_samples =
    _opus_decoder.lookupFunction<_opus_packet_get_nb_samples_C,
        _opus_packet_get_nb_samples_Dart>(
  'opus_packet_get_nb_samples',
);
typedef _opus_packet_get_nb_samples_C = ffi.Int32 Function(
  ffi.Pointer<ffi.Uint8> packet,
  ffi.Int32 len,
  ffi.Int32 Fs,
);
typedef _opus_packet_get_nb_samples_Dart = int Function(
  ffi.Pointer<ffi.Uint8> packet,
  int len,
  int Fs,
);

/// Gets the number of samples of an Opus packet.
/// @param [in] dec <tt>OpusDecoder*</tt>: Decoder state
/// @param [in] packet <tt>char*</tt>: Opus packet
/// @param [in] len <tt>opus_int32</tt>: Length of packet
/// @returns Number of samples
/// @retval OPUS_BAD_ARG Insufficient data was passed to the function
/// @retval OPUS_INVALID_PACKET The compressed data passed is corrupted or of an unsupported type
int opus_decoder_get_nb_samples(
  ffi.Pointer<OpusDecoder> dec,
  ffi.Pointer<ffi.Uint8> packet,
  int len,
) {
  return _opus_decoder_get_nb_samples(dec, packet, len);
}

final _opus_decoder_get_nb_samples_Dart _opus_decoder_get_nb_samples =
    _opus_decoder.lookupFunction<_opus_decoder_get_nb_samples_C,
        _opus_decoder_get_nb_samples_Dart>(
  'opus_decoder_get_nb_samples',
);
typedef _opus_decoder_get_nb_samples_C = ffi.Int32 Function(
  ffi.Pointer<OpusDecoder> dec,
  ffi.Pointer<ffi.Uint8> packet,
  ffi.Int32 len,
);
typedef _opus_decoder_get_nb_samples_Dart = int Function(
  ffi.Pointer<OpusDecoder> dec,
  ffi.Pointer<ffi.Uint8> packet,
  int len,
);

/// Applies soft-clipping to bring a float signal within the [-1,1] range. If
/// the signal is already in that range, nothing is done. If there are values
/// outside of [-1,1], then the signal is clipped as smoothly as possible to
/// both fit in the range and avoid creating excessive distortion in the
/// process.
/// @param [in,out] pcm <tt>float*</tt>: Input PCM and modified PCM
/// @param [in] frame_size <tt>int</tt> Number of samples per channel to process
/// @param [in] channels <tt>int</tt>: Number of channels
/// @param [in,out] softclip_mem <tt>float*</tt>: State memory for the soft clipping process (one float per channel, initialized to zero)
void opus_pcm_soft_clip(
  ffi.Pointer<ffi.Float> pcm,
  int frame_size,
  int channels,
  ffi.Pointer<ffi.Float> softclip_mem,
) {
  _opus_pcm_soft_clip(pcm, frame_size, channels, softclip_mem);
}

final _opus_pcm_soft_clip_Dart _opus_pcm_soft_clip = _opus_decoder
    .lookupFunction<_opus_pcm_soft_clip_C, _opus_pcm_soft_clip_Dart>(
  'opus_pcm_soft_clip',
);
typedef _opus_pcm_soft_clip_C = ffi.Void Function(
  ffi.Pointer<ffi.Float> pcm,
  ffi.Int32 frame_size,
  ffi.Int32 channels,
  ffi.Pointer<ffi.Float> softclip_mem,
);
typedef _opus_pcm_soft_clip_Dart = void Function(
  ffi.Pointer<ffi.Float> pcm,
  int frame_size,
  int channels,
  ffi.Pointer<ffi.Float> softclip_mem,
);
