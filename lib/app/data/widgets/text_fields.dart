import 'package:flutter/material.dart';

class InputFields extends StatelessWidget {
  final String titleText;
  final TextEditingController controller;
  final bool isDense;
  final TextInputType keyboardType;
  final double sizeForTextField;

  const InputFields(
      {Key? key,
      required this.controller,
      required this.titleText,
      required this.isDense,
      this.sizeForTextField = 20,
      required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titleText,
          style: const TextStyle(color: Colors.white),
        ),
        Flexible(
            child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              isDense: isDense,
              contentPadding: EdgeInsets.all(sizeForTextField),
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white),
        ))
      ],
    );
  }
}
