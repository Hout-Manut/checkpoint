import 'package:flutter/material.dart';
import 'package:checkpoint/entities/enums/race_state.dart';
import 'package:checkpoint/entities/models/participant_model.dart';
import 'package:checkpoint/entities/models/race_model.dart';
import 'package:checkpoint/entities/models/race_split_model.dart';
import 'package:checkpoint/repositories/r1_race/base.dart';

class CurrentRaceProvider extends ChangeNotifier {
  String? raceId;
  static late final RaceRepo repo;

  Race? currentRace;

  CurrentRaceProvider([this.raceId]) {
    _listen();
  }

  static void initialize(RaceRepo repo) {
    CurrentRaceProvider.repo = repo;
  }

  void setRaceId(String? raceId) {
    this.raceId = raceId;
    _listen();
  }

  void _listen() {
    if (raceId == null) return;
    repo.watch(
      raceId: raceId!,
      onChange: (race) {
        currentRace = race;
        notifyListeners();
      },
    );
  }

  void startRace() async {
    if (raceId == null) return;
    repo.start(raceId: raceId!, time: DateTime.now());
  }

  void finishRace() async {
    if (raceId == null) return;
    repo.finish(raceId: raceId!, time: DateTime.now());
  }

  String get name {
    if (currentRace == null) {
      return 'Unknown Race';
    }
    return currentRace!.name;
  }

  RaceState get state {
    if (currentRace == null) {
      return RaceState.notStarted;
    } else if (currentRace!.startTime == null) {
      return RaceState.notStarted;
    } else if (currentRace!.finishTime == null) {
      return RaceState.onGoing;
    }
    return RaceState.finished;
  }

  bool get notStarted => state == RaceState.notStarted;
  bool get started => state == RaceState.onGoing;

  DateTime? get startTime {
    if (currentRace == null) {
      return null;
    }
    return currentRace!.startTime;
  }

  DateTime? get finishTime {
    if (currentRace == null) {
      return null;
    }
    return currentRace!.finishTime;
  }

  List<RaceSplit> get splits {
    if (currentRace == null) {
      return [];
    }
    return currentRace!.splits;
  }

  List<Participant> get participants {
    if (currentRace == null) {
      return [];
    }
    return currentRace!.participants;
  }
}
