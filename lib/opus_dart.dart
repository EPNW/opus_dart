/// A dart friendly api for encoding and decoding opus packets.
/// Must be initalized using the [initOpus] function.
library opus_dart;

export 'src/opus_dart_decoder.dart';
export 'src/opus_dart_encoder.dart';
export 'src/opus_dart_misc.dart' hide ApiObject, opus;
export 'src/opus_dart_packet.dart';
export 'src/opus_dart_streaming.dart';
