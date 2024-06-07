import 'package:flutter/material.dart';

import 'utils/constants.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final void Function(T?) onChanged;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  late T selectedValue;
  CustomType type = CustomType.neutralShade;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value ?? widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xA91E88D0),
        border: Border.all(color: ColorUtils.getColor(type)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: DropdownButton<T>(
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as T;
          });
          widget.onChanged(value);
        },
        isExpanded: true,
        underline: Container(),
        items: widget.items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.toString(),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Container(), // Un contenitore vuoto al posto dell'icona negli items
              ],
            ),
          );
        }).toList(),
        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
      ),
    );
  }
}