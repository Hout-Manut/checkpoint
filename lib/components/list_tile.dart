import 'package:flutter/material.dart';
import 'package:checkpoint/entities/enums/theme.dart';
import 'package:checkpoint/entities/enums/variable.dart';

class CheckpointListTile extends StatelessWidget {
  final Widget? leading;
  final String? titleText;
  final String? subtitleText;
  final Widget? trailing;

  final Function()? onTap;
  const CheckpointListTile({
    super.key,
    this.leading,
    this.titleText,
    this.subtitleText,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title:
          titleText != null
              ? Text(titleText!, style: CheckpointStyle.body)
              : null,
      subtitle:
          subtitleText != null
              ? Text(subtitleText!, style: CheckpointStyle.body)
              : null,
      trailing: trailing,
      onTap: onTap,
      iconColor: CheckpointColor.foreground,
      minTileHeight: 32,
      contentPadding: EdgeInsets.symmetric(horizontal: CheckpointVariable.screenMargin, vertical: 10),
    );
  }
}
