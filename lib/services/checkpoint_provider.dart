import 'package:flutter/material.dart';
import 'package:checkpoint/entities/models/checkpoint_model.dart';
import 'package:checkpoint/entities/models/participant_model.dart';
import 'package:checkpoint/repositories/r2_checkpoint/base.dart';

class CheckpointProvider extends ChangeNotifier {
  String? raceId;
  static late final CheckpointRepo repo;

  List<Checkpoint> checkpoints = [];

  CheckpointProvider([this.raceId]) {
    _listen();
  }

  static void initialize(CheckpointRepo repo) {
    CheckpointProvider.repo = repo;
  }

  void setRaceId(String? raceId) {
    this.raceId = raceId;
    _listen();
  }

  void _listen() {
    if (raceId == null) return;
    repo.watch(
      raceId: raceId!,
      onChange: (newCheckpoints) {
        checkpoints = newCheckpoints;
        notifyListeners();
      },
    );
  }

  List<SplitTime> getSplitTimes({required String splitId}) {
    for (final checkpoint in checkpoints) {
      if (checkpoint.splitId == splitId) return checkpoint.splitTimes;
    }
    return [];
  }

  SplitTime? getTimeFor({required String bib, required String splitId}) {
    for (final checkpoint in checkpoints) {
      if (checkpoint.splitId == splitId) {
        for (final time in checkpoint.splitTimes) {
          if (time.bib == bib) {
            return time;
          }
        }
        break;
      }
    }
    return null;
  }

  DateTime? getFinishedTimeFor({required String bib}) {
    int totalTime = 0;

    for (final checkpoint in checkpoints) {
      bool hasTime = false;
      for (final time in checkpoint.splitTimes) {
        if (time.bib == bib) {
          totalTime += time.time?.millisecondsSinceEpoch ?? 0;
          hasTime = true;
          continue;
        }
      }
      if (!hasTime) return null;
    }

    if (totalTime == 0) return null;

    return DateTime.fromMillisecondsSinceEpoch(totalTime);
  }

  SplitTime? getStartTimeFor({required String bib}) {
    for (final checkpoint in checkpoints) {
      if (checkpoint.splitId == '_start') {
        for (final time in checkpoint.splitTimes) {
          if (time.bib == bib) {
            return time;
          }
        }
        break;
      }
    }
    return null;
  }

  void startAll(List<Participant> participants, {DateTime? manualTime}) async {
    DateTime time = manualTime ?? DateTime.now();
    for (Participant participant in participants) {
      // if (participant.hasStarted) continue;
      start(bib: participant.bib, manualTime: time);
    }
  }

  void start({required String bib, DateTime? manualTime}) {
    if (raceId == null) return;
    DateTime time = manualTime ?? DateTime.now();
    repo.create(raceId: raceId!, bib: bib, time: time, splitId: '_start');
  }

  void create({
    required String? bib,
    required String splitId,
    DateTime? manualTime,
  }) {
    if (raceId == null) return;
    DateTime time = manualTime ?? DateTime.now();
    repo.create(raceId: raceId!, bib: bib, time: time, splitId: splitId);
  }

  void update({
    required String bib,
    required String splitId,
    String? newBib,
    DateTime? time,
  }) {
    if (raceId == null) return;
    repo.update(
      raceId: raceId!,
      splitId: splitId,
      bib: bib,
      newBib: newBib,
      time: time,
    );
  }

  void delete({required String bib, required String splitId}) {
    if (raceId == null) return;
    repo.delete(raceId: raceId!, splitId: splitId, bib: bib);
  }
}
