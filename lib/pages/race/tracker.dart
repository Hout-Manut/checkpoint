import 'package:flutter/material.dart';
import 'package:checkpoint/entities/enums/theme.dart';
import 'package:checkpoint/entities/enums/variable.dart';
import 'package:checkpoint/pages/tracking/two_step.dart';
import 'package:checkpoint/services/checkpoint_provider.dart';
import 'package:checkpoint/services/current_race_provider.dart';
import 'package:provider/provider.dart';

class TrackerScreen extends StatelessWidget {
  const TrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CurrentRaceProvider race = context.watch<CurrentRaceProvider>();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(CheckpointVariable.screenMargin),
              child: Text('Start timer', style: CheckpointStyle.label),
            ),
          ),
          const Divider(),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: CheckpointVariable.screenMargin,
            ),
            child: Text(
              'Split timers',
              style: CheckpointStyle.subtitle.copyWith(
                color: CheckpointColor.secondary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: race.splits.length,
            separatorBuilder:
                (context, index) => Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                ),
            itemBuilder: (context, index) {
              final split = race.splits[index];

              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        context.read<CheckpointProvider>().setRaceId(
                          race.raceId,
                        );
                        return TwoStepTrackingScreen(splitId: split.id);
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: CheckpointVariable.screenMargin,
                  ),
                  child: Text(
                    '${split.name} finish timer',
                    style: CheckpointStyle.label,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
