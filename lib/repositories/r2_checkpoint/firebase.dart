import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:checkpoint/entities/models/checkpoint_model.dart';
import 'package:checkpoint/repositories/r2_checkpoint/base.dart';

class FirebaseCheckpointRepo implements CheckpointRepo {
  final _db = FirebaseDatabase.instance.ref('checkpoints');
  final _rng = Random();
  @override
  Future<List<Checkpoint>> allCheckpoints(String raceId) async {
    // TODO: implement allCheckpoints
    throw UnimplementedError();
  }

  @override
  Future<String> create({
    required String raceId,
    required String splitId,
    required String? bib,
    required DateTime time,
  }) async {
    bib ??= generateTempBib();

    final ref = _db.child('$raceId/$splitId/$bib');

    final snapshot = await ref.get();

    if (snapshot.exists) {
      throw Exception("$bib already has tracked time for split $splitId");
    }

    _db.child('$raceId/$splitId/$bib').set({
      "time": time.millisecondsSinceEpoch,
    });

    return bib;
  }

  @override
  void delete({
    required String raceId,
    required String splitId,
    required String bib,
  }) {
    _db.child('$raceId/$splitId/$bib').remove();
  }

  @override
  void update({
    required String raceId,
    required String splitId,
    required String bib,
    String? newBib,
    DateTime? time,
  }) async {
    if (newBib != null) {
      final snapshot = await _db.child('$raceId/$splitId/$bib').get();
      if (snapshot.exists) {
        _db.child('$raceId/$splitId/$newBib').set({
          'time': (snapshot.value as Map)['time'],
        });
        await _db.child('$raceId/$splitId/$bib').remove();

        bib = newBib;
      } else {
        throw Exception('Cannot find checkpoint for bib $bib in split $splitId');
      }
    }

    if (time != null) {
      final snapshot = await _db.child('$raceId/$splitId/$bib').get();
      if (snapshot.exists) {
        _db.child('$raceId/$splitId/$bib').set({
          'time': time.millisecondsSinceEpoch,
        });
      } else {
        throw Exception('Cannot find checkpoint for bib $bib in split $splitId');
      }
    }
  }

  @override
  void watch({
    required String raceId,
    required void Function(List<Checkpoint> checkpoints) onChange,
  }) {
    _db.child(raceId).onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      List<Checkpoint> checkpoints = [];

      if (data is Map) {
        for (final splitTime in data.entries) {
          String splitId = splitTime.key;
          List<SplitTime> times = [];

          for (final time
              in Map<String, dynamic>.from(splitTime.value).entries) {
            times.add(
              SplitTime(
                bib: time.key,
                time: DateTime.fromMillisecondsSinceEpoch(time.value['time']!),
              ),
            );
          }
          checkpoints.add(
            Checkpoint(raceId: raceId, splitId: splitId, splitTimes: times),
          );
        }
      }
      onChange(checkpoints);
    });
  }

  String generateTempBib() {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    StringBuffer result = StringBuffer('_temp');

    for (int i = 0; i < 5; i++) {
      int randomIndex = _rng.nextInt(characters.length);
      result.write(characters[randomIndex]);
    }

    return result.toString();
  }
}
