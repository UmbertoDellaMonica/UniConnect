import 'package:flutter/material.dart';

import 'utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final CustomType type;
  final VoidCallback onPressed;
  final bool expandWidth;

  const CustomButton({super.key,
    this.text = "",
    required this.type,
    required this.onPressed,
    this.expandWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    if(!expandWidth) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorUtils.getColor(type),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Arrotonda i bordi
            ),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20), // Spazio interno
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Testo più grande e bold
            foregroundColor: type == CustomType.neutralShade
                ? ColorUtils.getColor(CustomType.neutral)
                : Colors.white
        ),
        child: Text(text.isEmpty ? Enums.getTypeButton(type) : text),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorUtils.getColor(type),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 20,
          ),
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          foregroundColor: type == CustomType.neutralShade
              ? ColorUtils.getColor(CustomType.neutral)
              : Colors.white,
        ),
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(text.isEmpty ? Enums.getTypeButton(type) : text),
          ),
        ),
      );
    }
  }
}