import 'package:checkpoint/models/checkpoint_model.dart';

class SplitTime {
  final String bib;
  final DateTime time;
  List<Checkpoint> splitTimes = [];

  SplitTime({required this.bib, required this.time});
}
