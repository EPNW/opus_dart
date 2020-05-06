///Types, t for types, tp for type pointers
const String t_int = 'int32';
const String tp_int = '*$t_int';
const String t_opus_int32 = 'int32';
const String t_opus_int16 = 'int16';
const String tp_opus_int16 = '*$t_opus_int16';
const String t_float = 'float';
const String tp_float = '*$t_float';
const String t_unsigned_char = 'char';
const String tp_unsigned_char = '*$t_unsigned_char';
const String t_OpusEncoder = 'OpusEncoder';
const String tp_OpusEncoder = '*$t_OpusEncoder';
const String t_OpusDecoder = 'OpusDecoder';
const String tp_OpusDecoder = '*$t_OpusDecoder';
const String t_void = 'void';
const String t_utf8 = 'utf8';
const String tp_utf8 = '*$t_utf8';
const String t_OpusCustomMode = 'OpusCustomMode';
const String tp_OpusCustomMode = '*$t_OpusCustomMode';
const String t_OpusCustomEncoder = 'OpusCustomEncoder';
const String tp_OpusCustomEncoder = '*$t_OpusCustomEncoder';
const String t_OpusCustomDecoder = 'OpusCustomDecoder';
const String tp_OpusCustomDecoder = '*$t_OpusCustomDecoder';
const String t_OpusProjectionEncoder = 'OpusProjectionEncoder';
const String tp_OpusProjectionEncoder = '*$t_OpusProjectionEncoder';
const String t_OpusProjectionDecoder = 'OpusProjectionDecoder';
const String tp_OpusProjectionDecoder = '*$t_OpusProjectionDecoder';
const String t_OpusRepacketizer = 'OpusRepacketizer';
const String tp_OpusRepacketizer = '*$t_OpusRepacketizer';
const String t_OpusMSEncoder = 'OpusMSEncoder';
const String tp_OpusMSEncoder = '*$t_OpusMSEncoder';
const String t_OpusMSDecoder = 'OpusMSDecoder';
const String tp_OpusMSDecoder = '*$t_OpusMSDecoder';

const Map<String, String> reverseTypeMap = <String, String>{
  'int': 't_int',
  '*int': 'tp_int',
  'opus_int32': 't_opus_int32',
  'opus_int16': 't_opus_int16',
  '*opus_int16': 'tp_opus_int16',
  'float': 't_float',
  '*float': 'tp_float',
  'unsigned char': 't_unsigned_char',
  '*unsigned char': 'tp_unsigned_char',
  'OpusEncoder': 't_OpusEncoder',
  '*OpusEncoder': 'tp_OpusEncoder',
  'OpusDecoder': 't_OpusDecoder',
  '*OpusDecoder': 'tp_OpusDecoder',
  'void': 't_void',
  'OpusCustomMode': 't_OpusCustomMode',
  '*OpusCustomMode': 'tp_OpusCustomMode',
  'OpusCustomEncoder': 't_OpusCustomEncoder',
  '*OpusCustomEncoder': 'tp_OpusCustomEncoder',
  'OpusCustomDecoder': 't_OpusCustomDecoder',
  '*OpusCustomDecoder': 'tp_OpusCustomDecoder',
  'OpusProjectionDecoder': 't_OpusProjectionDecoder',
  '*OpusProjectionDecoder': 'tp_OpusProjectionDecoder',
  'OpusProjectionEncoder': 't_OpusProjectionEncoder',
  '*OpusProjectionEncoder': 'tp_OpusProjectionEncoder',
  'OpusRepacketizer': 't_OpusRepacketizer',
  '*OpusRepacketizer': 'tp_OpusRepacketizer',
  'OpusMSDecoder': 't_OpusMSDecoder',
  '*OpusMSDecoder': 'tp_OpusMSDecoder',
  'OpusMSEncoder': 't_OpusMSEncoder',
  '*OpusMSEncoder': 'tp_OpusMSEncoder'
};
