import 'package:web_ffi/web_ffi.dart';
import 'package:web_ffi/web_ffi_modules.dart';

import 'opus_dart_misc.dart' show ApiObject;

import '../wrappers/opus_custom.dart' as opus_custom;
import '../wrappers/opus_multistream.dart' as opus_multistream;
import '../wrappers/opus_projection.dart' as opus_projection;
import '../wrappers/opus_repacketizer.dart' as opus_repacketizer;
import '../wrappers/opus_encoder.dart' as opus_encoder;
import '../wrappers/opus_decoder.dart' as opus_decoder;

ApiObject createApiObject(DynamicLibrary library) {
  registerOpaqueType<opus_custom.OpusCustomEncoder>();
  registerOpaqueType<opus_custom.OpusCustomDecoder>();
  registerOpaqueType<opus_custom.OpusCustomMode>();
  registerOpaqueType<opus_decoder.OpusDecoder>();
  registerOpaqueType<opus_encoder.OpusEncoder>();
  registerOpaqueType<opus_multistream.OpusMSEncoder>();
  registerOpaqueType<opus_multistream.OpusMSDecoder>();
  registerOpaqueType<opus_projection.OpusProjectionEncoder>();
  registerOpaqueType<opus_projection.OpusProjectionDecoder>();
  registerOpaqueType<opus_repacketizer.OpusRepacketizer>();
  return new ApiObject(library, library.boundMemory);
}
