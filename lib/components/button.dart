import 'package:flutter/material.dart';
import 'package:checkpoint/entities/enums/button_type.dart';
import 'package:checkpoint/entities/enums/theme.dart';

class CheckpointButton extends StatelessWidget {
  final String label;
  final ButtonType type;
  final bool isDisabled;
  final void Function() onClick;

  const CheckpointButton(
    this.label, {
    super.key,
    required this.type,
    this.isDisabled = false,
    required this.onClick,
  });

  ButtonStyle get style {
    switch (type) {
      case ButtonType.primary:
        return CheckpointStyle.buttonPrimary;
      case ButtonType.secondary:
        return CheckpointStyle.buttonSecondary;
      case ButtonType.danger:
        return CheckpointStyle.buttonDanger;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      style: style,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Text(label),
      ),
    );
  }
}
