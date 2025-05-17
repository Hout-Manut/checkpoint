import 'package:checkpoint/entities/models/checkpoint_model.dart';

class CheckpointDto {
  static Checkpoint fromJson(String key, Map<String, dynamic> json) {
    List<SplitTime> times = [];

    for (final time in json.entries) {
      times.add(
        SplitTimeDto.fromJson(
          time.key,
          Map<String, dynamic>.from(time.value ?? {}),
        ),
      );
    }

    return Checkpoint(splitId: key, splitTimes: times, raceId: '');
  }

  static Map<String, dynamic> toJson(Checkpoint checkpoint) {
    Map<String, dynamic> data = {};

    for (SplitTime time in checkpoint.splitTimes) {
      data[time.bib] = SplitTimeDto.toJson(time);
    }
    return data;
  }
}

class SplitTimeDto {
  static SplitTime fromJson(String key, Map<String, dynamic> json) {
    int? time = json['time'];

    return SplitTime(
      bib: key,
      time:
          time == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(time),
    );
  }

  static Map<String, int> toJson(SplitTime time) {
    return {
      if (time.time != null)
        'time': time.time!.millisecondsSinceEpoch,

    };
  }
}
