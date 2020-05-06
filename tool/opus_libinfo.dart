import 'package:ffi_tool/c.dart';

import 'types.dart';

const List<Element> opus_libinfo = <Element>[
  Func(
      documentation: '''Gets the libopus version string.

Applications may look for the substring "-fixed" in the version string to determine whether they have a fixed-point or floating-point build at runtime.

@returns Version string''',
      name: 'opus_get_version_string',
      parameterTypes: [],
      returnType: tp_utf8),
  Func(
      documentation:
          '''Converts an opus error code into a human readable string.

@param[in] error <tt>int</tt>: Error number
@returns Error string''',
      name: 'opus_strerror',
      parameterTypes: [t_int],
      parameterNames: ['error'],
      returnType: tp_utf8)
];
