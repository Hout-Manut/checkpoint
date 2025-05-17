import 'package:flutter/material.dart';
import 'package:checkpoint/components/button.dart';
import 'package:checkpoint/components/list_tile.dart';
import 'package:checkpoint/entities/enums/button_type.dart';
import 'package:checkpoint/entities/enums/theme.dart';
import 'package:checkpoint/entities/enums/variable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:checkpoint/services/current_race_provider.dart';

class RaceDashboardScreen extends StatelessWidget {
  static DateFormat formatter = DateFormat("EEEE, d MMM y hh:mm a");
  const RaceDashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    CurrentRaceProvider race = context.watch<CurrentRaceProvider>();

    CheckpointButton button;

    if (race.notStarted) {
      button = CheckpointButton(
        'Start',
        type: ButtonType.primary,
        isDisabled: false,
        onClick: () {
          race.startRace();
        },
      );
    } else {
      button = CheckpointButton(
        'Finished',
        type: ButtonType.primary,
        isDisabled: false,
        onClick: () {
          race.finishRace();
        },
      );
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                CheckpointListTile(
                  leading: Icon(Icons.title),
                  titleText: race.name,
                ),
                const Divider(),
                CheckpointListTile(
                  leading: Icon(Icons.date_range),
                  titleText:
                      race.currentRace != null
                          ? formatter.format(race.currentRace!.raceDate)
                          : '',
                ),

                ...race.splits.map((x) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: CheckpointVariable.screenMargin,
                        ),
                        child: Text(
                          x.name,
                          style: CheckpointStyle.subtitle.copyWith(
                            color: CheckpointColor.secondary,
                          ),
                        ),
                      ),
                      CheckpointListTile(
                        // leading: Icon(x.sport),
                        titleText:
                            x.sport.name[0].toUpperCase() +
                            x.sport.name.substring(1),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: CheckpointVariable.screenMargin,
                        ),
                        height: 1,
                        color: CheckpointColor.divider,
                      ),
                      CheckpointListTile(
                        leading: Icon(Icons.all_inclusive_rounded),
                        titleText: '${x.distance / 1000}KM',
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          Positioned(
            bottom:
                MediaQuery.of(context).padding.bottom +
                CheckpointVariable.screenMargin,
            left: CheckpointVariable.screenMargin,
            right: CheckpointVariable.screenMargin,
            child: button,
          ),
        ],
      ),
    );
  }
}
