/// I used this code to parse some of the headerfiles that you receive
/// in the include directory when you compile opus. I copied the headers
/// and did some manuall preprocessing like deleting some comments and
/// other lines. Thus I renamed theme to ".source". The headerfiles for
/// the encoder and decoder where processed manually, so they are not
/// listed here. The result of this operations is not the binding code,
/// but rather intermediate output that ffi_tool uses to generate the
/// final binding code. I just submit this code too, for the sake of
/// complteness.

import 'dart:convert';
import 'dart:io';

import 'types.dart';

const List<List<String>> files = [
  ['opus_custom', 'C:/Users/Eric/Desktop/opus/include/opus_custom.source'],
  [
    'opus_repacketizer',
    'C:/Users/Eric/Desktop/opus/include/opus_repacketizer.source'
  ],
  [
    'opus_projection',
    'C:/Users/Eric/Desktop/opus/include/opus_projection.source'
  ],
  [
    'opus_multistream',
    'C:/Users/Eric/Desktop/opus/include/opus_multistream.source'
  ]
];

void main() async {
  for (List<String> config in files) {
    String input = await new File(config.last).readAsString();
    List<JsonMap> p = parseHeader(input);
    String source = genSource(config.first, p);
    String f = 'tool/${config.first}.dart';
    await new File(f).writeAsString(source);
    _dartFmt(f);
  }
}

/// Formats a file with 'dartfmt'
void _dartFmt(String path) {
  final result =
      Process.runSync('dartfmt', ['-w', path], runInShell: Platform.isWindows);
  print(result.stdout);
  print(result.stderr);
}

List<JsonMap> parseHeader(String input) {
  List<String> tmp = input.replaceAll('\r\n', '\n').split('\n');
  tmp.removeWhere((String line) => line.startsWith('#'));
  input = tmp.join('\n');
  List<JsonMap> elements = [];
  tmp = input.countedSplit('/**', 1);
  while (tmp.length == 2) {
    tmp = tmp.last.countedSplit('*/', 1);
    input = tmp.last;
    String doc = tmp.first.trim().split('\n').map((String line) {
      if (line.startsWith('  * ')) {
        line = line.substring(4);
      }
      return line.trim();
    }).join('\n');
    input = input.trim();
    if (input.startsWith('typedef struct')) {
      String name = input.substring(15).split(' ').first;
      elements.add(new StructDefinition(doc, name));
      input = input.countedSplit(';', 1)[1];
    } else {
      tmp = input.countedSplit('(', 1);
      input = tmp.last;
      ParameterLine funcDef = new ParameterLine.parse(tmp.first);
      tmp = input.countedSplit(')', 1);
      input = tmp.last.countedSplit(';', 1)[1];
      tmp = tmp.first.split(',');
      bool isVaraidic = tmp.any((String e) => e.contains('...'));
      if (!isVaraidic) {
        List<ParameterLine> params;
        if (tmp.length == 1 && tmp.first.trim() == 'void') {
          params = [const VoidParameterLine()];
        } else {
          params =
              tmp.map((String line) => new ParameterLine.parse(line)).toList();
        }
        elements.add(new FuncDefinition(doc, funcDef, params));
      }
    }
    tmp = input.countedSplit('/**', 1);
  }
  return elements;
}

mixin JsonMap {
  Map<String, Object> jsonMap();

  @override
  String toString() {
    return json.encode(jsonMap());
  }
}

class FuncDefinition with JsonMap {
  final String documentation;
  final ParameterLine funcDefinition;
  final List<ParameterLine> params;

  const FuncDefinition(this.documentation, this.funcDefinition, this.params);

  Map<String, Object> jsonMap() => <String, Object>{
        'documentation': documentation,
        'header': funcDefinition.jsonMap(),
        'parameters':
            params.map((ParameterLine param) => param.jsonMap()).toList()
      };
}

class StructDefinition with JsonMap {
  final String documentation;
  final String name;
  const StructDefinition(this.documentation, this.name);

  Map<String, Object> jsonMap() =>
      <String, Object>{'documentation': documentation, 'name': name};
}

class VoidParameterLine extends ParameterLine {
  const VoidParameterLine() : super('void', false, 'null');
}

class ParameterLine with JsonMap {
  final bool isPointer;
  final String name;
  final String type;

  const ParameterLine(this.type, this.isPointer, this.name);

  factory ParameterLine.parse(String input) {
    input = input.trim();
    int nameStart = input.lastIndexOf(' ');
    String name = input.substring(nameStart + 1);
    bool pointer;
    if (name.startsWith('*')) {
      pointer = true;
      name = name.substring(1);
    } else if (name.endsWith(']')) {
      name = name.substring(0, name.indexOf('['));
      pointer = true;
    } else {
      pointer = false;
    }
    String type = input.substring(0, nameStart).replaceFirst('const ', '');
    type = type
        .replaceAll('OPUS_CUSTOM_EXPORT_STATIC', '')
        .replaceAll('OPUS_WARN_UNUSED_RESULT', '')
        .replaceAll('OPUS_CUSTOM_EXPORT', '')
        .replaceAll('OPUS_EXPORT', '')
        .trim();
    return new ParameterLine(type, pointer, name);
  }

  Map<String, Object> jsonMap() =>
      <String, Object>{'type': type, 'isPointer': isPointer, 'name': name};
}

extension CountedSplit on String {
  List<String> countedSplit(String pattern, int count) {
    List<String> all = this.split(pattern);
    if (all.length <= count) {
      return all;
    } else {
      List<String> splited = all.sublist(0, count);
      splited.add(all.sublist(count).join(pattern));
      return splited;
    }
  }
}

String genSource(String name, List<JsonMap> elements) {
  String content = elements.map<String>((JsonMap element) {
    if (element is FuncDefinition) {
      FuncDefinition func = element;
      String rt = returnType(func.funcDefinition);

      String parameterNames;
      String parameterTypes;

      if (func.params.length == 1 && func.params.first is VoidParameterLine) {
        parameterTypes = '[t_void]';
        parameterNames = 'null';
      } else {
        parameterNames = func.params
            .map((ParameterLine line) => '\'${line.name}\'')
            .join(',');
        parameterNames = '[$parameterNames]';

        parameterTypes = func.params.map(returnType).join(',');
        parameterTypes = '[$parameterTypes]';
      }

      return '''Func(
      documentation: \'\'\'${func.documentation}\'\'\',
      name: \'${func.funcDefinition.name}\',
      parameterTypes: $parameterTypes,
	    parameterNames: $parameterNames,
      returnType: $rt)''';
    } else if (element is StructDefinition) {
      StructDefinition struct = element;
      return '''Opaque(
      documentation: \'\'\'${struct.documentation}\'\'\',
      name: '${struct.name}')''';
    } else {
      throw new ArgumentError();
    }
  }).join(',');
  return '''import 'package:ffi_tool/c.dart';

import 'types.dart';

const List<Element> $name = <Element>[
  $content
];''';
}

String returnType(ParameterLine line) {
  String key = (line.isPointer ? '*' : '') + line.type;
  String? type = reverseTypeMap[key];
  if (type != null) {
    return type;
  } else {
    throw new ArgumentError('No type registered for $key');
  }
}
