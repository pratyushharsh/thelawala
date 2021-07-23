import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final String label;
  final Function(bool val) onChange;
  final bool value;
  const CustomSwitch(
      {Key? key,
      required this.value,
      required this.label,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$label', style: TextStyle(),),
        Switch(
          activeColor: Colors.green,
          value: value,
          onChanged: onChange,
        )
      ],
    );
  }
}
