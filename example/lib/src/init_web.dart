// Notice that in this file, we import web_ffi and not proxy_ffi.dart
import 'package:web_ffi/web_ffi.dart';
// and additionally
import 'package:web_ffi/web_ffi_modules.dart';

// We need this imports to register all Opaque types
// Note that if only the dart friendly api is used, this is all done
// automatically when opus_dart.initOpus is called.
import 'package:opus_dart/wrappers/opus_custom.dart' as opus_custom;
import 'package:opus_dart/wrappers/opus_multistream.dart' as opus_multistream;
import 'package:opus_dart/wrappers/opus_projection.dart' as opus_projection;
import 'package:opus_dart/wrappers/opus_repacketizer.dart' as opus_repacketizer;
import 'package:opus_dart/wrappers/opus_encoder.dart' as opus_encoder;
import 'package:opus_dart/wrappers/opus_decoder.dart' as opus_decoder;

// There is no need to do this if only the dart friendly api is used
void _registerOpaques() {
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
}

Module? _module;

Future<void> initFfi() async {
  // Only initalize if there is no module yet
  if (_module == null) {
    Memory.init();

    _registerOpaques();

    // We use the process function here since we added
    // libopus.js to our html with a <script> tag
    _module = await EmscriptenModule.process('libopus');
  }
}

DynamicLibrary openOpus() {
  Module? m = _module;
  if (m != null) {
    return new DynamicLibrary.fromModule(m);
  } else {
    throw new StateError('You can not open opus before calling initFfi()!');
  }
}
