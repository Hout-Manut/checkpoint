import 'package:flutter/material.dart';
import 'package:checkpoint/entities/enums/theme.dart';

class RaceNavigator extends StatelessWidget {
  final int selectedIndex;
  final void Function(int index) onSelect;

  const RaceNavigator({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CheckpointColor.deepNeutral,
      height: 54,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: false,
        children: [
          RaceNavigatorItem(
            label: 'Detail',
            onSelect: () => onSelect(0),
            selected: selectedIndex == 0,
          ),
          Container(
            width: 1,
            height: 16,
            margin: EdgeInsets.symmetric(vertical: 12),
            color: CheckpointColor.secondary.withAlpha(100),
          ),
          RaceNavigatorItem(
            label: 'Participant',
            onSelect: () => onSelect(1),
            selected: selectedIndex == 1,
          ),
          Container(
            width: 1,
            height: 16,
            margin: EdgeInsets.symmetric(vertical: 12),
            color: CheckpointColor.secondary.withAlpha(100),
          ),
          RaceNavigatorItem(
            label: 'Tracker',
            onSelect: () => onSelect(2),
            selected: selectedIndex == 2,
          ),
          Container(
            width: 1,
            height: 16,
            margin: EdgeInsets.symmetric(vertical: 12),
            color: CheckpointColor.secondary.withAlpha(100),
          ),
          RaceNavigatorItem(
            label: 'Result',
            onSelect: () => onSelect(3),
            selected: selectedIndex == 3,
          ),
        ],
      ),
    );
  }
}

class RaceNavigatorItem extends StatelessWidget {
  final String label;
  final bool selected;
  final void Function() onSelect;

  const RaceNavigatorItem({
    super.key,
    required this.selected,
    required this.onSelect,
    required this.label,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
              style: TextStyle(
                color:
                    selected
                        ? CheckpointColor.primary
                        : CheckpointColor.foreground,
              ),
              child: Text(label, style: const TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              height: 3,
              width: 40,
              color:
                  selected
                      ? CheckpointColor.primary
                      : CheckpointColor.primary.withAlpha(0),
            ),
          ],
        ),
      ),
    );
  }
}
