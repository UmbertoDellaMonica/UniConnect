import 'package:flutter/material.dart';
import 'package:uni_connect_front_end/shared/enums.dart';

class ColorUtils {

  /*
   *  Questa funzione restituire un colore basandosi sul CustomType
   */
  static Color getColor(CustomType type) {
      switch (type) {
        case CustomType.neutral:
          return Colors.blue;
        case CustomType.neutralShade:
          return Colors.blue.shade50;
        case CustomType.error:
          return Colors.red;
        case CustomType.warning:
          return Colors.amber;
        case CustomType.success:
          return Colors.green;
      }
    }

  static const Color labelColor = Color.fromARGB(255, 101, 133, 170);
}