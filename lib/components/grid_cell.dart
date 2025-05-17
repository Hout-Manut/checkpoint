import 'dart:async';

import 'package:flutter/material.dart';
import 'package:checkpoint/components/timer.dart';
import 'package:checkpoint/entities/enums/theme.dart';
import 'package:checkpoint/entities/enums/variable.dart';

class CheckpointGridCell extends StatefulWidget {
  final String bib;
  final DateTime? startTime;
  final DateTime? finishTime;
  final void Function() onTrack;
  final void Function() onUntrack;
  const CheckpointGridCell({
    super.key,
    required this.bib,
    required this.startTime,
    required this.finishTime,
    required this.onTrack,
    required this.onUntrack,
  });

  @override
  State<CheckpointGridCell> createState() => _CheckpointGridCellState();
}

class _CheckpointGridCellState extends State<CheckpointGridCell> {
  bool removing = false;
  Timer? resetRemovingTimer;
  @override
  void initState() {
    resetRemoving();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CheckpointGridCell oldWidget) {
    resetRemoving();
    super.didUpdateWidget(oldWidget);
  }

  void resetRemoving() {
    if (widget.finishTime != null) {
      removing = false;
    }
  }

  void cancelTimer() {
    if (resetRemovingTimer?.isActive ?? false) {
      resetRemovingTimer!.cancel();
    }
  }

  void onTap() {
    if (widget.finishTime != null) {
      if (removing) {
        cancelTimer();
        widget.onUntrack();
        removing = false;
        setState(() {});
        return;
      }
      removing = true;
      cancelTimer();

      resetRemovingTimer = Timer(const Duration(seconds: 5), () {
        setState(() {
          removing = false;
        });
      });
    } else {
      widget.onTrack();
      removing = false;
    }
    setState(() {});
  }

  @override
  void dispose() {
    cancelTimer();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(CheckpointVariable.cardBorder + 1),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutExpo,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            CheckpointVariable.cardBorder + 1,
          ),
          border:
              widget.finishTime == null
                  ? null
                  : Border.all(
                    color:
                        removing
                            ? CheckpointColor.danger
                            : CheckpointColor.deepNeutral,
                  ),
          gradient:
              widget.finishTime == null
                  ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color(0x80808A93), const Color(0x1A808A93)],
                  )
                  : null,
        ),
        child: AnimatedContainer(
          height: 64,
          curve: Curves.easeOutExpo,
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color:
                widget.finishTime == null ? CheckpointColor.deepNeutral : null,
            borderRadius: BorderRadius.circular(CheckpointVariable.cardBorder),
          ),
          duration: const Duration(milliseconds: 200),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedDefaultTextStyle(
                    style: TextStyle(
                      fontSize: CheckpointStyle.bodyLarge.fontSize,
                      fontWeight: CheckpointStyle.bodyLarge.fontWeight,
                      color:
                          removing
                              ? CheckpointColor.danger
                              : CheckpointColor.secondary,
                    ),
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutExpo,
                    child: Text(widget.bib, textAlign: TextAlign.center),
                  ),
                  if (widget.finishTime != null)
                    CheckpointTimer(
                      startTime: widget.startTime,
                      finishTime: widget.finishTime,
                      style: CheckpointStyle.labelMonospace.copyWith(color: CheckpointColor.neutral),
                    ),
                ],
              ),
              Positioned(
                right: 10,
                child: AnimatedOpacity(
                  opacity: removing ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutExpo,
                  child: Icon(
                    Icons.keyboard_backspace_rounded,
                    color: CheckpointColor.danger,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
