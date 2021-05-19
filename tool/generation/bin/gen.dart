/// This class uses ffi_tool to generate binding code
import 'dart:io';

import 'package:ffi_tool/c.dart';

import 'package:opus_dart_generation/opus_encoder.dart';
import 'package:opus_dart_generation/opus_decoder.dart';
import 'package:opus_dart_generation/opus_repacketizer.dart';
import 'package:opus_dart_generation/opus_libinfo.dart';
import 'package:opus_dart_generation/opus_multistream.dart';
import 'package:opus_dart_generation/opus_projection.dart';
import 'package:opus_dart_generation/opus_custom.dart';

String preamble(String name, String file) {
  return '''/// Contains methods and structs from the $name group of $file.
/// SHOULD be imported as $name and MUST be initalized using its [init] function.
///
/// AUTOMATICALLY GENERATED FILE. DO NOT MODIFY.''';
}

List<List> configs = [
  ['opus_encoder', preamble('opus_encoder', 'opus.h'), opus_encoder],
  ['opus_decoder', preamble('opus_decoder', 'opus.h'), opus_decoder],
  [
    'opus_repacketizer',
    preamble('opus_repacketizer', 'opus.h'),
    opus_repacketizer
  ],
  ['opus_libinfo', preamble('opus_libinfo', 'opus_defines.h'), opus_libinfo],
  [
    'opus_multistream',
    preamble('opus_multistream', 'opus_multistream.h'),
    opus_multistream
  ],
  [
    'opus_projection',
    preamble('opus_projection', 'opus_projection.h'),
    opus_projection
  ],
  ['opus_custom', preamble('opus_custom', 'opus_custom.h'), opus_custom]
];

void main() async {
  for (List config in configs) {
    File f = await new File('./output/lib/wrappers/${config[0]}.dart')
        .create(recursive: true);
    generateFile(
        f,
        Library.withoutLoading(
            libraryName: config[0],
            dynamicLibraryIdentifier: '_${config[0]}',
            preamble: config[1],
            elements: config[2]));
  }
}
