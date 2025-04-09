import 'dart:ui';

extension StringExt on String {
  ///## It capitalize the first letter of the word/s
  String get toTitleCase {
    // Split the string by non-alphabetic characters (spaces, underscores, etc.)
    List<String> words = replaceAll(
      RegExp(r'[_-]'),
      ' ',
    ) // Replace underscores and hyphens with spaces
        .split(' ') // Split by spaces
        .map((word) => word.trim()) // Remove any leading or trailing spaces
        .where((word) => word.isNotEmpty) // Remove empty words if any
        .toList();

    // Capitalize the first letter of each word and join them back together
    return words
        .map(
          (word) => word.isNotEmpty
              ? word[0].toUpperCase() + word.substring(1).toLowerCase()
              : '',
        )
        .join(' ');
  }

  ///## It converts Hex or rgb to Color()
  Color? get toColor {
    String colorStr = this;
    try {
      RegExp hexColorRegex =
          RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$');
      if (colorStr.startsWith("rgba")) {
        List rgbaList = colorStr.substring(5, colorStr.length - 1).split(",");
        return Color.fromRGBO(int.parse(rgbaList[0]), int.parse(rgbaList[1]),
            int.parse(rgbaList[2]), double.parse(rgbaList[3]));
      } else if (colorStr.startsWith("rgb")) {
        List rgbList = colorStr
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
