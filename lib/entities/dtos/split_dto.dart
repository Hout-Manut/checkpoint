import 'package:checkpoint/entities/helpers/utils.dart';
import 'package:checkpoint/entities/models/race_split_model.dart';

class SplitDto {
  static RaceSplit fromJson(String key, Map<String, dynamic> json) {
    assert(json['name'] is String);
    assert(json['distance'] is int);
    assert(json['sport'] is String);

    return RaceSplit(
      id: key,
      name: json['name'],
      distance: (json['distance'] as int).toDouble(),
      sport: sportFromString(json['sport']!),
    );
  }

  static Map<String, dynamic> toJson(RaceSplit split) {
    return {
      'distance': split.distance,
      'name': split.name,
      'sport': split.sport.name,
    };
  }
}
