/// Contains methods defined contansts from opus_defines.h

library opus_defines;

// These are the actual Encoder CTL ID numbers.
// They should not be used directly by applications.
// In general, SETs should be even and GETs should be odd.
const int OPUS_SET_APPLICATION_REQUEST = 4000;
const int OPUS_GET_APPLICATION_REQUEST = 4001;
const int OPUS_SET_BITRATE_REQUEST = 4002;
const int OPUS_GET_BITRATE_REQUEST = 4003;
const int OPUS_SET_MAX_BANDWIDTH_REQUEST = 4004;
const int OPUS_GET_MAX_BANDWIDTH_REQUEST = 4005;
const int OPUS_SET_VBR_REQUEST = 4006;
const int OPUS_GET_VBR_REQUEST = 4007;
const int OPUS_SET_BANDWIDTH_REQUEST = 4008;
const int OPUS_GET_BANDWIDTH_REQUEST = 4009;
const int OPUS_SET_COMPLEXITY_REQUEST = 4010;
const int OPUS_GET_COMPLEXITY_REQUEST = 4011;
const int OPUS_SET_INBAND_FEC_REQUEST = 4012;
const int OPUS_GET_INBAND_FEC_REQUEST = 4013;
const int OPUS_SET_PACKET_LOSS_PERC_REQUEST = 4014;
const int OPUS_GET_PACKET_LOSS_PERC_REQUEST = 4015;
const int OPUS_SET_DTX_REQUEST = 4016;
const int OPUS_GET_DTX_REQUEST = 4017;
const int OPUS_SET_VBR_CONSTRAINT_REQUEST = 4020;
const int OPUS_GET_VBR_CONSTRAINT_REQUEST = 4021;
const int OPUS_SET_FORCE_CHANNELS_REQUEST = 4022;
const int OPUS_GET_FORCE_CHANNELS_REQUEST = 4023;
const int OPUS_SET_SIGNAL_REQUEST = 4024;
const int OPUS_GET_SIGNAL_REQUEST = 4025;
const int OPUS_GET_LOOKAHEAD_REQUEST = 4027;
// const int OPUS_RESET_STATE = 4028
const int OPUS_GET_SAMPLE_RATE_REQUEST = 4029;
const int OPUS_GET_FINAL_RANGE_REQUEST = 4031;
const int OPUS_GET_PITCH_REQUEST = 4033;
const int OPUS_SET_GAIN_REQUEST = 4034;
const int OPUS_GET_GAIN_REQUEST = 4045; // Should have been 4035
const int OPUS_SET_LSB_DEPTH_REQUEST = 4036;
const int OPUS_GET_LSB_DEPTH_REQUEST = 4037;
const int OPUS_GET_LAST_PACKET_DURATION_REQUEST = 4039;
const int OPUS_SET_EXPERT_FRAME_DURATION_REQUEST = 4040;
const int OPUS_GET_EXPERT_FRAME_DURATION_REQUEST = 4041;
const int OPUS_SET_PREDICTION_DISABLED_REQUEST = 4042;
const int OPUS_GET_PREDICTION_DISABLED_REQUEST = 4043;
// Don't use 4045, it's already taken by OPUS_GET_GAIN_REQUEST
const int OPUS_SET_PHASE_INVERSION_DISABLED_REQUEST = 4046;
const int OPUS_GET_PHASE_INVERSION_DISABLED_REQUEST = 4047;
const int OPUS_GET_IN_DTX_REQUEST = 4049;

// Opus error codes
/// No error
const int OPUS_OK = 0;

/// One or more invalid/out of range arguments
const int OPUS_BAD_ARG = -1;

/// Not enough bytes allocated in the buffer
const int OPUS_BUFFER_TOO_SMALL = -2;

/// An internal error was detected
const int OPUS_INTERNAL_ERROR = -3;

/// The compressed data passed is corrupted
const int OPUS_INVALID_PACKET = -4;

/// Invalid/unsupported request number
const int OPUS_UNIMPLEMENTED = -5;

/// An encoder or decoder structure is invalid or already freed
const int OPUS_INVALID_STATE = -6;

/// Memory allocation has failed
const int OPUS_ALLOC_FAIL = -7;

// Values for the various encoder CTLs
/// Auto/default setting
const int OPUS_AUTO = -1000;

/// Maximum bitrate
const int OPUS_BITRATE_MAX = -1;

/// Best for most VoIP/videoconference applications where listening quality and intelligibility matter most
const int OPUS_APPLICATION_VOIP = 2048;

/// Best for broadcast/high-fidelity application where the decoded audio should be as close as possible to the input
const int OPUS_APPLICATION_AUDIO = 2049;

/// Only use when lowest-achievable latency is what matters most. Voice-optimized modes cannot be used.
const int OPUS_APPLICATION_RESTRICTED_LOWDELAY = 2051;

/// Signal being encoded is voice
const int OPUS_SIGNAL_VOICE = 3001;

/// Signal being encoded is music
const int OPUS_SIGNAL_MUSIC = 3002;

/// 4 kHz bandpass
const int OPUS_BANDWIDTH_NARROWBAND = 1101;

/// 6 kHz bandpass
const int OPUS_BANDWIDTH_MEDIUMBAND = 1102;

/// 8 kHz bandpass
const int OPUS_BANDWIDTH_WIDEBAND = 1103;

/// 12 kHz bandpass
const int OPUS_BANDWIDTH_SUPERWIDEBAND = 1104;

/// 20 kHz bandpass
const int OPUS_BANDWIDTH_FULLBAND = 1105;

/// Select frame size from the argument (default)
const int OPUS_FRAMESIZE_ARG = 5000;

///Use 2.5 ms frames
const int OPUS_FRAMESIZE_2_5_MS = 5001;

/// Use 5 ms frames
const int OPUS_FRAMESIZE_5_MS = 5002;

/// Use 10 ms frames
const int OPUS_FRAMESIZE_10_MS = 5003;

/// Use 20 ms frames
const int OPUS_FRAMESIZE_20_MS = 5004;

/// Use 40 ms frames
const int OPUS_FRAMESIZE_40_MS = 5005;

/// Use 60 ms frames
const int OPUS_FRAMESIZE_60_MS = 5006;

/// Use 80 ms frames
const int OPUS_FRAMESIZE_80_MS = 5007;

/// Use 100 ms frames
const int OPUS_FRAMESIZE_100_MS = 5008;

/// Use 120 ms frames
const int OPUS_FRAMESIZE_120_MS = 5009;
