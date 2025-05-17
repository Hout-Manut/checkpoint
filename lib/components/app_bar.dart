import 'package:flutter/material.dart';
import 'package:checkpoint/components/timer.dart';
import 'package:checkpoint/entities/enums/theme.dart';

class CheckpointAppBar extends SliverAppBar {
  final Widget _title;
  final List<Widget>? _actions;

  CheckpointAppBar({
    super.key,
    required String titleText,
    List<Widget>? actions,
  }) : _title = Text(
         titleText,
         style: CheckpointStyle.body.copyWith(
           color: CheckpointColor.primary,
           fontWeight: FontWeight.bold,
           fontSize: 16,
         ),
       ),
       _actions = actions;

  CheckpointAppBar.withTimer({
    super.key,
    required String titleText,
    required DateTime? startTime,
    required DateTime? finishTime,
    List<Widget>? actions,
  }) : _title = Column(
         children: [
           Text(
             titleText,
             style: CheckpointStyle.body.copyWith(
               color: CheckpointColor.primary,
               fontWeight: FontWeight.bold,
               fontSize: 16,
             ),
           ),
           CheckpointTimer(startTime: startTime, finishTime: finishTime),
         ],
       ),
       _actions = actions;

  //  @override icon

  @override
  double? get elevation => 0;

  @override
  bool get floating => false;

  @override
  bool get pinned => true;

  @override
  bool? get centerTitle => true;

  @override
  Widget? get title => _title;

  @override
  Color? get backgroundColor => CheckpointColor.backgroundElevated;

  @override
  List<Widget>? get actions => _actions;

  @override
  bool get primary => true;

  // @override
  // PreferredSizeWidget? get bottom => PreferredSize(
  //   preferredSize: const Size.fromHeight(CheckpointVariable.appBarBorderWidth),
  //   child: Container(
  //     height: CheckpointVariable.appBarBorderWidth,
  //     width: double.infinity,
  //     color: CheckpointColor.appBarBorder,
  //   ),
  // );
}
