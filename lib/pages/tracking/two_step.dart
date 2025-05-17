import 'package:flutter/material.dart';
import 'package:checkpoint/components/timer.dart';
import 'package:checkpoint/entities/enums/theme.dart';
import 'package:checkpoint/entities/enums/variable.dart';
import 'package:checkpoint/entities/models/checkpoint_model.dart';
import 'package:checkpoint/entities/models/participant_model.dart';
import 'package:checkpoint/entities/models/race_split_model.dart';
import 'package:checkpoint/pages/tracking/grid.dart';
import 'package:checkpoint/services/checkpoint_provider.dart';
import 'package:checkpoint/services/current_race_provider.dart';
import 'package:provider/provider.dart';

class TwoStepTrackingScreen extends StatefulWidget {
  final String splitId;
  const TwoStepTrackingScreen({super.key, required this.splitId});

  @override
  State<StatefulWidget> createState() => _TwoStepTrackingScreenState();
}

class _TwoStepTrackingScreenState extends State<TwoStepTrackingScreen> {
  bool tapped = false;

  void assignBib(SplitTime time) async {
    CurrentRaceProvider race = context.read<CurrentRaceProvider>();
    CheckpointProvider checkpoint = context.read<CheckpointProvider>();
    Participant? selected = await showModalBottomSheet<Participant>(
      context: context,
      backgroundColor: CheckpointColor.deepNeutral,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Material(
            color: Colors.transparent,
            child: GridView.count(
              padding: const EdgeInsets.all(0),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 171 / 64,
              children:
                  race.participants.map((item) {
                    bool alreadyTimed =
                        checkpoint.getTimeFor(
                          bib: item.bib,
                          splitId: widget.splitId,
                        ) !=
                        null;
                    return InkWell(
                      onTap:
                          alreadyTimed
                              ? null
                              : () {
                                Navigator.of(context).pop(item);
                              },
                      borderRadius: BorderRadius.circular(
                        CheckpointVariable.cardBorder + 1,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            CheckpointVariable.cardBorder + 1,
                          ),
                          border: Border.all(
                            color: CheckpointColor.deepNeutral,
                          ),
                          gradient:
                              alreadyTimed
                                  ? null
                                  : LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      const Color(0x80808A93),
                                      const Color(0x1A808A93),
                                    ],
                                  ),
                        ),
                        child: Container(
                          height: 64,
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color:
                                alreadyTimed
                                    ? null
                                    : CheckpointColor.deepNeutral,
                            borderRadius: BorderRadius.circular(
                              CheckpointVariable.cardBorder,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              item.bib,
                              textAlign: TextAlign.center,
                              style: CheckpointStyle.body,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        );
      },
    );

    if (selected == null) return;

    checkpoint.update(
      bib: time.bib,
      splitId: widget.splitId,
      newBib: selected.bib,
    );
  }

  @override
  Widget build(BuildContext context) {
    CurrentRaceProvider race = context.watch<CurrentRaceProvider>();
    CheckpointProvider checkpoint = context.watch<CheckpointProvider>();

    RaceSplit? split = race.currentRace?.getSplitById(widget.splitId);

    List<SplitTime> times = checkpoint.getSplitTimes(splitId: widget.splitId);

    times.sort(
      (a, b) => (b.time?.millisecondsSinceEpoch ?? double.infinity).compareTo(
        a.time?.millisecondsSinceEpoch ?? double.infinity,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder:
                      (context) => GridTrackingScreen(splitId: widget.splitId),
                ),
              );
            },
            icon: Icon(Icons.change_circle),
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Tap to Track', style: CheckpointStyle.subtitle),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.center,
                  height: 210,
                  width: 210,
                  child: GestureDetector(
                    onTapDown: (details) {
                      setState(() {
                        tapped = true;
                      });
                    },
                    onLongPressUp: () {
                      setState(() {
                        tapped = false;
                      });
                    },
                    onLongPressEnd: (detail) {
                      setState(() {
                        tapped = false;
                      });
                    },
                    onTapUp: (details) {
                      setState(() {
                        tapped = false;
                      });
                      checkpoint.create(bib: null, splitId: widget.splitId);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutCubic,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            CheckpointColor.primary,
                            CheckpointColor.deepPrimary,
                          ],
                        ),
                      ),
                      height: tapped ? 170 : 190,
                      width: tapped ? 170 : 190,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.3,
              maxChildSize: 0.9,
              snap: true,
              snapSizes: [0.6],
              shouldCloseOnMinExtent: false,
              snapAnimationDuration: const Duration(milliseconds: 100),

              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: CheckpointColor.deepNeutral,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: ListView(
                      controller: scrollController,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 17),
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 42,
                            height: 5,
                            decoration: BoxDecoration(
                              color: CheckpointColor.neutral,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: CheckpointVariable.screenMargin,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                split?.name ?? 'Unknown Split',
                                style: CheckpointStyle.title.copyWith(
                                  color: CheckpointColor.secondary,
                                ),
                              ),
                              CheckpointTimer(
                                startTime: race.startTime,
                                finishTime: race.finishTime,
                                style: CheckpointStyle.titleMonospace.copyWith(
                                  color: CheckpointColor.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: CheckpointVariable.screenMargin,
                            vertical: 12,
                          ),
                          child: Text(
                            'Checkpoints',
                            style: CheckpointStyle.subtitle,
                          ),
                        ),
                        Container(
                          height: 1,
                          color: CheckpointColor.neutral.withAlpha(150),
                          margin: EdgeInsets.symmetric(horizontal: 24),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: times.length,
                          separatorBuilder:
                              (context, index) => Container(
                                height: 1,
                                color: CheckpointColor.neutral.withAlpha(150),
                                margin: EdgeInsets.symmetric(horizontal: 24),
                              ),
                          itemBuilder: (context, index) {
                            final time = times[index];
                            String bib = time.bib;
                            bool isUnknown = false;
                            if (bib.startsWith('_temp')) {
                              bib = 'Tap to assign BIB';
                              isUnknown = true;
                            }
                            return InkWell(
                              onTap: () => assignBib(time),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: CheckpointVariable.screenMargin,
                                  vertical: 12,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      bib,
                                      style: CheckpointStyle.body.copyWith(
                                        color:
                                            isUnknown
                                                ? CheckpointColor.neutral
                                                : CheckpointColor.foreground,
                                      ),
                                    ),
                                    CheckpointTimer(
                                      startTime: race.startTime,
                                      finishTime: time.time,
                                      style: CheckpointStyle.body,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
