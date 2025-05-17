import 'package:flutter/material.dart';
import 'package:checkpoint/components/app_bar.dart';
import 'package:checkpoint/entities/enums/variable.dart';
import 'package:checkpoint/entities/models/checkpoint_model.dart';
import 'package:checkpoint/entities/models/race_split_model.dart';
import 'package:checkpoint/pages/tracking/two_step.dart';
import 'package:checkpoint/services/checkpoint_provider.dart';
import 'package:checkpoint/services/current_race_provider.dart';
import 'package:provider/provider.dart';
import 'package:checkpoint/components/grid_cell.dart';

class GridTrackingScreen extends StatelessWidget {
  final String splitId;

  const GridTrackingScreen({super.key, required this.splitId});

  void onTrack(BuildContext context, String bib) {
    CheckpointProvider checkpoint = context.read<CheckpointProvider>();

    checkpoint.create(bib: bib, splitId: splitId);
  }

  void onUntrack(BuildContext context, String bib) {
    CheckpointProvider checkpoint = context.read<CheckpointProvider>();

    checkpoint.delete(bib: bib, splitId: splitId);
  }

  @override
  Widget build(BuildContext context) {
    CurrentRaceProvider race = context.watch<CurrentRaceProvider>();
    CheckpointProvider checkpoint = context.watch<CheckpointProvider>();
    Widget body;

    RaceSplit? split = race.currentRace?.getSplitById(splitId);

    if (split == null) {
      return Scaffold(
        // appBar: CheckpointAppBar(
        //   titleText: 'Loading race data',
        // ),
        body: null,
      );
    } else if (race.participants.isNotEmpty) {
      body = Padding(
        padding: const EdgeInsets.all(CheckpointVariable.screenMargin),
        child: GridView.count(
          padding: const EdgeInsets.all(0),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 171 / 64,
          children:
              race.participants.map((item) {
                SplitTime? time = checkpoint.getTimeFor(
                  bib: item.bib,
                  splitId: splitId,
                );

                return CheckpointGridCell(
                  bib: item.bib,
                  startTime: race.startTime,
                  finishTime: time?.time,
                  onTrack: () {
                    onTrack(context, item.bib);
                  },
                  onUntrack: () {
                    onUntrack(context, item.bib);
                  },
                );
              }).toList(),
        ),
      );
    } else {
      body = const Center(child: Text('No participant data.'));
    }

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder:
            (ctx, _) => [
              CheckpointAppBar.withTimer(
                titleText: 'Tracking ${split.name} finish',
                startTime: race.startTime,
                finishTime: race.finishTime,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => TwoStepTrackingScreen(splitId: splitId),
                        ),
                      );
                    },
                    icon: Icon(Icons.change_circle),
                  ),
                ],
              ),
            ],
        body: body,
      ),
    );
  }
}
