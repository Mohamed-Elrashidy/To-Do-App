import 'package:flutter/material.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/textformat.dart';

class MyButton extends StatelessWidget {
  const MyButton({required this.label, required this.onTap});
  final String label;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
      child: Center(
        child: Container(
            width: 100,
            height: 45,
            decoration: BoxDecoration(
                color: primaryClr, borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              label,
              style: bodyStyle(),
            ))),
      ),
    );
  }
}
