import 'dart:async';

import 'package:flutter/material.dart';
import 'package:checkpoint/entities/enums/theme.dart';

class CheckpointTimer extends StatefulWidget {
  final DateTime? startTime;
  final DateTime? finishTime;
  final double fontSize;
  final TextStyle? style;
  final bool notStartUsesDashes;

  const CheckpointTimer({
    super.key,
    this.startTime,
    this.finishTime,
    this.fontSize = 14,
    this.notStartUsesDashes = false,
    this.style,
  });

  @override
  State<StatefulWidget> createState() => _CheckpointTimerState();
}

class _CheckpointTimerState extends State<CheckpointTimer> {
  Timer? timer;
  late Duration elapsed;
  late DateTime startDate;
  late String notStartedString;
  bool isFinished = false;

  late TextStyle style;

  @override
  void initState() {
    super.initState();

    _setupTimer();
  }

  @override
  void didUpdateWidget(covariant CheckpointTimer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.startTime != oldWidget.startTime ||
        widget.finishTime != oldWidget.finishTime) {
      _setupTimer();
    }
  }

  void _setupTimer() {
    notStartedString =
        widget.notStartUsesDashes ? '--:--:--.--' : '00:00:00.00';

    style = CheckpointStyle.labelMonospace;
    timer?.cancel();

    if (widget.startTime == null) {
      elapsed = Duration.zero;
      isFinished = false;
      setState(() {}); // update if necessary
      return;
    }

    startDate = widget.startTime!;
    if (widget.finishTime != null) {
      final endDate = widget.finishTime!;
      elapsed = endDate.difference(startDate);
      isFinished = true;
      setState(() {}); // update to show result
    } else {
      elapsed = DateTime.now().difference(startDate);
      isFinished = false;
      timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
        setState(() {
          elapsed = DateTime.now().difference(startDate);
        });
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String padNum(int n) {
    return n.toString().padLeft(2, '0');
  }

  String format(Duration d) {
    final ms2digits = (d.inMilliseconds % 1000 ~/ 10);
    return "${padNum(d.inHours)}:${padNum(d.inMinutes % 60)}:${padNum(d.inSeconds % 60)}.${padNum(ms2digits)}";
  }

  @override
  Widget build(BuildContext context) {
    if (widget.startTime == null) return Text(notStartedString, style: style);

    return Text(format(elapsed), style: widget.style ?? style);
  }
}
