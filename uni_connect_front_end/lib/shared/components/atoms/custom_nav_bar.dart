import 'package:uni_connect_front_end/shared/color_utils.dart';
import 'package:uni_connect_front_end/shared/enums.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool centerTitle;
  final double elevation;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.centerTitle = true,
    this.elevation = 0.0, 
    required bool automaticallyImplyLeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: ColorUtils.getColor(CustomType.neutral),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24.0,
            color: ColorUtils.getColor(CustomType.neutral), // Colore del testo neutrale
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      centerTitle: centerTitle,
      leading: leading,
      actions: actions,
      backgroundColor: backgroundColor,
      elevation: elevation,
    );
  }

  static buildSimpleNavBar(){
    return CustomAppBar(
            title: 'FilieraToken-Shop',
            leading: Image.asset('../assets/filiera-token-logo.png'),
            automaticallyImplyLeading: false,
      );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
