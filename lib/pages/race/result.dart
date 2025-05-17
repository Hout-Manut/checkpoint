import 'package:flutter/material.dart';
import 'package:checkpoint/components/navigator.dart';
import 'package:checkpoint/entities/enums/theme.dart';
import 'package:checkpoint/entities/enums/variable.dart';
import 'package:checkpoint/entities/models/participant_model.dart';
import 'package:checkpoint/services/checkpoint_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:checkpoint/services/current_race_provider.dart';

class ResultScreen extends StatefulWidget {
  static DateFormat formatter = DateFormat("hh:mm:ss.");
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  static const double rankWidth = 80;
  static const double bibWidth = 80;
  static const double timeWidth = 120;
  static const double nameWidth = 200;

  static const double totalWidth = rankWidth + bibWidth + timeWidth + nameWidth;


  String? splitId;

  void changeSplitId(String? splitId) {
    setState(() {
      this.splitId = splitId;
    });
  }

  @override
  Widget build(BuildContext context) {
    CurrentRaceProvider race = context.watch<CurrentRaceProvider>();
    CheckpointProvider checkpoint = context.watch<CheckpointProvider>();

    List<Participant> participants = race.participants;

    final List<(Participant, DateTime?)> participantTime = [];

    for (final participant in participants) {
      if (splitId == null) {
        participantTime.add((
          participant,
          checkpoint.getFinishedTimeFor(bib: participant.bib),
        ));
      } else {
        participantTime.add((
          participant,
          checkpoint.getTimeFor(bib: participant.bib, splitId: splitId!)?.time,
        ));
      }
    }

    participantTime.sort((a, b) {
      return (a.$2?.millisecondsSinceEpoch ?? double.infinity).compareTo(
        b.$2?.millisecondsSinceEpoch ?? double.infinity,
      );
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: CheckpointVariable.screenMargin,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaceNavigatorItem(
                      label: 'Overall',
                      onSelect: () => changeSplitId(null),
                      selected: splitId == null,
                    ),
                    ...race.splits.map((x) {
                      return RaceNavigatorItem(
                        label: x.name,
                        onSelect: () => changeSplitId(x.id),
                        selected: splitId == x.id,
                      );
                    }),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: CheckpointVariable.screenMargin,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: rankWidth,
                          child: Text('Rank', style: CheckpointStyle.bodyLarge),
                        ),
                        SizedBox(
                          width: bibWidth,
                          child: Text('BIB', style: CheckpointStyle.bodyLarge),
                        ),
                        SizedBox(
                          width: timeWidth,
                          child: Text('Time', style: CheckpointStyle.bodyLarge),
                        ),
                        SizedBox(
                          width: nameWidth,
                          child: Text('Name', style: CheckpointStyle.bodyLarge),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: CheckpointVariable.screenMargin,
                    ),
                    height: 1,
                    width: totalWidth,
                    color: CheckpointColor.divider,
                  ),
                  SizedBox(
                    height: totalWidth,
                    width: totalWidth + (CheckpointVariable.screenMargin * 2),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      itemCount: participantTime.length,
                      separatorBuilder:
                          (context, index) => Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: CheckpointVariable.screenMargin,
                            ),
                            height: 1,
                            width: 700,
                            color: CheckpointColor.divider,
                          ),
                      itemBuilder: (context, index) {
                        final part = participantTime[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: CheckpointVariable.screenMargin,
                            vertical: 12,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: rankWidth,
                                child: Text(
                                  (index + 1).toString(),
                                  style: CheckpointStyle.body,
                                ),
                              ),
                              SizedBox(
                                width: bibWidth,
                                child: Text(
                                  part.$1.bib,
                                  style: CheckpointStyle.body,
                                ),
                              ),
                              SizedBox(
                                width: timeWidth,
                                child: Text(
                                  formatTime(part.$2),
                                  style: CheckpointStyle.body,
                                ),
                              ),
                              SizedBox(
                                width: nameWidth,
                                child: Text(
                                  part.$1.name,
                                  style: CheckpointStyle.body,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatTime(DateTime? date) {
  if (date == null) return '--:--:--.--';

  return ResultScreen.formatter.format(date) + date.millisecond.toString();
}
