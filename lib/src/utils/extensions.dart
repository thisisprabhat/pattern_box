import 'dart:ui';

extension StringExt on String {
  /// Capitalizes the first letter of each word.
  /// Handles camelCase, snake_case, kebab-case, and spaces.
  String get toTitleCase {
    // Step 1: Insert space before every capital letter (for camelCase)
    String spaced = replaceAllMapped(
      RegExp(r'(?<=[a-z])([A-Z])'),
      (match) => ' ${match.group(0)}',
    );

    // Step 2: Replace underscores and hyphens with spaces
    spaced = spaced.replaceAll(RegExp(r'[_-]'), ' ');

    // Step 3: Split, clean, capitalize
    List<String> words =
        spaced
            .split(' ')
            .map((word) => word.trim())
            .where((word) => word.isNotEmpty)
            .map(
              (word) => word[0].toUpperCase() + word.substring(1).toLowerCase(),
            )
            .toList();

    return words.join(' ');
  }

  String get toPascalCase {
    return split(RegExp(r'[\s_-]+'))
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join('');
  }

  ///## It converts Hex or rgb to Color()
  Color? get toColor {
    String colorStr = this;
    try {
      RegExp hexColorRegex = RegExp(
        r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$',
      );
      if (colorStr.startsWith("rgba")) {
        List rgbaList = colorStr.substring(5, colorStr.length - 1).split(",");
        return Color.fromRGBO(
          int.parse(rgbaList[0]),
          int.parse(rgbaList[1]),
          int.parse(rgbaList[2]),
          double.parse(rgbaList[3]),
        );
      } else if (colorStr.startsWith("rgb")) {
        List rgbList =
            colorStr
                .substring(4, colorStr.length - 1)
                .split(",")
                .map((c) => int.parse(c))
                .toList();
        return Color.fromRGBO(rgbList[0], rgbList[1], rgbList[2], 1.0);
      } else if (hexColorRegex.hasMatch(colorStr)) {
        if (colorStr.length == 4) {
          colorStr = colorStr + colorStr.substring(1, 4);
        }
        if (colorStr.length == 7) {
          int colorValue = int.parse(colorStr.substring(1), radix: 16);
          return Color(colorValue).withAlpha((1.0 * 255).toInt());
        } else {
          int colorValue = int.parse(colorStr.substring(1, 7), radix: 16);
          double opacityValue =
              int.parse(colorStr.substring(7), radix: 16).toDouble() / 255;
          return Color(colorValue).withAlpha((opacityValue * 255).toInt());
        }
      } else if (colorStr.isEmpty) {
        return null;
      } else if (colorStr == 'none') {
        return null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

extension ColorToHex on Color {
  /// Convert the color to a hex string
  String? get toHex {
    try {
      final hexString =
          '#${a.floor().toRadixString(16).padLeft(2, '0')}'
          '${r.floor().toRadixString(16).padLeft(2, '0')}'
          '${g.floor().toRadixString(16).padLeft(2, '0')}'
          '${b.floor().toRadixString(16).padLeft(2, '0')}';

      return hexString;
    } catch (e) {
      return null;
    }
  }
}
