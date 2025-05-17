import 'package:flutter/material.dart';
import 'package:checkpoint/components/button.dart';
import 'package:checkpoint/components/race_card.dart';
import 'package:checkpoint/entities/enums/button_type.dart';
import 'package:checkpoint/entities/enums/theme.dart';
import 'package:checkpoint/entities/enums/variable.dart';
import 'package:checkpoint/entities/models/race_model.dart';
import 'package:checkpoint/pages/race/main.dart';
import 'package:checkpoint/services/checkpoint_provider.dart';
import 'package:checkpoint/services/current_race_provider.dart';
import 'package:checkpoint/services/races_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void enterRace(BuildContext context, String raceId) {
    context.read<CurrentRaceProvider>().setRaceId(raceId);
    context.read<CheckpointProvider>().setRaceId(raceId);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return RaceMainScreen(raceId: raceId);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    RacesProvider racesProvider = context.watch<RacesProvider>();
    Widget raceList;

    if (racesProvider.allRaces.isEmpty || racesProvider.allRaces.data == null) {
      raceList = Center(child: Text('No race data available.'));
    } else if (racesProvider.allRaces.isError) {
      raceList = Center(
        child: Text(
          'Error getting race data., ${racesProvider.allRaces.error!}',
        ),
      );
    } else if (racesProvider.allRaces.isLoading) {
      raceList = Center(child: Text('Loading...'));
    } else {
      List<Race> races = racesProvider.allRaces.data!;
      raceList = ListView.builder(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: races.length,
        itemBuilder: (context, index) {
          Race race = races[index];
          return RaceCard(
            race: race,
            onClick: () {
              enterRace(context, race.id);
            },
          );
        },
      );
    }

    return Scaffold(
      // appBar: CheckpointAppBar(titleText: 'Checkpoint'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            // const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CheckpointVariable.screenMargin,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CheckpointButton(
                      'Create',
                      type: ButtonType.primary,
                      onClick: () {},
                    ),
                  ),
                  const SizedBox(width: CheckpointVariable.screenMargin / 2),
                  Expanded(
                    child: CheckpointButton(
                      'Join',
                      type: ButtonType.secondary,
                      onClick: () {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CheckpointVariable.screenMargin,
              ),
              child: Text('Past races', style: CheckpointStyle.subtitle),
            ),
            const SizedBox(height: 16),
            raceList,
          ],
        ),
      ),
    );
  }
}
