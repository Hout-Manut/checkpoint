import 'package:flutter/material.dart';
import 'package:checkpoint/entities/enums/theme.dart';
import 'package:checkpoint/entities/enums/variable.dart';
import 'package:checkpoint/entities/helpers/utils.dart';
import 'package:checkpoint/entities/models/race_model.dart';

class RaceCard extends StatelessWidget {
  final Race race;
  final void Function() onClick;
  const RaceCard({super.key, required this.race, required this.onClick});

  static const double imageWidth = 100;
  static const double hight = 124;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: CheckpointVariable.screenMargin,
        vertical: 4,
      ),
      child: InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(CheckpointVariable.cardBorder + 1),
        child: Container(
          height: hight,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              CheckpointVariable.cardBorder + 1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [const Color(0x80808A93), const Color(0x1A808A93)],
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: CheckpointColor.deepNeutral,
              borderRadius: BorderRadius.circular(
                CheckpointVariable.cardBorder,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/checkpoint_sport_image.png',
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  height: hight,
                  width: imageWidth,
                  repeat: ImageRepeat.repeat,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(race.name, style: CheckpointStyle.bodyLarge),
                        Text(
                          '${race.totalDistance}KM',
                          style: CheckpointStyle.labelNeutral,
                        ),
                        Row(
                          children: [
                            Text(
                              race.participants.length.toString(),
                              style: CheckpointStyle.labelHighlight,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              formatDateTime(race.raceDate),
                              style: CheckpointStyle.labelNeutral,
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        Text(race.state.name, style: CheckpointStyle.label),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
