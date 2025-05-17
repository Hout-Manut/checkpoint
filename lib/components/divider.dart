import 'package:flutter/material.dart';

class CheckpointDivider extends StatelessWidget {
  final String? label;

  const CheckpointDivider(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 16),
        color: const Color(0xfff0f0f0),
        child: Text(
          label!,
          style: const TextStyle(color: Color(0xff5d5d5d), fontSize: 14),
        ),
      );
    }
    return Container(
      width: double.infinity,
      height: 1,
      color: const Color(0xfff0f0f0),
    );
  }
}
