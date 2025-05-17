import 'package:flutter/material.dart';
import 'package:checkpoint/entities/enums/theme.dart';
import 'package:checkpoint/entities/enums/variable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:checkpoint/services/current_race_provider.dart';

class ParticipantScreen extends StatelessWidget {
  static DateFormat formatter = DateFormat("EEEE, d MMM y hh:mm a");
  const ParticipantScreen({super.key});
  @override
  Widget build(BuildContext context) {
    CurrentRaceProvider race = context.watch<CurrentRaceProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CheckpointVariable.screenMargin,
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('BIB', style: CheckpointStyle.subtitle),
                  Text('Name', style: CheckpointStyle.subtitle),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: CheckpointVariable.screenMargin,
              ),
              height: 1,
              color: CheckpointColor.divider,
            ),
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              itemCount: race.participants.length,
              separatorBuilder:
                  (context, index) => Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: CheckpointVariable.screenMargin,
                    ),
                    height: 1,
                    color: CheckpointColor.divider,
                  ),
              itemBuilder: (context, index) {
                final part = race.participants[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: CheckpointVariable.screenMargin,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(part.bib, style: CheckpointStyle.body),
                      Text(part.name, style: CheckpointStyle.body),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
