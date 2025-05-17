import 'package:checkpoint/entities/models/checkpoint_model.dart';

abstract class CheckpointRepo {
  Future<List<Checkpoint>> allCheckpoints(String raceId);

  void watch({
    required String raceId,
    required void Function(List<Checkpoint> checkpoints) onChange,
  });

  Future<String> create({
    required String raceId,
    required String splitId,
    required String? bib,
    required DateTime time,
  });

  void update({
    required String raceId,
    required String splitId,
    required String bib,
    String? newBib,
    DateTime? time,
  });

  void delete({
    required String raceId,
    required String splitId,
    required String bib,
  });
}
