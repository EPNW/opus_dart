import 'dart:ffi';
import 'dart:io' show Platform;
import 'package:opus_dart/wrappers/opus_custom.dart' as opus_custom;
import 'package:opus_dart/wrappers/opus_encoder.dart' as opus_encoder;
import 'package:opus_dart/wrappers/opus_decoder.dart' as opus_decoder;
import 'package:opus_dart/wrappers/opus_libinfo.dart' as opus_libinfo;
import 'package:opus_dart/wrappers/opus_multistream.dart' as opus_multistream;
import 'package:opus_dart/wrappers/opus_projection.dart' as opus_projection;
import 'package:opus_dart/wrappers/opus_repacketizer.dart' as opus_repacketizer;

const bool libWasBuildWithCustomEnabled = false;

late final opus_custom.FunctionsAndGlobals custom;
late final opus_encoder.FunctionsAndGlobals encoder;
late final opus_decoder.FunctionsAndGlobals decoder;
late final opus_libinfo.FunctionsAndGlobals libinfo;
late final opus_multistream.FunctionsAndGlobals multistream;
late final opus_projection.FunctionsAndGlobals projection;
late final opus_repacketizer.FunctionsAndGlobals repacketizer;
void main() {
  DynamicLibrary lib;
  if (Platform.isWindows) {
    bool x64 = Platform.version.contains('x64');
    if (x64) {
      lib =
          new DynamicLibrary.open('C:/Users/Eric/Desktop/opus/libopus_x64.dll');
    } else {
      lib = new DynamicLibrary.open('path/to/libopus_x86.dll');
    }
  } else if (Platform.isLinux) {
    lib = new DynamicLibrary.open('/usr/local/lib/libopus.so');
  } else {
    throw new UnsupportedError('This programm does not support this platform!');
  }
  encoder = new opus_encoder.FunctionsAndGlobals(lib);
  print('encoder lookup successful');
  decoder = new opus_decoder.FunctionsAndGlobals(lib);
  print('decoder lookup successful');
  libinfo = new opus_libinfo.FunctionsAndGlobals(lib);
  print('libinfo lookup successful');
  multistream = new opus_multistream.FunctionsAndGlobals(lib);
  print('multistream lookup successful');
  projection = new opus_projection.FunctionsAndGlobals(lib);
  print('projection lookup successful');
  repacketizer = new opus_repacketizer.FunctionsAndGlobals(lib);
  print('repacketizer lookup successful');
  if (libWasBuildWithCustomEnabled) {
    custom = new opus_custom.FunctionsAndGlobals(lib);
    print('custom lookup successful');
  } else {
    print(
        'opus_custom support was not enabled while building the library, so trying to instantiate opus_custom.FunctionsAndGlobals will result in lookup failures, skipping...');
  }
  print('all lookups successful');
}
