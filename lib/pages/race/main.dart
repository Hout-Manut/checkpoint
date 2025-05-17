import 'package:flutter/material.dart';
import 'package:checkpoint/components/app_bar.dart';
import 'package:checkpoint/components/navigator.dart';
import 'package:checkpoint/entities/enums/theme.dart';
import 'package:checkpoint/entities/enums/variable.dart';
import 'package:checkpoint/pages/race/dashboard.dart';
import 'package:checkpoint/pages/race/participant.dart';
import 'package:checkpoint/pages/race/result.dart';
import 'package:checkpoint/pages/race/tracker.dart';
import 'package:checkpoint/services/current_race_provider.dart';
import 'package:provider/provider.dart';

class RaceMainScreen extends StatefulWidget {
  final String raceId;
  const RaceMainScreen({super.key, required this.raceId});

  @override
  State<RaceMainScreen> createState() => _RaceMainScreenState();
}

class _RaceMainScreenState extends State<RaceMainScreen> {
  int selectedIndex = 0;
  static final List<Widget> pages = [
    RaceDashboardScreen(),
    ParticipantScreen(),
    TrackerScreen(),
    ResultScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    CurrentRaceProvider race = context.watch();
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          CheckpointAppBar.withTimer(titleText: race.name, startTime: race.startTime, finishTime: race.finishTime,),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 48,
              child: RaceNavigator(
                selectedIndex: selectedIndex,
                onSelect: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: CheckpointVariable.appBarBorderWidth,
              width: double.infinity,
              color: CheckpointColor.appBarBorder,
            ),
          ),
        ];
      },
      body: pages[selectedIndex],
    );
  }
}
