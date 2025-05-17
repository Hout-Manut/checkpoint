import 'package:flutter/material.dart';
import 'package:checkpoint/entities/enums/theme.dart';

class TrackingSwitcher extends StatelessWidget {
  const TrackingSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: CheckpointColor.deepNeutral,
          context: context,
          builder: (context) {
            return Padding(padding: const EdgeInsets.all(20), child: Column(
              children: [],
            ));
          },
        );
      },
      icon: Icon(Icons.change_circle),
    );
  }
}
